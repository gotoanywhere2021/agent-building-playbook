#!/usr/bin/env bash
# Tests for .wiki/scripts/publish.sh (Palantir-style zh wiki renderer)
set -uo pipefail

# ── helpers ─────────────────────────────────────────────────────────────────

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PUBLISH="$REPO_ROOT/.wiki/scripts/publish.sh"

fail() {
    echo "FAIL: $*" >&2
    exit 1
}
assert_contains() { # file needle label
    grep -qF "$2" "$1" || fail "$3: expected to find '$2' in $1"
}

# ── temp workspace with cleanup ──────────────────────────────────────────────

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

PATTERNS="$WORK/patterns"
mkdir -p "$PATTERNS"

cat > "$PATTERNS/alpha-pattern.md" <<'EOF'
---
title: Alpha Pattern
one_liner: Alpha does the first thing clearly.
dimensions: meta-principles, reliability
---

## What it is

Alpha body text with `code`.
EOF

cat > "$PATTERNS/beta-pattern.md" <<'EOF'
---
title: Beta Pattern
one_liner: Beta handles the second case.
dimensions: taste, reliability
---

## What it is

Beta body.

- one bullet
EOF

cat > "$WORK/taxonomy.yaml" <<'EOF'
# GENERATED fixture
wheel:
  - family: "Mindset"
    gloss: "How to think."
    pattern_count: 2
    dimensions:
      - dimension: "meta-principles"
        pattern_count: 1
        patterns:
          - slug: "alpha-pattern"
            title: "Alpha Pattern"
            one_liner: "Alpha does the first thing clearly."
            also: ["reliability"]
      - dimension: "taste"
        pattern_count: 1
        patterns:
          - slug: "beta-pattern"
            title: "Beta Pattern"
            one_liner: "Beta handles the second case."
EOF

cat > "$WORK/zh.json" <<'EOF'
{
  "families": { "Mindset": { "name": "心智", "gloss": "如何思考。" } },
  "dimensions": { "meta-principles": "元原则" },
  "patterns": {
    "alpha-pattern": { "title": "阿尔法模式", "one_liner": "阿尔法把第一件事做清楚。" }
  }
}
EOF

mkdir -p "$WORK/zh-bodies"
cat > "$WORK/zh-bodies/alpha-pattern.md" <<'EOF'
## 这是什么（What it is）

阿尔法正文（中文版）。参见 `patterns/beta-pattern.md`。
EOF

WIKI="$WORK/wiki"
mkdir -p "$WIKI"

# ── 1. happy path: renders the full zh site ────────────────────────────────

bash "$PUBLISH" "$PATTERNS" "$WIKI" "$WORK/taxonomy.yaml" "$WORK/zh.json" \
    "$WORK/zh-bodies" >/dev/null 2>"$WORK/log.txt" || { cat "$WORK/log.txt" >&2; fail "publish.sh exited non-zero"; }

[[ -f "$WIKI/index.html" ]]       || fail "index.html not rendered"
[[ -f "$WIKI/explore.html" ]]     || fail "explore.html not rendered"
[[ -f "$WIKI/families/mindset.html" ]] || fail "families/mindset.html not rendered"
[[ -f "$WIKI/patterns/alpha-pattern.html" ]] || fail "patterns/alpha-pattern.html not rendered"
[[ -f "$WIKI/patterns/beta-pattern.html" ]]  || fail "patterns/beta-pattern.html not rendered"

# Palantir-style shell + zh UI on every page.
for page in index.html explore.html families/mindset.html patterns/alpha-pattern.html; do
    assert_contains "$WIKI/$page" 'lang="zh-CN"' "locale ($page)"
    assert_contains "$WIKI/$page" 'class="topbar"' "topbar ($page)"
    assert_contains "$WIKI/$page" 'class="sidebar"' "sidebar ($page)"
    assert_contains "$WIKI/$page" '智能体构建手册' "brand ($page)"
done

# Landing: family cards use zh name with English annotation; counts in zh.
assert_contains "$WIKI/index.html" '心智（Mindset）' "family card label"
assert_contains "$WIKI/index.html" '个模式' "zh pattern count"

# Catalog browser: rows carry a bilingual haystack and a live filter script.
assert_contains "$WIKI/explore.html" 'data-hay=' "filter haystack"
assert_contains "$WIKI/explore.html" '全部 2 个模式' "zh filter count baseline"
assert_contains "$WIKI/explore.html" '显示 ' "zh filtered count text"
assert_contains "$WIKI/explore.html" 'id="dim-taste"' "dimension anchor"

# Family page: breadcrumb back home, dimension sections (translated + fallback).
assert_contains "$WIKI/families/mindset.html" '首页（Home）' "breadcrumb home"
assert_contains "$WIKI/families/mindset.html" '元原则（meta-principles）' "dimension heading zh+en"
assert_contains "$WIKI/families/mindset.html" '>taste<' "dimension heading en fallback"

# Pattern page: zh title/one-liner when zh.json has them, English fallback when not.
assert_contains "$WIKI/patterns/alpha-pattern.html" '阿尔法模式' "zh pattern title"
assert_contains "$WIKI/patterns/alpha-pattern.html" '阿尔法把第一件事做清楚。' "zh one_liner"
assert_contains "$WIKI/patterns/alpha-pattern.html" 'Alpha Pattern' "en title kept as subtitle"
assert_contains "$WIKI/patterns/beta-pattern.html" 'Beta Pattern' "en fallback title"
assert_contains "$WIKI/patterns/beta-pattern.html" 'Beta handles the second case.' "en fallback one_liner"
assert_contains "$WIKI/patterns/alpha-pattern.html" '相关模式（Related patterns）' "related section"

# Translated body layer: zh body primary, English original collapsible.
assert_contains "$WIKI/patterns/alpha-pattern.html" '阿尔法正文（中文版）' "zh body rendered"
assert_contains "$WIKI/patterns/alpha-pattern.html" '英文原文（Original English）' "original toggle"
assert_contains "$WIKI/patterns/alpha-pattern.html" 'Alpha body text with' "en original kept"
assert_contains "$WIKI/patterns/alpha-pattern.html" 'id="what-it-is"' "zh heading anchor"
assert_contains "$WIKI/patterns/alpha-pattern.html" 'id="what-it-is-2"' "en heading anchor deduped"
if grep -qF '英文原文（Original English）' "$WIKI/patterns/beta-pattern.html"; then
    fail "beta has no zh body but shows the original toggle"
fi

# No wheel/sunburst remnants in the human view.
if grep -qiE 'sunburst|wheel-cta|explore the wheel' "$WIKI"/*.html; then
    fail "wheel remnants found in generated HTML"
fi

# ── 2. taxonomy drift fails loud ────────────────────────────────────────────

cat > "$WORK/taxonomy-drift.yaml" <<'EOF'
wheel:
  - family: "Mindset"
    gloss: "How to think."
    pattern_count: 1
    dimensions:
      - dimension: "meta-principles"
        pattern_count: 1
        patterns:
          - slug: "alpha-pattern"
            title: "Alpha Pattern"
            one_liner: "Alpha does the first thing clearly."
EOF

if bash "$PUBLISH" "$PATTERNS" "$WIKI" "$WORK/taxonomy-drift.yaml" "$WORK/zh.json" \
    >/dev/null 2>"$WORK/drift-log.txt"; then
    fail "publish.sh should fail on taxonomy drift, but exited 0"
fi
grep -qF "out of sync" "$WORK/drift-log.txt" || fail "drift error does not explain the cause"

# ── 3. malformed zh.json fails loud ─────────────────────────────────────────

echo '{ not json' > "$WORK/zh-broken.json"
if bash "$PUBLISH" "$PATTERNS" "$WIKI" "$WORK/taxonomy.yaml" "$WORK/zh-broken.json" \
    >/dev/null 2>"$WORK/zh-log.txt"; then
    fail "publish.sh should fail on malformed zh.json, but exited 0"
fi
grep -qF "zh copy layer" "$WORK/zh-log.txt" || fail "zh.json error does not name the file"

echo "PASS: publish.sh renders the zh Palantir-style wiki and fails loud on drift"
