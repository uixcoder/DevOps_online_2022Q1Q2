// Task
// Write code for solving next:
// read 3 integer numbers as command-line arguments
// and print max and min of them.

package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	if len(os.Args) == 4 {
		a, err1 := strconv.ParseInt(os.Args[1], 10, 64)
		b, err2 := strconv.ParseInt(os.Args[2], 10, 64)
		c, err3 := strconv.ParseInt(os.Args[3], 10, 64)
		if err1 == nil && err2 == nil && err3 == nil {
			max := a
			min := a
			if b > max {
				max = b
			} else {
				min = b
			}
			if c > max {
				max = c
			}
			if c < min {
				min = c
			}
			fmt.Println("max(a, b, c) = ", max)
			fmt.Println("min(a, b, c) = ", min)
		} else {
			fmt.Println("Error input format.")
		}
	} else {
		fmt.Println("Incorrect count of arguments.")
	}

}
