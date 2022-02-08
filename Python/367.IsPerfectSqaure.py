class Solution:
    def isPerfectSquare(self, num: int) -> bool:
        if (num/(num**0.5)) == (num**0.5) and (num**0.5 -int(num**0.5) == 0):
            return True
        else:
            return False