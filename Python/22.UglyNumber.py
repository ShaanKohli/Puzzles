class Solution:
    def isUgly(self, n: int) -> bool:
        if n <= 0:
            return False
        
        i = 2
        #factors = []
        while i * i <= n:
            if n % i:
                i = i+1
            else:
                n //= i
                #factors.append(i)
                if i not in [2,3,5]:
                    return False

        if n > 1:
            #factors.append(n)
            if n not in [2,3,5]:
                return False

        # for x in factors:
        #     if x not in [2,3,5]:
        #         return False

        return True