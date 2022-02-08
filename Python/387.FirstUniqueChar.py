class Solution:
    def firstUniqChar(self, s: str) -> int:
        s = list(s)
        letter_cnt= {}
        
        for i in s:
            if i not in letter_cnt:
                letter_cnt[i] = 1
            elif i in letter_cnt:
                letter_cnt[i] = letter_cnt[i] + 1
        
        for i in letter_cnt:
            if letter_cnt[i] == 1:
                return s.index(i)
                break
            
        return -1
        