---
name: s3
description: learn concept by telling 3 story
---


# Step 1: idenitfy key concepts
user will give you a key domain or field, inside that domain or field find 選 3 個大概研究生程度的概念.
save those concept into ./{domain}_3_concept.md



## Example:
the user will prompt like `/storify3 mongoDB`
and you save those word into ./mongoDB_3_concept.md

```
1. MongoDB 的分桶模式 (Bucketing Pattern) 與 時間序列集合 (Time Series Collections)
2. MongoDB 的因果一致性 (Causal Consistency) 與 邏輯時鐘 (Logical Clocks)
3. MongoDB 複合索引 (Compound Indexes) 與 ESR 法則
```


# Step 2: tell story for each concept

using 3 subagent: 
the firt one take first 3 concept from ./{domain}_1_concept.md
the second one take the next 3 concept from ./{domain}_2_concept.md
the thrid one take last 3 concept from ./{domain}_3_concept.md

subagent use following style to tell the story
```
透過寫一個寓言的方式，間接地把這個概念完整的講出來。最好一直到快結尾的時候，人們會慢慢意識到這個概念到底是什麼。
然後故事之後，再補一段解釋，把你剛才真正要講的概念說清楚。

PS: 這個寓言的內容，可以的話，也要生活化，可以的話可以跟真實世界有所關連，不要憑空製造很多真實世界不好聯想的概念，說故事的方法，請以 "簡潔有力、直白明了"這樣的方法（海明威的寫作風格）。
```
and then save into ./{domain}_story_{x}_concept.md   // x is 1 to 3


# Step 3: gatther
when all 3 files are done.
finally, put them all together into one md file, name it ./{domain}_learnBystory.md

inside ./{domain}_learnBystory.md
at begine, put the content of ./{domain}_3_concept.md, so we can know those 3 concept at begin
and then put those 3 files (./{domain}_story_{x}_concept.md) into this file

# Step4: cleanup
MUST: precondition for this step: when all three steps3 are done.
only keep this file: ./{domain}_learnBystory.md
and remove below files:
./{domain}_story_{x}_concept.md   // x is 1 to 3
./{domain}_3_concept.md
