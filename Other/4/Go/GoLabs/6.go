// Task
// Write code for solving next:
// read string without space as command-line argument
// (it means read symbols until first space-symbol)
// and print each of them on separate line

package main

import (
	"fmt"
	"os"
)

func main() {
	if len(os.Args) == 2 {
		str := os.Args[1]
		for i := 0; i < len(str); i++ {
			fmt.Printf("%c\n", str[i])
		}
	} else {
		fmt.Println("Incorrect count of arguments.")
	}

}
