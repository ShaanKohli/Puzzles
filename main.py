s= "A man, a plan, a canal: Panama"
s= lower(s)
s= ''.join(ch for ch in s if ch.isalnum())
rev_s = s[::-1]
print(rev_s)
        

