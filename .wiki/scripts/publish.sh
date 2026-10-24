#!/usr/bin/env bash
# .wiki/scripts/publish.sh — render patterns/*.md into a static human-browsable
# HTML wiki under wiki/. Invoked by /wiki-publish.
#
# SOURCE   : patterns/*.md            (canonical, never modified)
#            wheel/taxonomy.yaml      (family>dimension tree, from build-wheel.py)
#            .wiki/context/zh.json    (human-curated zh copy layer; optional)
#            .wiki/context/zh-bodies/ (optional {slug}.md translated bodies;
#                                      shown as primary with the English
#                                      original collapsible below)
# OUTPUT   : wiki/index.html  (landing: family cards)
#            wiki/explore.html (pattern-catalog browser with live filter)
#            wiki/families/{family}.html
#            wiki/patterns/{kebab}.html
# PACKAGE  : .wiki/dist/agent-building-playbook-wiki.zip   (generated, gitignored)
#
# Presentation: Palantir-docs style — sticky topbar with search, persistent
# left sidebar over the family>dimension object tree, breadcrumbs, right-rail
# "On this page". UI is zh-CN; zh.json supplies Chinese family/dimension names
# and pattern title/one_liner translations (falls back to English per-entry).
# No sunburst/wheel in the human view.
#
# Portable: bash + python3 stdlib only (falls back to `python`). Fails loud.
set -euo pipefail

# Resolve repo root from this script's location (.wiki/scripts/ -> repo root).
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
cd "$REPO_ROOT"

PATTERNS_DIR="${1:-patterns}"
WIKI_DIR="${2:-wiki}"
TAXONOMY="${3:-wheel/taxonomy.yaml}"
ZH_DICT="${4:-.wiki/context/zh.json}"
ZH_BODIES="${5:-.wiki/context/zh-bodies}"
DIST_DIR=".wiki/dist"

PY=python3
if ! command -v python3 >/dev/null 2>&1; then
    if command -v python >/dev/null 2>&1; then
        PY=python
    else
        echo "ERROR: python3 (or python) is required but was not found on PATH." >&2
        exit 1
    fi
fi

if [[ ! -d "$PATTERNS_DIR" ]]; then
    echo "ERROR: source pattern directory not found: $PATTERNS_DIR" >&2
    exit 1
fi
if [[ ! -f "$TAXONOMY" ]]; then
    echo "ERROR: taxonomy not found: $TAXONOMY — run 'python scripts/build-wheel.py' first." >&2
    exit 1
fi
if [[ -n "$ZH_DICT" && ! -f "$ZH_DICT" ]]; then
    echo "ERROR: zh copy layer not found: $ZH_DICT" >&2
    exit 1
fi

echo "Rendering $PATTERNS_DIR -> $WIKI_DIR ..." >&2

# All rendering logic lives in the embedded stdlib-only Python program below.
PATTERNS_DIR="$PATTERNS_DIR" WIKI_DIR="$WIKI_DIR" TAXONOMY="$TAXONOMY" ZH_DICT="$ZH_DICT" ZH_BODIES="$ZH_BODIES" "$PY" - <<'PYEOF'
import html
import json
import os
import re
import sys
from pathlib import Path

patterns_dir = Path(os.environ["PATTERNS_DIR"])
wiki_dir = Path(os.environ["WIKI_DIR"])
taxonomy_path = Path(os.environ["TAXONOMY"])
zh_path = Path(os.environ["ZH_DICT"]) if os.environ.get("ZH_DICT") else None
zh_bodies_dir = Path(os.environ["ZH_BODIES"]) if os.environ.get("ZH_BODIES") else None

SITE_NAME = "智能体构建手册"
CSS = """
:root { --ink:#182430; --muted:#5b6b7b; --faint:#8a97a6; --line:#e2e8ef;
  --wash:#f5f7fa; --blue:#1a5fd0; --blue-d:#12449e; --chipbg:#edf1f7;
  --mono:ui-monospace,"Cascadia Mono","SF Mono",Consolas,monospace; }
* { box-sizing:border-box; }
html { scroll-behavior:smooth; }
body { margin:0; color:var(--ink); background:#fff;
  font:15px/1.75 -apple-system,"Segoe UI","PingFang SC","Hiragino Sans GB",
    "Microsoft YaHei","Noto Sans SC","Helvetica Neue",Helvetica,Arial,sans-serif;
  -webkit-font-smoothing:antialiased; }
a { color:var(--blue); text-decoration:none; }
a:hover { color:var(--blue-d); text-decoration:underline; }
:focus-visible { outline:2px solid var(--blue); outline-offset:2px; }
code { font-family:var(--mono); font-size:.88em; background:var(--wash);
  border:1px solid var(--line); border-radius:4px; padding:.06em .32em; }

/* ---- topbar ---- */
.topbar { position:sticky; top:0; z-index:40; display:flex; align-items:center;
  gap:14px; height:52px; padding:0 18px; background:#fff;
  border-bottom:1px solid var(--line); }
.brand { font-weight:700; letter-spacing:-.01em; color:var(--ink);
  font-size:15px; white-space:nowrap; }
.brand:hover { text-decoration:none; }
.navtoggle { display:none; }
.burger { display:none; font-size:15px; line-height:1; color:var(--ink);
  cursor:pointer; border:1px solid var(--line); border-radius:6px; padding:6px 10px; }
.qform { flex:1; max-width:420px; }
.qform input { width:100%; height:32px; padding:0 12px; font:inherit;
  font-size:13.5px; color:var(--ink); background:var(--wash);
  border:1px solid var(--line); border-radius:6px; }
.qform input:focus { outline:none; border-color:var(--blue); background:#fff; }
.toplinks { margin-left:auto; display:flex; gap:4px; }
.toplinks a { font-size:13.5px; color:var(--muted); padding:6px 10px; border-radius:6px; }
.toplinks a:hover { background:var(--wash); color:var(--ink); text-decoration:none; }
.toplinks a.on { color:var(--blue); font-weight:600; }

/* ---- shell: sidebar | main | toc ---- */
.shell { display:grid; grid-template-columns:272px minmax(0,1fr);
  max-width:1440px; margin:0 auto; }
.has-toc .shell { grid-template-columns:272px minmax(0,1fr) 212px; }
.sidebar { border-right:1px solid var(--line); background:#fff;
  padding:18px 12px 48px; position:sticky; top:52px;
  height:calc(100vh - 52px); overflow:auto; }
.side-label { font-size:11px; font-weight:700; letter-spacing:.08em;
  text-transform:uppercase; color:var(--faint); padding:0 10px 10px; }
.tree details { margin:1px 0; }
.tree summary { display:flex; align-items:center; gap:8px; cursor:pointer;
  list-style:none; padding:5px 10px; border-radius:6px; font-weight:600;
  font-size:13.5px; color:var(--ink); }
.tree summary::-webkit-details-marker { display:none; }
.tree summary::before { content:""; flex:0 0 auto; width:0; height:0;
  border-left:4px solid var(--faint); border-top:3.5px solid transparent;
  border-bottom:3.5px solid transparent; transition:transform .12s; }
.tree details[open] > summary::before { transform:rotate(90deg); }
.tree summary:hover { background:var(--wash); }
.tree .n { margin-left:auto; font-size:11px; color:var(--faint); font-weight:500; }
.tree .ov { display:block; font-size:12.5px; color:var(--muted);
  padding:2px 10px 4px 22px; }
.tree .dim > summary { margin-left:12px; font-weight:500; font-size:13px;
  color:#33414f; }
.tree .dim .leaf, .tree .dim .ov { margin-left:12px; }
.tree .leaf { display:block; font-size:13px; color:var(--muted);
  padding:3px 10px 3px 28px; border-radius:6px; line-height:1.5;
  border-left:2px solid transparent; }
.tree .leaf:hover { background:var(--wash); color:var(--ink); text-decoration:none; }
.tree .leaf.on { background:#eaf1fb; color:var(--blue); font-weight:600;
  border-left-color:var(--blue); }

/* ---- main ---- */
.main { padding:26px 34px 30px; min-width:0; }
.crumb { font-size:13px; color:var(--muted); margin:0 0 16px; }
.crumb a { color:var(--muted); }
.crumb a:hover { color:var(--blue); }
.crumb .sep { margin:0 7px; color:#b6c2cf; }
.crumb .here { color:var(--ink); font-weight:600; }
h1 { font-size:26px; line-height:1.3; letter-spacing:-.015em; margin:0 0 6px; }
.lede { color:var(--muted); font-size:15.5px; margin:0 0 14px; max-width:74ch; }
.chip { display:inline-block; font-size:11.5px; padding:2px 8px;
  background:var(--chipbg); color:#3c4a59; border-radius:4px;
  margin:0 4px 4px 0; }
.chip.solid { background:var(--blue); color:#fff; }
a.chip:hover { background:#dde7f5; text-decoration:none; }
article.body { max-width:76ch; }
article.body h2 { font-size:19px; margin:1.7em 0 .5em; }
article.body h3 { font-size:16px; margin:1.4em 0 .4em; }
article.body ul { padding-left:1.25rem; }
article.body li { margin:.3em 0; }
article.body table { border-collapse:collapse; margin:1em 0; width:100%; font-size:13.5px; }
article.body th, article.body td { border:1px solid var(--line); padding:6px 10px;
  text-align:left; vertical-align:top; }
article.body th { background:var(--wash); }

/* ---- landing ---- */
.hero { padding:20px 0 22px; border-bottom:1px solid var(--line); margin-bottom:28px; }
.kicker { font-size:11px; font-weight:700; letter-spacing:.1em;
  text-transform:uppercase; color:var(--blue); margin-bottom:8px; }
.stats { color:var(--muted); font-size:13.5px; margin:10px 0 18px; }
.stats b { color:var(--ink); }
.cta { display:flex; gap:10px; flex-wrap:wrap; margin:0 0 8px; }
.btn { display:inline-block; padding:8px 16px; background:var(--blue);
  color:#fff; border-radius:6px; font-weight:600; font-size:14px; }
.btn:hover { background:var(--blue-d); color:#fff; text-decoration:none; }
.btn.ghost { background:#fff; color:var(--blue); border:1px solid var(--line); }
.btn.ghost:hover { border-color:var(--blue); background:var(--wash); }
.fam-grid { display:grid; grid-template-columns:repeat(auto-fill,minmax(300px,1fr));
  gap:14px; margin:14px 0 8px; }
.famcard { display:block; border:1px solid var(--line); border-radius:8px;
  padding:16px 18px; color:inherit; background:#fff; }
.famcard:hover { border-color:var(--blue); text-decoration:none; }
.fc-head { display:flex; justify-content:space-between; align-items:baseline; gap:8px; }
.fc-name { font-weight:700; font-size:16px; }
.fc-count { color:var(--faint); font-weight:500; font-size:12.5px; white-space:nowrap; }
.fc-gloss { display:block; color:var(--muted); font-size:13.5px; margin:6px 0 10px; }

/* ---- catalog rows (explore / family pages / related) ---- */
.bigsearch { width:100%; max-width:520px; height:36px; padding:0 12px;
  font:inherit; border:1px solid var(--line); border-radius:6px; }
.bigsearch:focus { outline:none; border-color:var(--blue); }
.count { color:var(--muted); font-size:13px; margin:8px 0 4px; }
.fam-sec { margin:1.4em 0 .6em; }
.fam-sec > h2 { font-size:18px; margin:.9em 0 .1em; }
.fam-sec .fam-gloss { color:var(--muted); font-size:13.5px; margin:0 0 .2em; }
.dim-sec h3, .fam-sec h3 { font-size:14px; font-weight:600; color:#33414f;
  margin:1.1em 0 .35em; }
h2 .n, h3 .n { font-size:11.5px; color:var(--faint); font-weight:500;
  margin-left:6px; }
ul.rows { list-style:none; padding:0; margin:.3rem 0 1rem; }
ul.rows li { padding:10px 12px; border:1px solid var(--line); border-radius:6px;
  margin:0 0 8px; background:#fff; }
ul.rows li:hover { border-color:#9fb8d8; background:var(--wash); }
ul.rows .rt { font-weight:600; font-size:14px; display:block; }
ul.rows .ol { display:block; color:var(--muted); font-size:13px; margin-top:2px; }
ul.rows .chips { display:block; margin-top:6px; }

/* ---- related + toc rail ---- */
.related { margin-top:2.4em; padding-top:1.2em; border-top:1px solid var(--line); max-width:76ch; }
.related h2 { font-size:15px; margin:.2em 0 .5em; }

/* ---- collapsible English original under a translated body ---- */
details.original { margin-top:1.8em; border-top:1px dashed var(--line);
  padding-top:1em; max-width:76ch; }
details.original > summary { cursor:pointer; color:var(--muted);
  font-size:13px; font-weight:600; list-style:none; }
details.original > summary::-webkit-details-marker { display:none; }
details.original > summary::before { content:"▸ "; }
details.original[open] > summary::before { content:"▾ "; }
details.original > summary:hover { color:var(--blue); }
details.original article { color:#44515f; font-size:14px; margin-top:.6em; }
.toc { display:none; }
.has-toc .toc { display:block; position:sticky; top:52px;
  height:calc(100vh - 52px); overflow:auto; padding:26px 10px 48px 20px;
  border-left:1px solid var(--line); }
.toc-label { font-size:11px; font-weight:700; letter-spacing:.08em;
  text-transform:uppercase; color:var(--faint); margin-bottom:8px; }
.toc ul { list-style:none; padding:0; margin:0; }
.toc a { display:block; font-size:12.5px; color:var(--muted); padding:3px 0; }
.toc a:hover { color:var(--blue); text-decoration:none; }
.toc .l3 a { padding-left:12px; }

.foot { border-top:1px solid var(--line); margin-top:34px; padding:16px 34px 34px;
  color:var(--muted); font-size:12.5px; max-width:1440px; margin-left:auto; margin-right:auto; }

@media (max-width:1220px) {
  .has-toc .shell { grid-template-columns:272px minmax(0,1fr); }
  .has-toc .toc { display:none; }
}
@media (max-width:960px) {
  .burger { display:inline-flex; }
  .toplinks { display:none; }
  .shell, .has-toc .shell { grid-template-columns:minmax(0,1fr); }
  .sidebar { position:fixed; left:0; top:52px; bottom:0; width:284px;
    transform:translateX(-100%); transition:transform .18s; z-index:30;
    box-shadow:0 8px 24px rgba(24,36,48,.12); }
  .navtoggle:checked ~ .shell .sidebar { transform:none; }
  .main { padding:20px 18px 24px; }
  .foot { padding:16px 18px 30px; }
}
"""

FILTER_JS = """
<script>
(function () {
  var q = document.getElementById('q');
  if (!q) { return; }
  var items = Array.prototype.slice.call(document.querySelectorAll('ul.rows > li'));
  var fams = Array.prototype.slice.call(document.querySelectorAll('.fam-sec'));
  var count = document.getElementById('count');
  var total = items.length;
  function apply(v) {
    v = v.trim().toLowerCase();
    var shown = 0;
    items.forEach(function (li) {
      var hit = !v || li.getAttribute('data-hay').indexOf(v) !== -1;
      li.style.display = hit ? '' : 'none';
      if (hit) { shown += 1; }
    });
    fams.forEach(function (sec) {
      var any = false;
      sec.querySelectorAll('ul.rows > li').forEach(function (li) {
        if (li.style.display !== 'none') { any = true; }
      });
      sec.style.display = any ? '' : 'none';
    });
    if (count) {
      count.textContent = v
        ? '显示 ' + shown + ' / 共 ' + total + ' 个模式（pattern）'
        : '全部 ' + total + ' 个模式（pattern）';
    }
  }
  var m = location.hash.match(/^#q=(.*)$/);
  var initial = new URLSearchParams(location.search).get('q')
    || (m ? decodeURIComponent(m[1]) : '');
  if (initial) { q.value = initial; }
  q.addEventListener('input', function () {
    apply(q.value);
    history.replaceState(null, '', q.value ? '#q=' + encodeURIComponent(q.value) : '#');
  });
  apply(initial || '');
})();
</script>
"""


def slugify(text: str) -> str:
    text = text.strip().lower()
    text = re.sub(r"[^a-z0-9]+", "-", text)
    return text.strip("-")


def yaml_unescape(s: str) -> str:
    out, i = [], 0
    while i < len(s):
        if s[i] == "\\" and i + 1 < len(s):
            out.append(s[i + 1])
            i += 2
        else:
            out.append(s[i])
            i += 1
    return "".join(out)


def _quoted(line: str) -> str:
    m = re.search(r':\s*"(.*)"\s*$', line)
    return yaml_unescape(m.group(1)) if m else ""


def parse_taxonomy(path: Path) -> list[dict]:
    """Parse the generated wheel/taxonomy.yaml (fixed emit_yaml shape).

    Returns [{family, gloss, dims: [{name, patterns: [pattern dict]}]}].
    Fails loud on missing sections or malformed lines.
    """
    tree: list[dict] = []
    fam = dim = pat = None
    for ln_no, raw in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        line = raw.rstrip()
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        if re.match(r'^\s*- family: "', line):
            fam = {"family": _quoted(line), "gloss": "", "dims": []}
            tree.append(fam)
            continue
        if fam is None:
            continue
        if re.match(r"^\s+gloss: ", line):
            fam["gloss"] = _quoted(line)
        elif re.match(r'^\s+- dimension: "', line):
            dim = {"name": _quoted(line), "patterns": []}
            fam["dims"].append(dim)
        elif re.match(r'^\s+- slug: "', line):
            if dim is None:
                raise SystemExit(f"ERROR: {path}:{ln_no} slug outside a dimension.")
            pat = {"slug": _quoted(line), "title": "", "one_liner": "", "also": []}
            dim["patterns"].append(pat)
        elif re.match(r"^\s+(title|one_liner): ", line) and pat is not None:
            key = "title" if "title:" in line else "one_liner"
            pat[key] = _quoted(line)
        elif re.match(r"^\s+also: \[", line) and pat is not None:
            inner = line.split("[", 1)[1].rsplit("]", 1)[0]
            pat["also"] = [yaml_unescape(x.strip().strip('"')) for x in inner.split(",") if x.strip()]
    if not tree:
        raise SystemExit(f"ERROR: {path} contains no family entries — regenerate it.")
    return tree


def load_zh(path: Path | None):
    """Load the human-curated zh copy layer. Missing entries fall back to
    English at the call sites; a malformed file fails loud."""
    if path is None:
        return {}, {}, {}
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, ValueError) as e:
        raise SystemExit(f"ERROR: cannot read zh copy layer {path}: {e}")
    return (
        data.get("families", {}),
        data.get("dimensions", {}),
        data.get("patterns", {}),
    )


ZH_FAMILIES, ZH_DIMENSIONS, ZH_PATTERNS = load_zh(zh_path)


def load_zh_bodies(path: Path | None) -> dict[str, str]:
    """Optional per-pattern translated bodies: one {slug}.md file each,
    containing the translated markdown body only (no frontmatter)."""
    if path is None or not path.is_dir():
        return {}
    out: dict[str, str] = {}
    for f in sorted(path.glob("*.md")):
        text = f.read_text(encoding="utf-8").strip()
        if text:
            out[f.stem] = text
    return out


ZH_BODIES = load_zh_bodies(zh_bodies_dir)


def fam_pair(en: str) -> str:
    zh = ZH_FAMILIES.get(en, {}).get("name")
    return f"{zh}（{en}）" if zh else en


def fam_short(en: str) -> str:
    return ZH_FAMILIES.get(en, {}).get("name") or en


def fam_gloss(en: str, fallback: str) -> str:
    return ZH_FAMILIES.get(en, {}).get("gloss") or fallback


def dim_pair(en: str) -> str:
    zh = ZH_DIMENSIONS.get(en)
    return f"{zh}（{en}）" if zh else en


def dim_short(en: str) -> str:
    return ZH_DIMENSIONS.get(en) or en


def pat_title(p: dict) -> str:
    return ZH_PATTERNS.get(p["slug"], {}).get("title") or p["title"]


def pat_ol(p: dict) -> str:
    return ZH_PATTERNS.get(p["slug"], {}).get("one_liner") or p["one_liner"]


def parse_pattern(path: Path) -> dict:
    """Split flat frontmatter from body. Fail loud on malformed files."""
    raw = path.read_text(encoding="utf-8")
    m = re.match(r"^---\n(.*?)\n---\n?(.*)$", raw, re.DOTALL)
    if not m:
        raise SystemExit(f"ERROR: {path} is missing a frontmatter block.")
    front_text, body = m.group(1), m.group(2)
    front = {}
    for line in front_text.splitlines():
        if not line.strip() or ":" not in line:
            continue
        key, _, val = line.partition(":")
        front[key.strip()] = val.strip()
    for required in ("title", "one_liner", "dimensions"):
        if not front.get(required):
            raise SystemExit(f"ERROR: {path} missing required frontmatter field: {required}")
    dims = [d.strip() for d in front["dimensions"].split(",") if d.strip()]
    return {
        "slug": path.stem,
        "title": front["title"],
        "one_liner": front["one_liner"],
        "dimensions": dims,
        "body": body.strip(),
    }


_INLINE_LINK = re.compile(r"\[([^\]]+)\]\(([^)]+)\)")
_INLINE_CODE = re.compile(r"`([^`]+)`")
_INLINE_BOLD = re.compile(r"\*\*([^*]+)\*\*")


def render_inline(text: str) -> str:
    """Escape, then re-apply a safe markdown inline subset."""
    text = html.escape(text)
    text = _INLINE_CODE.sub(lambda m: f"<code>{m.group(1)}</code>", text)
    text = _INLINE_BOLD.sub(lambda m: f"<strong>{m.group(1)}</strong>", text)

    def link(m):
        label, url = m.group(1), m.group(2)
        safe = url if re.match(r"^(https?:|#|/|\.)", url) else "#"
        return f'<a href="{safe}">{label}</a>'

    text = _INLINE_LINK.sub(link, text)
    return text


def render_markdown(body: str, used: set[str] | None = None) -> tuple[str, list[dict]]:
    """Minimal stdlib markdown -> HTML for the pattern body subset.

    Handles: ##/### headings (with generated anchor ids), '- ' lists,
    paragraphs, and the inline subset. Returns (html, toc) where toc is
    [{level, text, anchor}] in document order. `used` lets callers share the
    anchor namespace across several bodies (e.g. zh + original English).
    """
    out: list[str] = []
    toc: list[dict] = []
    if used is None:
        used = set()
    lines = body.splitlines()
    i = 0
    para: list[str] = []

    def flush_para():
        if para:
            out.append(f"<p>{render_inline(' '.join(para).strip())}</p>")
            para.clear()

    def anchor_for(text: str) -> str:
        base = slugify(text) or "section"
        anchor, n = base, 2
        while anchor in used:
            anchor = f"{base}-{n}"
            n += 1
        used.add(anchor)
        return anchor

    while i < len(lines):
        line = lines[i]
        stripped = line.strip()
        if not stripped:
            flush_para()
            i += 1
            continue
        h = re.match(r"^(#{1,6})\s+(.*)$", stripped)
        if h:
            flush_para()
            level = min(len(h.group(1)) + 1, 6)  # demote so page <h1> stays unique
            text = h.group(2)
            anchor = anchor_for(re.sub(r"[`*_]", "", text))
            out.append(f'<h{level} id="{anchor}">{render_inline(text)}</h{level}>')
            if level <= 3:
                toc.append({"level": level, "text": text, "anchor": anchor})
            i += 1
            continue
        if stripped.startswith("|"):
            flush_para()
            rows: list[list[str]] = []
            while i < len(lines) and lines[i].strip().startswith("|"):
                cells = [c.strip() for c in lines[i].strip().strip("|").split("|")]
                rows.append(cells)
                i += 1
            head = None
            if len(rows) >= 2 and all(
                re.fullmatch(r":?-+:?", c or "-") for c in rows[1]
            ):
                head, rows = rows[0], rows[2:]
            table = ""
            if head is not None:
                table += (
                    "<thead><tr>"
                    + "".join(f"<th>{render_inline(c)}</th>" for c in head)
                    + "</tr></thead>"
                )
            if rows:
                table += (
                    "<tbody>"
                    + "".join(
                        "<tr>"
                        + "".join(f"<td>{render_inline(c)}</td>" for c in r)
                        + "</tr>"
                        for r in rows
                    )
                    + "</tbody>"
                )
            out.append("<table>" + table + "</table>")
            continue
        if re.match(r"^[-*]\s+", stripped):
            flush_para()
            items = []
            while i < len(lines) and re.match(r"^\s*[-*]\s+", lines[i]):
                item = re.sub(r"^\s*[-*]\s+", "", lines[i])
                items.append(f"<li>{render_inline(item)}</li>")
                i += 1
            out.append("<ul>" + "".join(items) + "</ul>")
            continue
        para.append(stripped)
        i += 1
    flush_para()
    return "\n".join(out), toc


def build_sidebar(tree: list[dict], prefix: str, *, open_all: bool,
                  active_slug: str = "", active_family: str = "") -> str:
    """Left nav over the family > dimension > pattern tree (zh labels)."""
    parts = ['<div class="side-label">目录（Catalog）</div>', '<nav class="tree">']
    for fam in tree:
        contains_active = any(
            p["slug"] == active_slug for d in fam["dims"] for p in d["patterns"]
        )
        open_attr = " open" if (open_all or contains_active or fam["family"] == active_family) else ""
        fslug = slugify(fam["family"])
        n = sum(len(d["patterns"]) for d in fam["dims"])
        parts.append(f'<details class="fam"{open_attr}>')
        parts.append(
            f'<summary title="{html.escape(fam["family"])}">'
            f"<span>{html.escape(fam_short(fam['family']))}</span>"
            f'<span class="n">{n}</span></summary>'
        )
        parts.append(f'<a class="ov" href="{prefix}families/{fslug}.html">总览（Overview）</a>')
        for d in fam["dims"]:
            d_contains = any(p["slug"] == active_slug for p in d["patterns"])
            d_open = " open" if (open_all or d_contains) else ""
            parts.append(f'<details class="dim"{d_open}>')
            parts.append(
                f'<summary title="{html.escape(d["name"])}">'
                f"<span>{html.escape(dim_short(d['name']))}</span>"
                f'<span class="n">{len(d["patterns"])}</span></summary>'
            )
            for p in d["patterns"]:
                cls = "leaf on" if p["slug"] == active_slug else "leaf"
                parts.append(
                    f'<a class="{cls}" title="{html.escape(p["title"])}" '
                    f'href="{prefix}patterns/{p["slug"]}.html">'
                    f"{html.escape(pat_title(p))}</a>"
                )
            parts.append("</details>")
        parts.append("</details>")
    parts.append("</nav>")
    return "\n".join(parts)


def breadcrumb(crumbs: list[tuple[str, str]], prefix: str) -> str:
    """crumbs: [(label, href|None)] — last item renders as the current page."""
    parts = ['<nav class="crumb" aria-label="Breadcrumb">']
    for idx, (label, href) in enumerate(crumbs):
        if idx:
            parts.append('<span class="sep">›</span>')
        label_html = html.escape(label)
        if href and idx < len(crumbs) - 1:
            parts.append(f'<a href="{prefix}{href}">{label_html}</a>')
        else:
            parts.append(f'<span class="here">{label_html}</span>')
    parts.append("</nav>")
    return "".join(parts)


def toc_rail(toc: list[dict]) -> str:
    if len(toc) < 2:
        return ""
    items = []
    for t in toc:
        cls = f"l{t['level']}"
        items.append(
            f'<li class="{cls}"><a href="#{t["anchor"]}">{html.escape(t["text"])}</a></li>'
        )
    return (
        '<aside class="toc"><div class="toc-label">本页内容（On this page）</div>'
        "<ul>" + "".join(items) + "</ul></aside>"
    )


def page(title: str, depth: int, crumb: str, content: str, *,
         tree_html: str, toc: list[dict] | None = None, active: str = "") -> str:
    prefix = "../" * depth
    body_cls = "has-toc" if toc and len(toc) >= 2 else ""
    return f"""<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{html.escape(title)} · {SITE_NAME}</title>
<style>{CSS}</style>
</head>
<body class="{body_cls}">
<input type="checkbox" id="navtoggle" class="navtoggle" aria-hidden="true">
<header class="topbar">
<label class="burger" for="navtoggle" aria-label="切换导航">☰</label>
<a class="brand" title="Agent-Building Playbook" href="{prefix}index.html">{SITE_NAME}</a>
<form class="qform" action="{prefix}explore.html" role="search">
  <input type="search" name="q" placeholder="搜索模式（Search patterns）…" aria-label="搜索模式">
</form>
<nav class="toplinks">
  <a href="{prefix}index.html"{' class="on"' if active == "home" else ""}>首页（Home）</a>
  <a href="{prefix}explore.html"{' class="on"' if active == "explore" else ""}>浏览（Browse）</a>
  <a href="https://github.com/ramparte/agent-building-playbook">GitHub ↗</a>
</nav>
</header>
<div class="shell">
<aside class="sidebar" aria-label="模式目录">
{tree_html}
</aside>
<main class="main">
{crumb}
{content}
</main>
{toc_rail(toc) if toc else ""}
</div>
<footer class="foot">本站由 <code>patterns/</code> 生成（生成器：<code>.wiki/scripts/publish.sh</code>），请勿手改；
使用 <code>/wiki-publish</code> 重新生成。&middot; <a href="{prefix}index.html">首页</a>
&middot; <a href="{prefix}explore.html">浏览目录</a></footer>
</body>
</html>
"""


def pattern_row(p: dict, prefix: str, base_prefix: str = "") -> str:
    """prefix: prefix for explore anchors; base_prefix: prefix for pattern links."""
    chips = "".join(
        f'<a class="chip" title="{html.escape(t)}" '
        f'href="{prefix}explore.html#dim-{slugify(t)}">{html.escape(dim_pair(t))}</a>'
        for t in p["dimensions"]
    )
    hay = " ".join(
        [p["title"], pat_title(p), p["one_liner"], pat_ol(p), " ".join(p["dimensions"]),
         " ".join(dim_short(t) for t in p["dimensions"])]
    ).lower()
    return (
        f'<li data-hay="{html.escape(hay, quote=True)}">'
        f'<a class="rt" href="{base_prefix}patterns/{p["slug"]}.html">{html.escape(pat_title(p))}</a>'
        f'<span class="ol">{html.escape(pat_ol(p))}</span>'
        f'<span class="chips">{chips}</span></li>'
    )


def main():
    files = sorted(patterns_dir.glob("*.md"))
    if not files:
        raise SystemExit(f"ERROR: no pattern files found in {patterns_dir}")

    patterns = [parse_pattern(p) for p in files]
    by_slug = {p["slug"]: p for p in patterns}

    tree = parse_taxonomy(taxonomy_path)
    tax_slugs = [p["slug"] for fam in tree for d in fam["dims"] for p in d["patterns"]]
    missing = sorted(set(by_slug) - set(tax_slugs))
    extra = sorted(set(tax_slugs) - set(by_slug))
    dupes = sorted({s for s in tax_slugs if tax_slugs.count(s) > 1})
    if missing or extra or dupes:
        raise SystemExit(
            f"ERROR: {taxonomy_path} is out of sync with {patterns_dir}/ "
            f"(missing: {missing or '—'}; unknown: {extra or '—'}; "
            f"duplicated: {dupes or '—'}). Run scripts/build-wheel.py and re-publish."
        )
    for fam in tree:
        for d in fam["dims"]:
            for entry in d["patterns"]:
                entry.update(by_slug[entry["slug"]])  # attach body/dimensions/etc.

    total = len(patterns)
    fam_count = len(tree)
    dim_count = sum(len(fam["dims"]) for fam in tree)

    # Reset generated output dirs (leave wiki/README.md in place).
    for sub in ("patterns", "families"):
        out_dir = wiki_dir / sub
        if out_dir.exists():
            for f in out_dir.glob("*.html"):
                f.unlink()
        out_dir.mkdir(parents=True, exist_ok=True)

    # ---- Landing page ----
    cards = []
    for fam in tree:
        fslug = slugify(fam["family"])
        n = sum(len(d["patterns"]) for d in fam["dims"])
        dim_chips = "".join(
            f'<span class="chip" title="{html.escape(d["name"])}">'
            f"{html.escape(dim_short(d['name']))}</span>" for d in fam["dims"]
        )
        cards.append(
            f'<a class="famcard" href="families/{fslug}.html">'
            f'<span class="fc-head"><span class="fc-name">{html.escape(fam_pair(fam["family"]))}</span>'
            f'<span class="fc-count">{n} 个模式</span></span>'
            f'<span class="fc-gloss">{html.escape(fam_gloss(fam["family"], fam["gloss"]))}</span>'
            f'<span class="fc-dims">{dim_chips}</span></a>'
        )
    home_content = (
        '<section class="hero">'
        '<div class="kicker">模式目录（Pattern Catalog）</div>'
        f"<h1>{SITE_NAME}</h1>"
        '<p class="lede">面向智能体（agentic）时代的构建方法手册（Agent-Building Playbook）——'
        "每个模式（pattern）都是一篇凝练的『珍珠』短文，按 家族（Family）› 维度（Dimension）"
        "的树形结构浏览。</p>"
        f'<p class="stats"><b>{total}</b> 个模式（pattern）&middot; '
        f"<b>{fam_count}</b> 个家族（family）&middot; "
        f"<b>{dim_count}</b> 个维度（dimension）</p>"
        '<div class="cta">'
        '<a class="btn" href="explore.html">浏览目录（Browse）</a>'
        '<a class="btn ghost" href="https://github.com/ramparte/agent-building-playbook">'
        "到 GitHub 贡献（Contribute）↗</a></div>"
        "</section>"
        "<h2>家族（Families）</h2>"
        '<p class="lede">六个家族（family）组织起整个目录；每个家族展开为若干维度'
        "（dimension），维度下是具体的模式（pattern）。</p>"
        '<div class="fam-grid">' + "".join(cards) + "</div>"
    )
    sidebar_home = build_sidebar(tree, "", open_all=False)
    (wiki_dir / "index.html").write_text(
        page(SITE_NAME, 0, "", home_content,
             tree_html=sidebar_home, active="home"),
        encoding="utf-8",
    )

    # ---- Catalog browser (replaces the old sunburst wheel) ----
    secs = []
    for fam in tree:
        fslug = slugify(fam["family"])
        n = sum(len(d["patterns"]) for d in fam["dims"])
        dims_html = []
        for d in fam["dims"]:
            rows = "".join(pattern_row(p, "") for p in d["patterns"])
            dims_html.append(
                f'<section class="dim-sec" id="dim-{slugify(d["name"])}">'
                f'<h3>{html.escape(dim_pair(d["name"]))}'
                f'<span class="n">{len(d["patterns"])}</span></h3>'
                f'<ul class="rows">{rows}</ul></section>'
            )
        secs.append(
            '<section class="fam-sec">'
            f'<h2><a href="families/{fslug}.html">{html.escape(fam_pair(fam["family"]))}</a>'
            f'<span class="n">{n}</span></h2>'
            f'<p class="fam-gloss">{html.escape(fam_gloss(fam["family"], fam["gloss"]))}</p>'
            + "".join(dims_html) + "</section>"
        )
    explore_content = (
        "<h1>模式目录（Pattern Catalog）</h1>"
        f'<p class="lede">全部 {total} 个模式（pattern），按 家族（family）与 '
        "维度（dimension）分组；输入即筛选，支持中英文关键词。</p>"
        '<input class="bigsearch" id="q" type="search" '
        'placeholder="按标题、摘要或维度筛选（Filter）…" '
        'aria-label="筛选模式" autocomplete="off">'
        '<p class="count" id="count">全部 ' + str(total) + " 个模式（pattern）</p>"
        + "".join(secs) + FILTER_JS
    )
    sidebar_all = build_sidebar(tree, "", open_all=True)
    (wiki_dir / "explore.html").write_text(
        page("模式目录（Pattern Catalog）", 0,
             breadcrumb([("首页（Home）", "index.html")], ""), explore_content,
             tree_html=sidebar_all, active="explore"),
        encoding="utf-8",
    )

    # ---- One page per family ----
    for fam in tree:
        fslug = slugify(fam["family"])
        n = sum(len(d["patterns"]) for d in fam["dims"])
        secs = []
        for d in fam["dims"]:
            rows = "".join(pattern_row(p, "../", base_prefix="../") for p in d["patterns"])
            secs.append(
                f'<section class="dim-sec" id="dim-{slugify(d["name"])}">'
                f'<h2>{html.escape(dim_pair(d["name"]))}'
                f'<span class="n">{len(d["patterns"])}</span></h2>'
                f'<ul class="rows">{rows}</ul></section>'
            )
        content = (
            '<section class="hero">'
            f"<h1>{html.escape(fam_pair(fam['family']))}</h1>"
            f'<p class="lede">{html.escape(fam_gloss(fam["family"], fam["gloss"]))}</p>'
            f'<p class="stats"><b>{n}</b> 个模式（pattern）&middot; '
            f"<b>{len(fam['dims'])}</b> 个维度（dimension）</p>"
            "</section>"
            + "".join(secs)
        )
        crumb = breadcrumb(
            [("首页（Home）", "index.html"), (fam_pair(fam["family"]), None)], "../"
        )
        sidebar_fam = build_sidebar(tree, "../", open_all=False, active_family=fam["family"])
        (wiki_dir / "families" / f"{fslug}.html").write_text(
            page(fam_pair(fam["family"]), 1, crumb, content,
                 tree_html=sidebar_fam, active="explore"),
            encoding="utf-8",
        )

    # ---- One page per pattern ----
    # Turn `patterns/{slug}.md` code-span references (used in the "Related"
    # section) into real links to the rendered sibling page, preserving the
    # original displayed text. Leave unknown slugs untouched.
    rel_re = re.compile(r"<code>patterns/([a-z0-9-]+)\.md</code>")

    def link_related(m):
        slug = m.group(1)
        if slug in by_slug:
            return f'<a href="{slug}.html">{m.group(0)}</a>'
        return m.group(0)

    for fam in tree:
        for d in fam["dims"]:
            for p in d["patterns"]:
                anchors: set[str] = set()  # shared so zh/en heading ids never collide
                zh_body = ZH_BODIES.get(p["slug"])
                if zh_body:
                    body_html, toc = render_markdown(zh_body, anchors)
                    orig_html, _ = render_markdown(p["body"], anchors)
                    body_html = rel_re.sub(link_related, body_html)
                    orig_html = rel_re.sub(link_related, orig_html)
                    body_block = (
                        f'<article class="body">{body_html}</article>'
                        '<details class="original">'
                        "<summary>英文原文（Original English）</summary>"
                        f"<article>{orig_html}</article></details>"
                    )
                else:
                    body_html, toc = render_markdown(p["body"], anchors)
                    body_html = rel_re.sub(link_related, body_html)
                    body_block = f'<article class="body">{body_html}</article>'

                # The body's own curated "## Related" wins over the computed one.
                if re.search(r"^##\s+Related\b", p["body"], re.M):
                    related = ""
                else:
                    # Related patterns: ranked by shared dimensions.
                    scored = []
                    for q in patterns:
                        if q["slug"] == p["slug"]:
                            continue
                        shared = set(q["dimensions"]) & set(p["dimensions"])
                        if shared:
                            scored.append((-len(shared), q["title"].lower(), q))
                    rel_rows = "".join(
                        f'<li><a class="rt" href="{q["slug"]}.html">{html.escape(pat_title(q))}</a>'
                        f'<span class="ol">{html.escape(pat_ol(q))}</span></li>'
                        for _, _, q in sorted(scored)[:5]
                    )
                    related = (
                        '<section class="related"><h2>相关模式（Related patterns）</h2>'
                        f'<ul class="rows">{rel_rows}</ul></section>' if rel_rows else ""
                    )

                chips = (
                    f'<span class="chip solid" title="{html.escape(d["name"])}">'
                    f"{html.escape(dim_pair(d['name']))}</span>"
                ) + "".join(
                    f'<a class="chip" title="{html.escape(t)}" '
                    f'href="../explore.html#dim-{slugify(t)}">{html.escape(dim_pair(t))}</a>'
                    for t in p["dimensions"] if t != d["name"]
                )
                content = (
                    "<h1>" + html.escape(pat_title(p)) + "</h1>"
                    f'<p class="ol" style="color:var(--muted);margin:0 0 14px;">'
                    f"{html.escape(p['title'])}</p>"
                    f'<p class="lede">{html.escape(pat_ol(p))}</p>'
                    f'<div class="meta">{chips}</div>'
                    + body_block
                    + related
                )
                crumb = breadcrumb(
                    [
                        ("首页（Home）", "index.html"),
                        (fam_pair(fam["family"]), f"families/{slugify(fam['family'])}.html"),
                        (dim_pair(d["name"]),
                         f"families/{slugify(fam['family'])}.html#dim-{slugify(d['name'])}"),
                        (pat_title(p), None),
                    ],
                    "../",
                )
                sidebar_p = build_sidebar(tree, "../", open_all=False, active_slug=p["slug"])
                (wiki_dir / "patterns" / f"{p['slug']}.html").write_text(
                    page(pat_title(p), 1, crumb, content, tree_html=sidebar_p, toc=toc),
                    encoding="utf-8",
                )

    print(
        f"OK: rendered {total} patterns across {fam_count} families / "
        f"{dim_count} dimensions -> {wiki_dir}/ (zh UI)",
        file=sys.stderr,
    )


main()
PYEOF

# Package a distributable zip (regenerable; gitignored).
mkdir -p "$DIST_DIR"
ZIP_PATH="$DIST_DIR/agent-building-playbook-wiki.zip"
if command -v zip >/dev/null 2>&1; then
    rm -f "$ZIP_PATH"
    ( cd "$WIKI_DIR" && zip -qr "$REPO_ROOT/$ZIP_PATH" . -x 'README.md' )
    echo "Packaged: $ZIP_PATH" >&2
else
    echo "NOTE: 'zip' not found — skipped packaging step (HTML site still built in $WIKI_DIR/)." >&2
fi

echo "Done. Open $WIKI_DIR/index.html in a browser, or deploy $WIKI_DIR/ to GitHub Pages." >&2
