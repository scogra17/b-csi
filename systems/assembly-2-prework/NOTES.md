# Notes

## Control transfer 
* Passing control from function P to Q involves simply setting the program counter to the starting address of the code Q
* `call` Q pushes a return address onto the stack ans sets the PC to the beginning of Q. The return address is the address immedaitely following the call instruction. Conversely, `ret` pops an address A off the stack and sets the PC to A
