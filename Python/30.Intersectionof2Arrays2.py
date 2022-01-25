class Solution:
    def intersect(self, nums1: List[int], nums2: List[int]) -> List[int]:
        store_nums= {}
        
        result_list = []
        
        for i in nums1:
            if i not in store_nums:
                store_nums[i] = 1
            else:
                store_nums[i] += 1
        
        for i in nums2:
            if i in store_nums:
                store_nums[i] -=1
                result_list.append(i)
                
                if store_nums[i] == 0:
                    del store_nums[i]



        
        return result_list