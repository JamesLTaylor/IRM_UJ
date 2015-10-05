from sympy import *

def cross_vol():
    fi, fj = symbols('fi fj', cls=Function)
    a, b, c, d, Ti, Tj, Talpha, t = symbols('a b c d Ti Tj Talpha t')
    fi = (a*(Ti-t)+d)*exp(-b*(Ti-t)) + c
    fj = (a*(Tj-t)+d)*exp(-b*(Tj-t)) + c
    
    result = simplify(integrate((fi*fj),(t, 0, Talpha)))
    
    print(latex(result))
    print()
    print(str(result))
    print()
    
def vol_squared():
    fi = symbols('fi', cls=Function)
    a, b, c, d, Ti, t = symbols('a b c d Ti t')
    fi = (a*(Ti-t)+d)*exp(-b*(Ti-t)) + c    
    
    result = simplify(integrate((fi*fi),(t, 0, Ti)))
    
    print(latex(result))
    print()
    print(str(result))
    print()
    
vol_squared()    