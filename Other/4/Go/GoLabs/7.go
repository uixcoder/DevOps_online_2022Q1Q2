// Task
// Implement function basicOperations which takes
// two integer numbers as arguments and returns
// calculated expressions (see Lab 3):
// a + b, a - b, a * b, a / b

package main

import (
	"errors"
	"fmt"
	"os"
	"strconv"
)

func basicOperations(a int64, b int64, opCode string) (int64, error) {
	switch opCode {
	case "+":
		return a + b, nil
	case "-":
		return a - b, nil
	case "*":
		return a * b, nil
	case "/":
		return a / b, nil
	default:
		return 0, errors.New("Invalid Operation")
	}
}

func main() {
	if len(os.Args) == 3 {
		a, err1 := strconv.ParseInt(os.Args[1], 10, 64)
		b, err2 := strconv.ParseInt(os.Args[2], 10, 64)
		if err1 == nil && err2 == nil {
			var res, err = basicOperations(a, b, "+")
			if err == nil {
				fmt.Println("a + b = ", res)
			}
			res, err = basicOperations(a, b, "-")
			if err == nil {
				fmt.Println("a - b = ", res)
			}
			res, err = basicOperations(a, b, "*")
			if err == nil {
				fmt.Println("a * b = ", res)
			}
			res, err = basicOperations(a, b, "/")
			if err == nil {
				fmt.Println("a / b = ", res)
			}
			res, err = basicOperations(a, b, "^")
			if err == nil {
				fmt.Println("a ^ b = ", res)
			} else {
				fmt.Println("a ^ b = ", err)
			}
		} else {
			fmt.Println("Error input format.")
		}
	} else {
		fmt.Println("Incorrect count of arguments.")
	}

}
