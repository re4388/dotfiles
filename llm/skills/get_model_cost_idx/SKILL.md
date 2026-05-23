---
name: get_model_cost_idx
description: Fetch model pricing and AI index data (Intelligence Index, Coding Index, Agentic Index) from OpenRouter. Use when user asks about model costs, AI benchmarks, intelligence/coding/agentic index scores, or wants to compare model pricing and performance from openrouter.ai.
allowed-tools: Bash(playwright-cli:*) Bash(npx:*) Read
---

# Get Model Cost & Index from OpenRouter

Fetch pricing and benchmark indices for LLM models listed on openrouter.ai.

## Workflow

### Step 1: Open browser and navigate

```bash
npx playwright-cli open https://openrouter.ai/<provider>/<model-slug>
```

### Step 2: Read the benchmarks section

Take a snapshot and grep for the index scores:

```bash
npx playwright-cli snapshot --filename=model_snapshot.yml
```

Then grep the snapshot file for the three index scores:

```bash
grep -C 5 "Intelligence Index\|Coding Index\|Agentic Index" model_snapshot.yml
```

### Step 3: Handle Design Arena vs Artificial Analysis

Some model pages default to "Design Arena" view instead of "Artificial Analysis". If the grep returns nothing for the indices, check which tab is active:

```bash
grep -C 3 "Artificial Analysis\|Design Arena" model_snapshot.yml
```

If "Artificial Analysis" is not active, click it:

```bash
npx playwright-cli click <ref-for-artificial-analysis-button>
```

Then snapshot again and grep for indices.

### Step 4: Extract the data

The snapshot will contain lines like:

```
paragraph [ref=eXXX]: "51.5"           # Intelligence Index
paragraph [ref=eXXX]: Artificial Analysis
paragraph [ref=eXXX]: Intelligence Index
```

Extract the three key metrics:

| Metric | Snapshot label |
|--------|---------------|
| Intelligence Index | `Overall intelligence score combining multiple benchmarks` |
| Coding Index | `Composite coding capability score` |
| Agentic Index | `Composite agentic capability score` |

### Step 5: Extract pricing

Pricing is at the top of the page. Grep the snapshot for pricing patterns:

```bash
grep -E '\$[0-9]+\.[0-9]+.*[Mm]illion|per.*tokens|input|output' model_snapshot.yml
```

Or look for elements labeled `$/M` or `input` / `output` near the top of the snapshot.

### Step 6: Close the browser

```bash
npx playwright-cli close
```

### Step 7: Format the output

Present results as a markdown table:

```
| 模型 | 輸入費用 | 輸出費用 | 智慧指數 | 程式碼指數 | Agentic 指數 |
|--|--|--|--|--|--|
| **Model Name** | $X.XX / 百萬 tokens | $X.XX / 百萬 tokens | XX.X | XX.X | XX.X |
```

## Notes

- The three indices (Intelligence, Coding, Agentic) come from **Artificial Analysis**, not OpenRouter directly. OpenRouter embeds them on model pages.
- If a model page shows "Design Arena" by default, you must click "Artificial Analysis" to see the indices.
- Some models have a combobox for different variants (e.g., "Reasoning" vs "Reasoning, Max Effort"). The indices may differ per variant.
- Data source URL: `https://artificialanalysis.ai/models/<model-slug>`
