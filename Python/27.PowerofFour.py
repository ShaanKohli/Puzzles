class Solution:
    def isPowerOfFour(self, n: int) -> bool:
        if n<=0 or n==2 or n==3:
            return False
        if n == 1:
            return True
        
        while n > 4:
            n = float(n)/float(4)
            rem = n%4
            
            if rem > 0:
                return False
                
        return True