class Solution(object):
    def removeDuplicates(self, nums):
        for i in range(len(nums)-1,0,-1):
            if nums[i] == nums[i-1]:
                nums.remove(nums[i-1])
                
        return len(nums)
        