class Solution:
    def containsNearbyDuplicate(self, nums: List[int], k: int) -> bool:
        map_dict = {}
        for index, value in enumerate(nums):
            if value in map_dict:
                if index - map_dict[value] <=k:
                    return True

                map_dict[value] = index

            else:
                map_dict[value] = index

        return False