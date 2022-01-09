#-------------------------------------------------#
#------------- 1. Plaindrome Number --------------#
#-------------------------------------------------#

class Solution(object):
    def isPalindrome(self, x):
        # if x < 0:
        #     return False
        # else:
        #     y = str(x)
        #     y = int(y[::-1])
        #     return x==y
        
       # follow up without using string
        if x < 0:
            return False
        if x ==0:
            return True
        div = 1
        while(x / div >= 10):
            div = 10*div
        while (x!=0):
            leading = x // div
            trailing = x % 10
            if leading != trailing:
                return False
            x = (x%div)//10
            div = div/100  
        return True