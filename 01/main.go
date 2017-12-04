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

func test() bool {
	dat, err := ioutil.ReadFile("01/tests.json")
	check(err)
	var tests = []testCase{}
	err = json.Unmarshal(dat, &tests)
	check(err)

	ok := true
	fmt.Println("Running tests:")
	fmt.Println("============")
	for i := 0; i < len(tests); i++ {
		fmt.Printf("Test %d: %s ", i+1, tests[i].Input)
		result := sumCaptcha([]byte(tests[i].Input))

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

func sumCaptcha(dat []byte) int {
	captcha := []rune(string(dat))

	var err error
	total := 0

	firstDigit := captcha[0]
	finalDigit := captcha[len(captcha)-1]

	if firstDigit == finalDigit {
		total, err = strconv.Atoi(string(firstDigit))
		check(err)
	}

	lastDigit := 0
	for i := 0; i < len(captcha); i++ {
		digit, err := strconv.Atoi(string(captcha[i]))
		check(err)

		if digit == lastDigit {
			total += digit
		}
		lastDigit = digit
	}

	return total
}

func main() {
	ok := test()
	// ok := true
	if !ok {
		fmt.Println("Some tests failed and I refuse to run the actual input")
		os.Exit(3)
	}

	dat, err := ioutil.ReadFile("01/input.txt")
	check(err)
	fmt.Printf("Final answer: %d\n", sumCaptcha(dat))
}
