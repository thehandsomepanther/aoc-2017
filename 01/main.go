package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"strconv"
)

type testCase struct {
	Input    string
	Expected int
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func test1() bool {
	dat, err := ioutil.ReadFile("01/tests-1.json")
	check(err)
	var tests = []testCase{}
	err = json.Unmarshal(dat, &tests)
	check(err)

	ok := true
	fmt.Println("Running tests:")
	fmt.Println("============")
	for i := 0; i < len(tests); i++ {
		fmt.Printf("Test %d: %s ", i+1, tests[i].Input)
		result := sumCaptcha1([]byte(tests[i].Input))

		if result == tests[i].Expected {
			fmt.Printf("✅\n")
		} else {
			fmt.Printf("❌\n")
			fmt.Printf("Expected: %d\n", tests[i].Expected)
			fmt.Printf("Got: %d\n", result)
			ok = false
		}

		fmt.Println("============")
	}

	return ok
}

func sumCaptcha1(dat []byte) int {
	captcha := []rune(string(dat))
	total := 0

	lastDigit := 0
	for i := 0; i <= len(captcha); i++ {
		digit, err := strconv.Atoi(string(captcha[i%len(captcha)]))
		check(err)

		if digit == lastDigit {
			total += digit
		}
		lastDigit = digit
	}

	return total
}

func test2() bool {
	dat, err := ioutil.ReadFile("01/tests-2.json")
	check(err)
	var tests = []testCase{}
	err = json.Unmarshal(dat, &tests)
	check(err)

	ok := true
	fmt.Println("Running tests:")
	fmt.Println("============")
	for i := 0; i < len(tests); i++ {
		fmt.Printf("Test %d: %s ", i+1, tests[i].Input)
		result := sumCaptcha2([]byte(tests[i].Input))

		if result == tests[i].Expected {
			fmt.Printf("✅\n")
		} else {
			fmt.Printf("❌\n")
			fmt.Printf("Expected: %d\n", tests[i].Expected)
			fmt.Printf("Got: %d\n", result)
			ok = false
		}

		fmt.Println("============")
	}

	return ok
}

func sumCaptcha2(dat []byte) int {
	captcha := []rune(string(dat))
	total := 0

	for i := 0; i < len(captcha); i++ {
		digit, err := strconv.Atoi(string(captcha[i%len(captcha)]))
		check(err)
		nextDigit, err := strconv.Atoi(string(captcha[(i+len(captcha)/2)%len(captcha)]))
		check(err)

		if digit == nextDigit {
			total += digit
		}
	}

	return total
}

func main() {
	fmt.Println("Part 1:")
	ok := test1()
	if !ok {
		fmt.Println("Some tests failed and I refuse to run the actual input")
		os.Exit(3)
	}

	dat, err := ioutil.ReadFile("01/input.txt")
	check(err)
	fmt.Printf("Final answer for part 1: %d\n", sumCaptcha1(dat))

	fmt.Println("Part 2:")
	ok = test2()
	if !ok {
		fmt.Println("Some tests failed and I refuse to run the actual input")
		os.Exit(3)
	}
	fmt.Printf("Final answer for part 2: %d\n", sumCaptcha2(dat))
}
