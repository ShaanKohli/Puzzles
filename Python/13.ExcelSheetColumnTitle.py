class Solution:
    def convertToTitle(self, columnNumber: int) -> str:
        alpha = {
            1:'A', 
            2:'B', 
            3:'C', 
            4:'D', 
            5:'E', 
            6:'F', 
            7:'G', 
            8:'H', 
            9:'I', 
            10:'J', 
            11:'K', 
            12:'L', 
            13:'M', 
            14:'N', 
            15:'O', 
            16:'P', 
            17:'Q', 
            18:'R', 
            19:'S', 
            20:'T', 
            21:'U', 
            22:'V', 
            23:'W', 
            24:'X', 
            25:'Y', 
            26:'Z'
        }
        
        excel_col = ""
        while columnNumber > 0:
            remainder = columnNumber%26
            whole = columnNumber//26
            
            if (remainder == 0) and (whole >=1):
                excel_col = alpha[26] + excel_col
                columnNumber = (whole -1)
                
            elif (remainder != 0):
                excel_col = alpha[remainder] + excel_col
                columnNumber = whole
            
            else:
                columnNumber = whole
                
            
        
        return excel_col