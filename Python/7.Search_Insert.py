class Solution:
    def searchInsert(self, nums: List[int], target: int) -> int:
        if target in nums:
            return nums.index(target)
        if target < nums[0]:
            return 0
        if target > nums[-1]:
            return len(nums)
        for i in range(0,len(nums)-1):
            if target > nums[i] and target < nums[i+1]:
                return i+1
        
