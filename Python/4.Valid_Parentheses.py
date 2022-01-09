class Solution(object):
    def isValid(self, s):
        open_close_map = {
        '(': ')',
        '[': ']',
        '{': '}'
        }

        oc = []

        if len(s)%2 !=0 or len(s)==0:
            return False

        for i in range(0, len(s)):
            if s[i] in open_close_map.keys():
                oc.append(s[i])
                
            elif s[i] in open_close_map.values() and oc:
                if s[i] != open_close_map[oc.pop()]:
                    return False
                
            else:
                return False

        if oc:
            return False

        return True
        
        
        
        
        
        