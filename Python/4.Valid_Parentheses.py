class Solution(object):
    def isValid(self, s):
        open_close_map = {
        "(" : ")",
        "[": "]",
        "{" : "}
        }
      
        para = []
        
        
        if len(s)%2 != 0 or len(s) == 0:
            return False
        
        for i in range(0, len(s)):
            if s[i] in open_close_array.keys():
                para = para.append(s[i])
            
            elif s[i] in open_close_array.values() and para:
                if s[i] != open_close_map[para.pop()]:
                    return False #closing was not correct
            else:
                return False #starts with closing
        
        return False #incomplete closing
    
    return True #all closed correctly
        
        
        