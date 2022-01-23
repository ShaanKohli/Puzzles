def prime_factors(n):
    i = 2
    factors = []
    while i * i <= n:
        if n % i:
            i = i+1
        else:
            n //= i
            factors.append(i)

    if n > 1:
        factors.append(n)
    
    for x in factors:
      if x not in [2,3,5]:
        return False
    
    return True
    
  

    

print(prime_factors(14))