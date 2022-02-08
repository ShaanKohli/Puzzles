# The guess API is already defined for you.
# @param num, your guess
# @return -1 if my number is lower, 1 if my number is higher, otherwise return 0
# def guess(num: int) -> int:

class Solution:
    def guessNumber(self, n: int) -> int:
        if n == 1:
            return 1
            
        if guess(2) ==0:
            return 2
        
        start  = 1
        end = n
        
        while (start <=end):
            mid = (start+end)//2
            if guess(mid) == 0:
                return mid
            elif guess(mid) == -1:
                end = mid -1
            else:
                start = mid +1
        
        return mid