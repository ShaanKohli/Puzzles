s = 'ab'
t=  'a'
count = 0
for i in s:
  if i in t:
    count +=1

if count == len(t):
  print(True)
else:
  print(False)
