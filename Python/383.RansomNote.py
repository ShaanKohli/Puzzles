class Solution:
    def canConstruct(self, ransomNote: str, magazine: str) -> bool:
        ransom_letter = {}
        ransomNote = list(ransomNote)
        magazine = list(magazine)
        
        for i in ransomNote:
            if i not in ransom_letter:
                ransom_letter[i] = 1
            
            if i in ransom_letter:
                ransom_letter[i] +=1
                
        for i in magazine:
            if i not in ransom_letter:
                return False
            
            if i in ransom_letter:
                ransom_letter[i] -= 1
            
            if ransom_letter[i] == 0:
                del magazine_letter[i]
        
        return True