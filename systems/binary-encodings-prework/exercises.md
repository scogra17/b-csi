# Hexadecimal
## 1.1 
Convert from decimal to hexidecimal
Answer: 
```
9                                 = 0x09
136 = 136/16 + 136%16 = 8x16 + 8  = 0x88
247 = 247/16 + 247%16 = 15*16 + 7 = 0xf7
```

## 1.2
How many colors can be represented in RGB and hex? 
Answer: 
```
In both cases 256^3 = ~16M color values 
```
Additionally, [can you guess the color?](http://yizzle.com/whatthehex/)

## 1.3 

If you were to view `hellohex`, which is 17 bytes in size, 
how many hex characters would you expect? 
Answer: 
```
34 hex characters
```
Using `xxd -p hellohex` we see: 
```
output: 68656c6c6f 20776f726c 6420f09f98 800a
count:  0123456789 0123456789 0123456789 0123
```

Convert the first five bytes to binary: 
```
hex:    68          65          6c          6c          6f
binary: 0110 1000   0110 0101   0110 1100   0110 1100   0110 1111
```

# Integers
## 2.1 
Convert from decimal to binary
Answer: 
```
4   =    0b00000100
65  =    0b01000001
105 =    0b01101001
255 =    0b11111111

exponent   76543210          
```
Convert from binary to unsigned integers
Answer: 
```
0b10                         = 2
0b11                         = 3
0b1101100 = 64 + 32 + 8 + 4  = 108 
0b1010101 = 64 + 16 + 4 + 1  = 85
```

## 2.2 
Add two binary numbers
Answer: 
```
    1 
  0b11111111     =    255
+ 0b00001101     =   + 13
____________       ______
 0b100001100          268
 ```
 If the register is only a byte wide, we'll see the result as 0b00001100
 which is 12. This is a register overflow. 

## 2.3 
Convert from decimal to two's complement
Answer: 
```
127  = 0b01111111
-128 = 0b10000000
-1   = 0b11111111
1    = 0b00000001
-14  = 0b11110010
                
                                                 +ve   -ve
	 0          +1         +2             +127       | -128       -127           -1
NOTE 0b00000000 0b00000001 0b00000010 ... 0b01111111 | 0b10000000 0b10000001 ... 0b11111111 
```
Convert two's complement binary to decimal
Answer:
```
0b10000011 = -128 + 3      = -125 
0b11000100 = -128 + 64 + 4 = -60
```

## 2.4
Add two numbers with two's complement
Answer: 
```
  0b01111111  =  127
+ 0b10000000  = -128 
____________
    11111111  = -1
```

## 3.1
Is 9001 (in a separate file) encoded in big or little endian? 
Answer: 
```
9001 = 2*16^3 + 3*16^2 + 2*16 + 9 = 0x2329

This is how the number is stored, meaning it's stored as big endian 
```

## 3.2 
Find the sequence number, acknowledgment number, source port and destination port from tcpheader
Answer: 
```
> xxd -g 1 tcpheader
00000000: af 00 bc 06 44 1e 73 68 ef f2 a0 02 81 ff 56 00  ....D.sh......V.

sequence:         0x441e7368 = 1,142,846,312
acknowledgment:   0xeff2a002 = 4,025,655,298
source port:      0xaf00     = 44,800 
destination port: 0xbc06     = 48,134

```

## 5.1
