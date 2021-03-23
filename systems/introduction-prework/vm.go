// Package vm implements a simple virtual machine fetch-decode-execute loop
package vm

import (
	"fmt"
)

const (
	Load                      = 0x01
	Store                     = 0x02
	Add                       = 0x03
	Sub                       = 0x04
	Halt                      = 0xff
	Addi                      = 0x05
	Subi                      = 0x06
	Jump                      = 0x07
	Beqz                      = 0x08
	writeableMemoryUpperLimit = 0x07
	memoryUpperLimit          = 0xff
	instructionIncrement      = 3
)

// Given a 256 byte array of "memory", run the stored program
// to completion, modifying the data in place to reflect the result
//
// The memory format is:
//
// 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f ... ff
// __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ ... __
// ^==DATA===============^ ^==INSTRUCTIONS==============^
//
func compute(memory []byte) error {

	registers := [3]byte{8, 0, 0} // PC, R1 and R2

	// Keep looping, like a physical computer's clock
	for {
		// fetch program counter and opcode
		pc := registers[0]
		opcode := memory[pc]

		if opcode == Halt {
			return nil
		}

		// fetch operands from memory using register values
		operand1 := memory[pc+1]
		operand2 := memory[pc+2]

		// decode and execute
		switch opcode {
		case Load:
			registers[operand1] = memory[operand2]
		case Store:
			if operand2 > writeableMemoryUpperLimit {
				return fmt.Errorf("memory address %x is not writeable", operand2)
			}
			memory[operand2] = registers[operand1]
		case Add:
			registers[operand1] += registers[operand2]
		case Sub:
			registers[operand1] -= registers[operand2]
		case Addi:
			registers[operand1] += operand2
		case Subi:
			registers[operand1] -= operand2
		case Jump:
			registers[0] = operand1
		case Beqz:
			if registers[operand1] == 0 {
				registers[0] += operand2
			}
		default:
			panic(fmt.Sprintf("unknown opcode: %d", opcode))
		}

		if opcode != Jump {
			registers[0] += instructionIncrement
		}

	}
}
