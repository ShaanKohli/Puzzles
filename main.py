#def reverseVowels(self, s: str) -> str:
input_string = 'leetcode'
vowel_string = ''
index_string = []
input_string = list(input_string)

for index, letter in enumerate(input_string):
  if letter.lower() in ['a', 'e','i','o','u']:
    index_string.append(index)
    vowel_string = vowel_string +letter

  ## reverse both 
reverse_vowel_string = list(vowel_string[::-1])

for i in range(0, len(input_string)):
  input_string[index_string[i]] = vowel_string[i]

input_string = "".join(input_string)

print(input_string)