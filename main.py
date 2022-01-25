s = ["h","e","l","l","o"]

traverse_length = len(s)//2
        
for i in range(0, traverse_length):
  holding_pointer = s[i]
  s[i] = s[len(s) -1 - i]
  s[len(s) -1 - i] = holding_pointer
