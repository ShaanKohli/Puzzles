class Solution:
    def missingNumber(self, nums: List[int]) -> int:
        nums_sum = int((len(nums)*(len(nums)+1))/2)
        # for i in range(1, len(nums)+1):
        #     nums_sum  = nums_sum + i
        
        for i in nums:
            nums_sum = nums_sum - i
        
        return nums_sum