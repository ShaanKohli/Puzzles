nums1  =[1,2,2,1]
nums2 = [2,2]

store_nums= {}
        
result_list = []
        
for i in nums1:
  if i not in store_nums:
    store_nums[i] = 1
  if i in store_nums:
    store_nums[i] += 1



for i in nums2:
  if i in store_nums:
    if store_nums[i] == 1:
      del store_nums[i]
      result_list.append(i)
    
    if store_nums[i] >= 2:
      store_nums[i] -=1
      result_list.append(i)

    

  
  
    print(result_list)
        

