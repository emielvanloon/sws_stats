n = 33
Y = 113.1
s = 51.1
mu0 = 100
alpha = 0.01

SE = s / sqrt(n)
SE = round(SE, digits = 1)

t = (Y - mu0) / SE
df = n - 1
t = round(t, digits = 2)

P = pt(q = t, df=df, lower.tail = FALSE)  * 2
P = round(P, digits = 3)