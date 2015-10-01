from sympy import *

fi, fj = symbols('fi fj', cls=Function)
a, b, c, d, Ti, Tj, Talpha, t = symbols('a b c d Ti Tj Talpha t')
fi = (a*(Ti-t)+d)*exp(-b*(Ti-t)) + c
fj = (a*(Tj-t)+d)*exp(-b*(Tj-t)) + c

result = simplify(integrate((fi*fj),(t, 0, Talpha)))

print(latex(result))
print(str(result))