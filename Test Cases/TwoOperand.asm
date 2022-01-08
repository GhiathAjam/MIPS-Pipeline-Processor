# all numbers in hex format
# we always start by reset signal
# this is a commented line
.ORG 0  #this means the the following line would be  at address  0 , and this is the reset address
FF
#you should ignore empty lines

.ORG 2  #this is empty stack exception handler address
100

.ORG 4  #this is invalid addess exception handler address
150

.ORG 6  #this is int 0
200

.ORG 8  #this is int 2
250

.ORG FF
IN R1        #add 5 in R1
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
IN R2        #add 0x19 in R2
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
IN R3        #FFFF
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
IN R4        #F320
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
MOV R5,R3    #R5 = FFFF , flags no change
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
ADD R4,R1,R4    #R4= F325 , C-->0, N-->1, Z-->0
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
SUB R6,R5,R4    #R6= 0CDA , C-->0, N-->0,Z-->0 here carry is implemented as borrow you can implement it as not borrow
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
AND R4,R7,R4    #R4= 0000 , C-->no change, N-->0, Z-->1
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
IADD R2,R2,FFFF #R2= 0018 (C = 1,N,Z= 0)
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
ADD R2,R1,R2    #R2= 001D (C,N,Z= 0)
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
NOP            #No change
