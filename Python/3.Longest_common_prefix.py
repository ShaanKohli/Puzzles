class Solution(object):
    def longestCommonPrefix(self, strs):
        if len(strs) == 0:
            return ""
        if len(strs) == 1:
            return strs[0]
        strs.sort()
        end = min(len(strs[0]),len(strs[-1]))
        i  = 0
        pre = ""
        while (i< end) and (strs[0][i] == strs[-1][i]):
            i = i+1
            pre = strs[0][0:i]
        return pre