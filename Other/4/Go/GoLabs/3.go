// Task
// Write code for solving next:
// define integer variables a and b, read values a and b
// as command-line arguments and print calculated expressions:

// a + b, a - b, a * b, a / b.

package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	if len(os.Args) == 3 {
		a, err1 := strconv.ParseInt(os.Args[1], 10, 64)
		b, err2 := strconv.ParseInt(os.Args[2], 10, 64)
		if err1 == nil && err2 == nil {
			fmt.Println("a + b = ", a+b)
			fmt.Println("a - b = ", a-b)
			fmt.Println("a * b = ", a*b)
			fmt.Println("a / b = ", a/b)
		} else {
			fmt.Println("Error input format.")
		}
	} else {
		fmt.Println("Incorrect count of arguments.")
	}

}
