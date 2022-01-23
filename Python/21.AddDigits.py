class Solution:
    def addDigits(self, num: int) -> int:
#         if len(str(num)) == 1:
#             return num
        
#         num = list(map(int,list(str(num))))
#         num  = sum(num)
        
#         while len(str(num)) > 1:
#             num = list(map(int,list(str(num))))
#             num  = sum(num)
            
        
#         return num

          if num==0:
            return 0

          return num%9 or 9