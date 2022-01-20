class Solution:
    def titleToNumber(self, columnTitle: str) -> int:
        columnTitle = columnTitle.lower()
        col_sum = 0
        for i in range(0, len(columnTitle)):
            col_sum  = col_sum + ((26** (len(columnTitle)-i-1))*(ord(columnTitle[i])-96))
    
        return col_sum