// Task
// Write code for solving next:
// Read value as command-line argument and
// detect if this one is integer. If so, print OK,
// otherwise print Wrong.
//
package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	if len(os.Args) == 2 {
		num, err := strconv.ParseInt(os.Args[1], 10, 64)
		if err == nil {
			fmt.Println(num)
		} else {
			fmt.Println("Error input format.")
		}
	} else {
		fmt.Println("Incorrect count of arguments.")
	}

}
