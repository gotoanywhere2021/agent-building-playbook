#!/usr/bin/env python3
"""Swarm dashboard — read-only derived view over the shared board.

Scans board.md (batch status lines), claims/ (atomic claim locks) and
results-W*.md (append-only worker logs) and renders dashboard.md.
Anyone (worker, integrator, human) may run it; it writes only dashboard.md.
"""
import os
import re
import time
from datetime import datetime, timezone

BASE = os.path.dirname(os.path.abspath(__file__))
BOARD = os.path.join(BASE, "board.md")

def utcnow():
    return datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S UTC")

def main():
    board = open(BOARD, encoding="utf-8").read()
    lines = board.splitlines()

    batches = []  # (id, nfiles, nurls, status, worker)
    cur = None
    for ln in lines:
        m = re.match(r"^## (B\d+) — (\d+) files — (\d+) exemplar URLs — STATUS: (\w+)(?: BY (\w+))?", ln)
        if m:
            cur = {"id": m.group(1), "files": int(m.group(2)), "urls": int(m.group(3)),
                   "status": m.group(4), "worker": m.group(5) or "-", "file_list": []}
            batches.append(cur)
        elif cur is not None and ln.startswith("- patterns/"):
            cur["file_list"].append(ln.split(" | ")[0][2:])

    claims = sorted(d for d in os.listdir(os.path.join(BASE, "claims"))) if os.path.isdir(os.path.join(BASE, "claims")) else []

    workers = {}
    for f in sorted(os.listdir(BASE)):
        if not (f.startswith("results-") and f.endswith(".md")):
            continue
        w = f[len("results-"):-3]
        txt = open(os.path.join(BASE, f), encoding="utf-8").read()
        file_rows = re.findall(r"^FILE (patterns/\S+) \| urls=(\d+) ok=(\d+) bad=(\d+) skip=(\d+)", txt, re.M)
        batch_done = re.findall(r"^BATCH (B\d+) DONE files=(\d+) urls=(\d+) ok=(\d+) bad=(\d+) skip=(\d+)", txt, re.M)
        stopped = re.search(r"^WORKER (\w+) STOPPED (.+)$", txt, re.M)
        bad_rows = re.findall(r"^(\d{3}|TIMEOUT|RATE_LIMITED_SKIP) \| (\S+) \| (patterns/\S+)", txt, re.M)
        workers[w] = {
            "file_rows": file_rows,
            "batch_done": batch_done,
            "stopped": stopped.group(2) if stopped else None,
            "files_done": len(file_rows),
            "urls": sum(int(r[1]) for r in file_rows),
            "ok": sum(int(r[2]) for r in file_rows),
            "bad": sum(int(r[3]) for r in file_rows),
            "skip": sum(int(r[4]) for r in file_rows),
            "bad_detail": [(c, u, p) for c, u, p in bad_rows if c not in ("200", "301", "302", "303", "307", "308", "TIMEOUT")],
            "timeout_detail": [(c, u, p) for c, u, p in bad_rows if c == "TIMEOUT"],
        }

    n = len(batches)
    unclaimed = sum(1 for b in batches if b["status"] == "UNCLAIMED")
    claimed = sum(1 for b in batches if b["status"] == "CLAIMED")
    done = sum(1 for b in batches if b["status"] == "DONE")
    tot_urls = sum(b["urls"] for b in batches)

    out = [f"# Swarm Dashboard — {utcnow()}", "",
           f"- 批次：{n} 总 / {done} DONE / {claimed} CLAIMED / {unclaimed} UNCLAIMED",
           f"- URL 进度：**{sum(w['urls'] for w in workers.values())} / {tot_urls}**",
           f"- 认领锁（claims/）：{', '.join(claims) if claims else '（空）'}",
           ""]
    out += ["## Workers", "",
            "| 工人 | 文件 | URLs | ok | bad | skip | 状态 |",
            "|---|---|---|---|---|---|---|"]
    for w, s in sorted(workers.items()):
        out.append(f"| {w} | {s['files_done']} | {s['urls']} | {s['ok']} | {s['bad']} | {s['skip']} | "
                   f"{'STOPPED ' + s['stopped'] if s['stopped'] else 'running'} |")
    if not workers:
        out.append("| （尚无结果文件） | | | | | | |")
    out += ["", "## Batches", "",
            "| 批次 | files | urls | 状态 | 工人 |",
            "|---|---|---|---|---|"]
    for b in batches:
        out.append(f"| {b['id']} | {b['files']} | {b['urls']} | {b['status']} | {b['worker']} |")

    all_bad = {}
    for w, s in workers.items():
        for c, u, p in s["bad_detail"]:
            all_bad.setdefault((c, u), []).append((w, p))
    out += ["", f"## 坏链候选（非 2xx/3xx；{len(all_bad)} 条）", ""]
    for (c, u), srcs in sorted(all_bad.items()):
        out.append(f"- **{c}** {u} ← {', '.join(sorted({p for _, p in srcs}))}")
    if not all_bad:
        out.append("（暂无）")

    tout = [(c, u, p) for w, s in workers.items() for c, u, p in s["timeout_detail"]]
    if tout:
        out += ["", "## 超时候选（可重试）", ""]
        for c, u, p in sorted(set(tout)):
            out.append(f"- {u} ← {p}")

    open(os.path.join(BASE, "dashboard.md"), "w", encoding="utf-8").write("\n".join(out) + "\n")
    print("\n".join(out[:14]))
    print(f"... dashboard.md written ({len(all_bad)} bad-link candidates, {len(tout)} timeouts)")

if __name__ == "__main__":
    main()
