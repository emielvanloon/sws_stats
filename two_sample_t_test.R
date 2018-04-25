n1 = 41
n2 = 37

df1 = n1 - 1
df2 = n2 - 1
df = df1 + df2

s1 = 13.9
s2 = 14.1

s2p = (df1 * s1^2 + df2 * s2^2) / df
s2p = round(s2p, digits = 1)

SE = sqrt(s2p * (1/n1 + 1/n2))
SE = round(SE, digits = 1)

Y1 = 84.9
Y2 = 104.4

t = (Y1 - Y2) / SE
t = round(t, digits = 2)

P = pt(q = t, df = df, lower.tail = TRUE) * 1
P = round(P, digits = 3)
