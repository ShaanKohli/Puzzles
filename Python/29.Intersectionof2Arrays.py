class Solution:
    def intersection(self, nums1: List[int], nums2: List[int]) -> List[int]:
        
        store_nums = {}
        
        result_nums = []
        
        for i in nums1:
            if i not in store_nums:
                store_nums[i] = 1
            
        for i in nums2:
            if i in store_nums:
                del store_nums[i]
                result_nums.append(i)
        
        return result_nums