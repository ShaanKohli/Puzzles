class Solution:
    def lengthOfLastWord(self, s: str) -> int:
        lst = list(s.split(" "))
        lst = [x for x in lst if x!= ""]
        return len(lst[-1])