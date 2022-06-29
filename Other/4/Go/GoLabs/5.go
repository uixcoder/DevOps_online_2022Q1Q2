// Task
// Write code for solving next:
// read 3 float numbers as command-line arguments and
// if they all belong to the range [-5,5], print OK,
// otherwise print Wrong.

package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	if len(os.Args) == 4 {
		a, err1 := strconv.ParseFloat(os.Args[1], 64)
		b, err2 := strconv.ParseFloat(os.Args[2], 64)
		c, err3 := strconv.ParseFloat(os.Args[3], 64)
		if err1 == nil && err2 == nil && err3 == nil {
			if (a >= -5) && (a <= 5) && (b >= -5) && (b <= 5) && (c >= -5) && (c <= 5) {
				fmt.Println("OK")
			} else {
				fmt.Println("Wrong")
			}
		} else {
			fmt.Println("Error input format.")
		}
	} else {
		fmt.Println("Incorrect count of arguments.")
	}

}
