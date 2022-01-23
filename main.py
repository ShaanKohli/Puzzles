nums = [0,0,1]
i = 0
while i < len(nums)-1:
  #print(nums)
  if nums[i] == 0:
    del nums[i]
    nums.append(nums[i])
    i +=1
  else:
    i +=1
  print(len(nums))



print(nums)