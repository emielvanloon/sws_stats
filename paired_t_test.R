n = 42
s = 11.3

SE = s / sqrt(n)
SE = round(SE, digits = 1)

d = 0.1
df = n - 1

t = d / SE
t = round(t, digits = 2)

P = pt(t, df = df, lower.tail = FALSE) * 1
P = round(P, digits = 3)