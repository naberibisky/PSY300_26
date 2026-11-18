# PSY 300: Nonparametric tests
# November 19, 2026

library(ggplot2)

# ------------------------------------------------------------
# 1. RELATED MEASUREMENTS: SIGN TEST AND WILCOXON SIGNED-RANK
# ------------------------------------------------------------
# sleep: the same 10 people received two sleep drugs.
# 'extra' is the increase in sleep (hours) compared with baseline.

data(sleep)
head(sleep)

# Each line connects the SAME person under the two drugs.
ggplot(sleep, aes(x = group, y = extra, group = ID)) +
  geom_line(color = "gray60") +
  geom_point(size = 3) +
  labs(title = "How did each person's sleep change?",
       x = "Drug", y = "Extra hours of sleep") +
  theme_minimal()

# Measurements are ordered by participant ID within each group.
drug1 <- sleep$extra[sleep$group == 1]
drug2 <- sleep$extra[sleep$group == 2]
change <- drug2 - drug1

# See every person's difference.
changes <- data.frame(person = 1:10, change = change)

# easy plot
hist(change, breaks = 20)

# more involved plot
ggplot(changes, aes(x = factor(person), y = change, fill = change > 0)) +
  geom_col(show.legend = FALSE) +
  labs(title = "Direction AND size of each change",
       x = "Person", y = "Drug 2 minus Drug 1 (hours)") +
  theme_minimal()


# WILCOXON SIGNED-RANK: ranks the absolute differences,
# then considers whether the larger ranks tend to be positive or negative.
wilcox.test(drug2, drug1, paired = TRUE)

# Some participants have differences of exactly zero, and some
# differences have the same absolute value (ties).
# Because of this, R cannot calculate the usual exact p-value
# and instead uses a normal approximation.

# Familiar counterpart: paired t-test uses raw differences.
t.test(drug2, drug1, paired = TRUE)

# APA write-up:
# A Wilcoxon signed-rank test indicated that sleep duration
# differed significantly between the two drugs,
# W = 45, p = .009.
#
# Note: R labels the statistic V, but we report it as W
# using conventional Wilcoxon signed-rank notation.

# ------------------------------------------------------------
# 2. TWO INDEPENDENT GROUPS: MANN-WHITNEY U
# ------------------------------------------------------------
# ToothGrowth: guinea pig tooth length for two vitamin C delivery methods.
# We use only the 1 mg dose so the dose is the same in both groups.

data(ToothGrowth)
teeth <- subset(ToothGrowth, dose == 1)

# simple plot
boxplot(len ~ supp, data = teeth, ylim = c(0,30))

# more involved plot
ggplot(teeth, aes(x = supp, y = len)) +
  geom_boxplot(width = 0.4, outlier.shape = NA) +
  geom_jitter(width = 0.08, height = 0, size = 2) +
  labs(title = "Tooth length by delivery method (1 mg dose)",
       x = "Delivery method", y = "Tooth length") +
  coord_cartesian(ylim = c(0, 30)) +
  theme_minimal()

# R calls this the Wilcoxon rank-sum test.
wilcox.test(len ~ supp, data = teeth, exact = FALSE)

# Familiar counterpart: independent-samples t-test.
t.test(len ~ supp, data = teeth)

# APA write-up:
# A Mann-Whitney U test indicated that tooth length  differed significantly between the
# two vitamin C delivery methods,
# U = 88.4, p = .004.
# Note: R labels the statistic W, but we report the
# corresponding Mann-Whitney U statistic.

# ------------------------------------------------------------
# 3. THREE INDEPENDENT GROUPS: KRUSKAL-WALLIS
# ------------------------------------------------------------
# PlantGrowth: plant weights under three conditions.

data(PlantGrowth)

# simple plot
boxplot(weight ~ group, data = PlantGrowth, col = c("lightblue", "darkgreen", "orange"))

ggplot(PlantGrowth, aes(x = group, y = weight)) +
  geom_boxplot(width = 0.4, outlier.shape = NA) +
  geom_jitter(width = 0.08, height = 0, size = 2) +
  labs(title = "",
       x = "Group", y = "Plant weight") +
  theme_minimal()

kruskal.test(weight ~ group, data = PlantGrowth) # would follow this up with mann whitney

# Pairwise Mann-Whitney U tests
# Bonferroni correction for multiple comparisons
pairwise.wilcox.test(PlantGrowth$weight,
                     PlantGrowth$group,
                     p.adjust.method = "fdr")

# Familiar counterpart: one-way ANOVA.
summary(aov(weight ~ group, data = PlantGrowth))

# APA write-up:
# A Kruskal-Wallis test indicated that plant weight
# significantly differed across the
# three experimental conditions,
# H(2) = 7.99, p = .018.
#
# Note: R labels the statistic "Kruskal-Wallis chi-squared,"
# but H is conventional notation for this test.

# ------------------------------------------------------------
# 4. THREE RELATED MEASUREMENTS: FRIEDMAN TEST
# ------------------------------------------------------------
# ChickWeight: chicks weighed repeatedly over time.
# Focus on chicks 1–10, measured on days 0, 2, and 4.

data(ChickWeight)
# We want to examine how chicks' weights change over time.
# To keep things simple, we'll look at the first 10 chicks
# and only three measurement occasions (days 0, 2, and 4).

chicks <- subset(ChickWeight, Chick %in% 1:10)
chicks <- subset(chicks, Time %in% c(0, 2, 4))

# simple
boxplot(weight ~ Time, data = chicks, ylim = c(0,65),
        col = c("pink", "beige", "maroon"))

# Each line follows one chick across time.
ggplot(chicks, aes(x = Time, y = weight, group = Chick)) +
  geom_line(color = "gray55") +
  geom_point(size = 2) +
  scale_x_continuous(breaks = c(0, 2, 4)) +
  labs(title = "The same chicks measured three times",
       x = "Day", y = "Weight (grams)") +
  theme_minimal()

# Friedman compares ranks WITHIN each chick.
friedman.test(weight ~ Time | Chick, data = chicks)

# Familiar counterpart: repeated-measures ANOVA.
summary(aov(weight ~ factor(Time) + Error(Chick/factor(Time)), data = chicks))



# Pairwise comparisons with FDR correction
pairwise.t.test(chicks$weight, chicks$Time,
                paired = TRUE,
                p.adjust.method = "fdr")


# APA write-up:
# A Friedman test indicated that chick weight
# [did/did not] differ significantly across the
# three measurement occasions,
# chi-square(2) = 18.20, p = .001.
#
# Note: Friedman results are commonly reported using
# the chi-square statistic (report actual symbol) and its degrees of freedom.