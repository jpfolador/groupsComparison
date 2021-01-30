## Statistical equivalence between groups

These files are related to t-test application in two groups of people. The aim is to find if the age is equivalent between them. For this reason, the t-test is used. Before the t-test application is important to know whether the samples of the groups follow a normal distribution.

### How it works

We have a file in R language named `2-groups-t-test-analysis.R` that load the CSV file named `participants-sample.csv`, then it calculates a histogram and a QQ-plot for the 2 groups, calculates the Shapiro Wilk for the normality, and calculates the t-test.

### Author
- João Paulo Folador
- Adriano de Oliveira Andrade (:star: advisor)

### Reference
- Miot, Hélio Amante. (2017). Assessing normality of data in clinical and experimental trials. Jornal Vascular Brasileiro, 16(2), 88-91. https://doi.org/10.1590/1677-5449.041117
- Student's t-test in R and by hand: how to compare two groups under different scenarios. (2020). Available in: https://statsandr.com/blog/student-s-t-test-in-r-and-by-hand-how-to-compare-two-groups-under-different-scenarios/#how-to-compute-students-t-test-by-hand
