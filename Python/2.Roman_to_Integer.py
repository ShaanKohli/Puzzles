class Solution(object):
    def romanToInt(self, s):
        roman_integer = {
            "M" : 1000,
            "CM" : 900,
            "D": 500,
            "CD" : 400,
            "C" :100,
            "XC" : 90,
            "L" : 50,
            "XL" : 40,
            "X" : 10,
            "IX" : 9,
            "V" : 5,
            "IV" : 4,
            "I" : 1,
        }
        val = 0
        i = 0
        while (i < len(s)):
            if s[i:i+2] in roman_integer:
                val = val + roman_integer[s[i:i+2]]
                i  = i+2
            else:
                val = val + roman_integer[s[i]]
                i = i+1
        return val