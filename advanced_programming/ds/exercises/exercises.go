package main 

import (
	"fmt"
	"unsafe"
	// "reflect"
)

const INT_SIZE_BYTES = 8
 
// Given a float64, return a uint64 with the same binary representation.
func convertFloat(num float64) uint64 {
	numAddr := (*uint64)(unsafe.Pointer(&num))
	
	return *numAddr
}

// Given two strings, return a boolean that indicates whether the underlying
// string data is stored at the same memory location 
func isSameAddress(str1, str2 string) bool {
	addr1 := (*uint64)(unsafe.Pointer(&str1))
	addr2 := (*uint64)(unsafe.Pointer(&str2))
	
  return *addr1 == *addr2
}

// Given an []int slice, return the sum of the values in the slice without 
// using range or the [] operator 
func sumOfSlice(nums []int) int {
	numsAddr := unsafe.Pointer(&nums)
	numsZeroIndexAddr := unsafe.Pointer(uintptr(*(*uint64)(numsAddr)))
	numsLenAddr := unsafe.Pointer((uintptr(numsAddr) + uintptr(8)))
	numsLen := *(*uint64)(numsLenAddr)


	var sum int = 0
	for i := 0; i < int(numsLen); i++ {
		sum += *(*int)(unsafe.Pointer(uintptr(numsZeroIndexAddr) + uintptr(8*i)))
	}

	return sum
}

// Given a map[int]int, return the sum of all keys and all values in the map
// without using range or the [] operator
// Consult runtime.map.go to reverse engineer how Go's maps are represented, 
// starting with the hmap struct 
func sumOfMap(kv map[int]int) (int, int) {
	return 0, 0
} 

func main() {
	// Exercise #1
	var g float64 = 9.81
	fmt.Printf("%064b\n", convertFloat(g))

	// Exercise #2
	s1 := "hello"
	s2 := s1[0:3]
	s3 := "goodbye"
	fmt.Println(isSameAddress(s1, s2)) // true 
	fmt.Println(isSameAddress(s1, s3)) // false 

	// Exercise #3
	a1 := []int{1, 2, 3}
	a2 := []int{3, 6, 7, 11, 87}
	fmt.Println(sumOfSlice(a1)) // 6
	fmt.Println(sumOfSlice(a2)) // 114

	// Exercise #4

}