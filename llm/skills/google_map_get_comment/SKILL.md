---
name: google_map_get_comment
description: Scrape Google Maps restaurant/shop reviews using Playwright CLI. Use when user wants to fetch Google Maps reviews, comments, or ratings for a specific place.
---

# Google Maps Review Scraper

## Setup (do once per machine)

To persist Google login state across sessions, always open the browser with a fixed profile directory:

```bash
playwright-cli -s=<name> open --headed --profile "<home-dir>/.playwright-chrome-profile" "https://www.google.com/maps/search/<place-name>"
```

Use `--profile` (not `--persistent`) with a fixed directory path. The first time you do this, the user must manually log into their Google account in the opened browser. Subsequent sessions will reuse the login state automatically.

**Important:** If you previously used `--persistent` without `--profile`, switch to `--profile` with a fixed path. The `--persistent` flag alone uses a default temp directory that does not survive across sessions.

## Workflow

### Phase 0: Quick check for visible reviews

After opening the place page, take a snapshot. Google Maps sometimes already shows a few review previews ("評論摘要") on the main detail page, which include:
- Overall star rating and total count
- Star distribution bars (e.g. "5 星級、270 則評論")
- A few preview review cards
- Top keyword tags (e.g. "有 47 則評論提到酒")

This gives you a quick overview without needing to scroll.

### Phase 1: Open the full review list

Look for a button like "更多評論 (N)" or "評論" tab and click it:

```bash
# Check if there's a "more reviews" button
playwright-cli -s=<name> snapshot | grep -i "更多評論\|評論.*([0-9]"

# Click it to open the full scrollable review panel
playwright-cli -s=<name> click <ref-of-more-reviews-button>
```

If the page has a "評論" tab instead (tablist element), click that first, then look for "更多評論" button.

### Phase 2: Find the correct scroll container

Google Maps has MANY `div` elements. Only ONE is the actual review scroll panel. Run this discovery script:

```bash
playwright-cli -s=<name> --raw eval "
(() => {
  const allDivs = [];
  document.querySelectorAll('div').forEach((d, i) => {
    if (d.scrollHeight > d.clientHeight + 100) {
      allDivs.push({
        idx: i,
        scrollH: d.scrollHeight,
        clientH: d.clientHeight,
        childCount: d.children.length,
        classes: d.className.substring(0, 120)
      });
    }
  });
  return JSON.stringify(allDivs.filter(x => x.scrollH > 1000));
})()
"
```

**How to identify the RIGHT container:**
- `scrollHeight` is large (typically 3000-10000+) — it holds the loaded reviews
- `clientHeight` is moderate (400-700px) — the visible viewport
- The difference `scrollHeight - clientHeight` is huge — meaning it CAN scroll a lot
- Filter out small ones: only consider containers with `scrollHeight > 1000`
- Pick the one with the largest `scrollHeight`

**Once identified**, build a locator from its class names:
```bash
playwright-cli -s=<name> hover "div.{primary-class}.{secondary-class}"
```

### Phase 3: Scroll to lazy-load reviews

**Rule: hover first, then mousewheel. JS scrollTop will NOT trigger lazy-load.**

```bash
# Hover the scroll container first
playwright-cli -s=<name> hover "<locator-from-phase-2>"

# Scroll in batches. Each iteration + 2s sleep loads ~10 more reviews.
for i in $(seq 1 N); do
  playwright-cli -s=<name> mousewheel 0 1500
  sleep 2
done
```

**How many iterations?**
- Each iteration loads ~5-10 reviews
- Formula: `target_count / 7` rounded up, then add a few extra
- For 340 reviews, 50-60 iterations
- Check progress periodically with a card count (see Phase 4 discovery)

### Phase 4: Discover review card structure, then extract

**Step 4a: Find the review card selector**

Do NOT assume class names from previous sessions. They change between Google Maps deploys. Instead, use `aria-label` attribute patterns that are stable:

```bash
playwright-cli -s=<name> --raw eval "
(() => {
  // Stars have stable aria-label patterns like '5 顆星' (zh) or '5 stars' (en)
  const starElements = document.querySelectorAll('[aria-label*=\"顆星\"], [aria-label*=\"stars\"]');
  const results = [];
  starElements.forEach(el => {
    // Walk up to find the review card wrapper
    let card = el.closest('div[class]') || el.parentElement;
    // The review card is typically 2-4 levels up
    for (let i = 0; i < 5 && card && card.children.length < 3; i++) {
      card = card.parentElement;
    }
    if (card && !results.some(r => r.el === card)) {
      results.push({
        tag: card.tagName,
        classes: card.className?.substring(0, 120),
        text_preview: card.textContent?.substring(0, 150)
      });
    }
  });
  return JSON.stringify({ found: results.length, sample: results.slice(0, 5) });
})()
"
```

The review cards are typically `div` elements with a single short class name (e.g., `jJc9Ad`). Look for the class that appears on EVERY card sample. Verify by counting:

```bash
playwright-cli -s=<name> --raw eval "
document.querySelectorAll('div.<discovered-class>').length
"
```

**Step 4b: Extract reviews**

You don't need to get all reviews, you get latest 50 review is enough (or less then 50 review, if the total review is less than 50)

```bash
playwright-cli -s=<name> --raw eval "
(() => {
  const cards = document.querySelectorAll('div.<discovered-class>');
  const reviews = [];
  cards.forEach(card => {
    const starEl = card.querySelector('[aria-label*=\"顆星\"]') || card.querySelector('[aria-label*=\"stars\"]');
    const text = card.textContent || '';
    reviews.push({
      stars: starEl ? starEl.getAttribute('aria-label') : '',
      text: text.substring(0, 600)
    });
  });
  return JSON.stringify(reviews);
})()" > /tmp/reviews.json
```

**Notes on review text quality:**
- Review text is often truncated with "..." and a "更多" (More) button — the full text requires clicking each "More" individually, which is slow. The preview text (~100-200 chars) gives enough signal for most purposes.
- Reviewer name, date, and star count are embedded in `textContent` and can be parsed out if needed.

### Phase 5: Verify baseline stats

Cross-check before presenting results:
- **Review count extracted** vs **total shown on page** — if mismatch, scroll more
- **Star distribution** — compare the summary bars on the page against what you extracted

## Core Principles

1. **Use fixed profile for login persistence** — `--profile <path>` with a fixed directory keeps Google login across sessions. User only logs in once.
2. **Discovery over hardcoding** — Always run Phase 2 + Phase 4 discovery scripts. CSS class names change between Google Maps deploys.
3. **Stable selectors** — `aria-label` attributes like "顆星" or "stars" are more stable than CSS classes for finding reviews.
4. **Real events over JS** — Google Maps ignores `scrollTop` and synthetic `WheelEvent`. Only Playwright's `hover` + `mousewheel` triggers lazy-load.
5. **Hover before scroll** — `mousewheel` targets whatever is under the cursor. Hover the review panel first.
6. **Sleep between scrolls** — Content loads async. 2s between scrolls avoids missed reviews.
7. **Validate before summarizing** — Cross-check extracted count vs page total.

## Quick Reference: Common Commands

```bash
# Open with persistent login
playwright-cli -s=maps open --headed --profile "~/.playwright-chrome-profile" "https://www.google.com/maps/search/<place>"

# Snapshot the page
playwright-cli -s=maps snapshot

# Click an element by ref
playwright-cli -s=maps click <ref>

# Scroll the review panel (hover first!)
playwright-cli -s=maps hover "div.<container-class>"
playwright-cli -s=maps mousewheel 0 1500

# Run JS in the page
playwright-cli -s=maps --raw eval "<js-code>"

# Close browser
playwright-cli -s=maps close
```
