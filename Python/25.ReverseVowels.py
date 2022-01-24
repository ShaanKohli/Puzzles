class Solution:
    def reverseVowels(self, s: str) -> str:
        s = list(s)
        input_index = []
        word_input = ''
        
        for index, letters in enumerate(s):
            
                if letters.lower() in ['a','e','i','o','u']:
                    
                    input_index.append(index)
                    
                    word_input = word_input +letters
        
        word_input = list(word_input[::-1])
        
        for i in range(0, len(input_index)):
            s[input_index[i]] = word_input[i]
            
        
        return "".join(s)