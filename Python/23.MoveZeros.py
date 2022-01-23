class Solution:
    def moveZeroes(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        pointer = 0
        swap_val = 0
        for i in range(0, len(nums)):
            if nums[i] == 0 and i == pointer:
                pointer = i
            elif nums[i] !=0:
                swap_val  = nums[pointer]
                nums[pointer]  = nums[i]
                nums[i] = swap_val
                pointer  +=1
            else:
                pass
        
        return nums