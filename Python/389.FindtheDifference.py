class Solution:
    def findTheDifference(self, s: str, t: str) -> str:
        letters = {}
        s= list(s)
        t= list(t)
        
        for i in t:
            if i not in letters:
                letters[i] = 1
            elif i in letters:
                letters[i] = letters[i] +1
                
        for i in s:
            if i in letters:
                letters[i] -=1
            if letters[i] ==0:
                del letters[i]
    
        return list(letters.keys())[0]