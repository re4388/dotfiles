---
name: get_backend_news_from_HN_Lobs
description: Fetch front-page articles from Hacker News and Lobsters, filter for backend-related tech content, deduplicate across both sources, and return article names with URLs. Use when user wants backend news, server-side tech articles, or curated backend content from HN/Lobsters.
---

# Get Backend News from HN & Lobsters

## Quick start

Fetch both sites, filter for backend content, deduplicate:

1. **Fetch both front pages in parallel** using WebFetch:
   - `https://news.ycombinator.com/` — extract all article titles and URLs
   - `https://lobste.rs/` — extract all article titles and URLs

2. **Filter for backend-related topics**. Include articles about:
   - Server-side programming (Go, Rust, C, Zig, Python backend, Java, etc.)
   - Databases, storage, message queues
   - Distributed systems, infrastructure, cloud (AWS/GCP/Azure)
   - DevOps, CI/CD, containerization (Docker, Kubernetes)
   - APIs, networking, protocols
   - Performance, benchmarking, systems programming
   - Security (infra-level), cryptography
   - Compilers, runtimes, VMs
   - Version control systems
   - Open source tools for backend dev
   - Server/platform incidents and outages

3. **Exclude** (non-backend):
   - Frontend-only (CSS, React/Vue/Svelte UI, animation, design)
   - Mobile apps (iOS/Android specific)
   - AI/LLM usage/ethics (unless infra-related)
   - Consumer hardware, gadgets
   - Non-tech (politics, culture, business)
   - Career/hiring posts
   - Gaming, graphics rendering
   - Desktop GUI apps

4. **Deduplicate**: If the same story appears on both sites (same topic/event), list it once, noting which sources had it. Different write-ups of the same event can be kept if they add distinct value, but mark them as related.

5. **Output**: List article name and URL, grouped by source. Include a short note at the bottom for any near-duplicates found.

## Output format

```
## Backend Articles (filtered & deduped)

### From Hacker News:
1. Article Name — URL
2. Article Name — URL

### From Lobsters:
1. Article Name — URL
2. Article Name — URL

### Duplicates / related:
- Topic X covered by both HN (URL1) and Lobsters (URL2)
```
