// Task
// Implement function getMinMax which takes array as an argument
// and print max and min of its elements

package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	if len(os.Args) >= 2 {
		var num, err = strconv.ParseFloat(os.Args[1], 64)
		if err != nil {
			fmt.Println("Error input format.")
			return
		}
		min := num
		max := num
		for i := 2; i < len(os.Args); i++ {
			num, err = strconv.ParseFloat(os.Args[i], 64)
			if err != nil {
				fmt.Println("Error input format.")
				return
			}
			if num > max {
				max = num
			}
			if num < min {
				min = num
			}
		}
		fmt.Println("min = ", min)
		fmt.Println("max = ", max)
	} else {
		fmt.Println("Incorrect count of arguments.")
	}

}
