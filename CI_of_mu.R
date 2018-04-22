n = 157
df = n - 1

tcrit = qt(p = 0.975, df = df, lower.tail = TRUE)
tcrit = round(tcrit, digits = 2)

s = 10.8

SE = s / sqrt(n)
SE = round(SE, digits = 1)

Y = 198.7

LB = Y - tcrit * SE
LB = round(LB, digits = 1)
UB = Y + tcrit * SE
UB = round(UB, digits = 1)