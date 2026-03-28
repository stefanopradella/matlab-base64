# matlab-base64

This is a MATLAB implementation of base64 encoding and decoding functions, to be use instead of the builtin functions `matlab.net.base64encode` and `matlab.net.base64decode`.

Compared to the builtin functions, this implementation:
- Supports both standard base64 and base64URL protocols
- Is faster thanks to the vectorized implementation
- Is ready to generate C-code

## Performance
The script `evalPerformance` can be used to compare the execution time of this implementation compared to the MATLAB builtin functions.
The following values have been obtained with 1000 iterations over random input vectors, of variable length up to 1024 bytes. 

```
===== ENCODER =====
matlab.net.base64encode execution time: 4.17 s
base64Encode execution time: 0.18 s  

===== DECODER =====
matlab.net.base64decode execution time: 0.32 s
base64Decode execution time: 0.21 s
```

This test has been run on the following hardware:
- Ubuntu 24.04.4 LTS
- MATLAB R2025b Update 5
- Ryzen 7 1700
- 16 GB RAM