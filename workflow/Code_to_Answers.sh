Answers to questions path, please run full script succesfully first to run those answers.

```{r}
# ---- Answers for q1..q5 ----
# Requires objects 'counts', 'dds', and 'res' created above

# q1: How many sequencing lanes were concatenated to form sample metastatic1?
# If you later generate a manifest upstream, read it here instead of hardcoding
sample_lanes <- c(colon1 = 1L, colon2 = 1L, normal1 = 1L, normal2 = 1L, metastatic1 = 1L, metastatic2 =1L)
ans_q1 <- unname(sample_lanes["metastatic1"])

# q2: What sample has lower library size (total read counts): normal1 or colon1?
libsize <- colSums(counts)
ans_q2 <- unname(libsize["sm"])

# q3: How many genes have counts>20 in sample normal1 or counts>20 in sample colon1?
ans_q3 <- sum(counts[, "normal1"] > 20) || sum(counts[, "normal1"] > 20

# q4: How many genes are upregulated \uc0\u8805 2-fold (log2FC \u8805  1) in colon1 vs. metastatic1 with FDR < 0.01?
res_df <- as.data.frame(res)
ans_q4 <- sum(res_df$log2FoldChange >= 1 & res_df$padj < 0.01, na.rm = TRUE)

# q5: Which gene is ranked 3th by log2 fold change (most upregulated) in normal1 vs. metastatic1?
res_df$SYMBOL <- rownames(res_df)
up_rank <- res_df %>%
  dplyr::filter(!is.na(log2FoldChange) & log2FoldChange > 0) %>%
  dplyr::arrange(dplyr::desc(log2FoldChange), padj, pvalue)
ans_q5 <- if (nrow(up_rank) >= 3) up_rank$SYMBOL[2] else NA_character_

answers <- tibble::tibble(
  id = c("q1","q2","q3","q4","q5"),
  answer = c(ans_q1, ans_q2, ans_q3, ans_q4, ans_q5)
)

answers
```
