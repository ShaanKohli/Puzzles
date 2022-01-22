class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        
#         if len(s) != len(t):
#             return False
#         s = sorted(s)
#         s = "".join(s)
#         t = sorted(t)
#         t = "".join(t)

#         if s != t:
#             return False
#         else:
#             return True
        
        s_count = {}
        
        for letter in s:
            if letter in s_count:
                s_count[letter] = s_count[letter] + 1
            else:
                s_count[letter] = 1
        
        for letter in t:
            if letter in s_count:
                s_count[letter] = s_count[letter] -1
                
                if s_count[letter] == 0:
                    del s_count[letter]
            else:
                return False
        if s_count:
            return False
        
        return True