class Solution:
    def plusOne(self, digits: List[int]) -> List[int]:
        s = map(str, digits)
        s = "".join(s) 
        num = int(s) +1
        return list(str(num))
        