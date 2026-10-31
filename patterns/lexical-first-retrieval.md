---
title: Start Lexical, Add Semantic Only When Proven
one_liner: Baseline agent retrieval on grep/BM25 — cheap, deterministic, and debuggable — and add embeddings or rerankers only where evals demonstrate recall gaps lexical search cannot close.
dimensions: context-engineering, tool-design
---

## What it is

Teams reach for vector databases by default; over code and structured corpora, lexical search is often eerily effective for agents. Real agent queries are full of exact identifiers, symbols, error strings, and rare terms — exactly what grep and BM25 match perfectly. Lexical retrieval is also debuggable: you can read the query and see why a document matched, which matters when an agent's context assembly goes wrong. Meanwhile, 2022-style fixed-size chunking quietly destroys document structure — chunk by headings and semantic units instead, and index metadata alongside. Add embeddings where evals show genuine paraphrase or cross-lingual recall gaps, and add them as a hybrid arm (lexical + vector + rerank), not a replacement.

## When to reach for it

- Agent search over codebases, documentation, tickets, or any corpus rich in identifiers.
- Designing a RAG layer and deciding where to spend complexity budget.
- Debugging "the agent couldn't find it" failures — a lexical baseline gives you a controllable reference point.
- Someone proposes fine-tuning a model to fix a retrieval problem — fix retrieval with retrieval.

## When NOT to

- Corpora that are inherently paraphrase-heavy, cross-lingual, or OCR-noisy from day one — go hybrid immediately, but keep the lexical arm.
- Tiny corpora that fit entirely in context — retrieval is the wrong tool, just load it.

## Exemplars

- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1xyet61EZ9 — "The Unreasonable Effectiveness of BM25 for Agent Search": why lexical scoring keeps winning in agent pipelines
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1ZgpB6bEGP — "Grep or Embeddings? We Ran Evals on Agent Search Over Company Docs": head-to-head comparison decided by measurements, not fashion
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1LGeh6NE8P — "Stop Chunking Like It's 2022": structure-aware chunking and indexing beat fixed-size character windows
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV13Dpu6zEmd — "Stop Fine-Tuning to Fix Retrieval Problems": retrieval failures are retrieval bugs, not model gaps
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV15sJ263Ex9 — "Vector Isn't Enough: Hybrid Search and Retrieval": where semantic search earns its keep and how to combine arms

## Related

- `patterns/search-over-list.md`
- `patterns/just-in-time-retrieval.md`
- `patterns/eval-driven-development.md`
- `patterns/context-is-finite.md`
