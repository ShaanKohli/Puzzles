class Solution:
    def majorityElement(self, nums: List[int]) -> int:
        
#         sums = {}
        
#         for n in nums:
#             if n not in sums:
#                 sums[n] = 1
#             else:
#                 sums[n] +=1
                
#             if sums[n] > len(nums)/2:
#                 return n
# Boyer Moore Algorithm
            count = 0
            res  = nums[0]
            
            for n in nums[1:]:
                if n!= res:
                    count = count -1
                   
                    if count<0:
                        count = 0
                        res = n
                
                else:
                    count = count +1
            
            return res