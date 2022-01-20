class Solution:
    def containsDuplicate(self, nums: List[int]) -> bool:
        dup_dict = {}
        for i in range(0, len(nums)):
            if nums[i] in dup_dict:
                return True
            else:
                dup_dict[nums[i]] = 1
        return False