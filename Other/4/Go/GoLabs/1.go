// Task
// Write code for solving next:
// Output question "How are you?". Read the answer value from console
// and output: "You are (answer)"

package main

import (
	"fmt"
)

func main() {
	var answer string
	fmt.Println("How are you?")
	fmt.Scanln(&answer)
	fmt.Println("You are", answer)
}
