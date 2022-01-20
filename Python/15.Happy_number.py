class Solution:
    def isHappy(self, n: int) -> bool:
        def sumSquare(s: str) -> int:
            sums = 0
            for i in s:
                sums = sums + int(i)**2
            return sums
        
        
        square_sum = 0 
        cycle_list = []
        
        while square_sum != 1:
            
            square_sum = sumSquare(str(n))
            
            n  = square_sum
            
            if n == 1:
                return True
            
            if n in cycle_list:
                return False
            else:
                cycle_list.append(n)
                
        return False