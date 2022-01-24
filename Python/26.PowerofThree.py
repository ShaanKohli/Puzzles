class Solution:
    def isPowerOfThree(self, n: int) -> bool:
        if n <= 0 or n == 2:
            return False
        
        if n == 1:
            return True
        
        

        while n > 3:
            n = float(n)/float(3)
            rem = n%3
            
            if rem > 0:
                return False
        
        return True
            