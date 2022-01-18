class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        max_curr_sum  = nums[0]
        max_end_sum  = nums[0]
        
        for i in range(1, len(nums)):
            max_curr_sum  = max(nums[i], max_curr_sum +nums[i])
            max_end_sum = max(max_curr_sum, max_end_sum)
        
        return max_end_sum