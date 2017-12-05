fun expect(expected: Int, actual: Int): Boolean {
    if (expected == actual) {
        println("Test passed!")
        return true
    } else {
        println("Test failed. Expected ${ expected } but got ${ actual }.")
        return false
    }
}

fun calcSpiralDistance(n: Int): Int {
    if (n == 1) {
        return 0
    }

    var root = 1
    while (root * root < n) {
        root += 2
    }

    var min = Int.MAX_VALUE
    var pos = root * root - root / 2

    while (pos > (root - 2) * (root - 2)) {
        min = Math.min(min, Math.abs(n - pos))
        pos -= root + 1
    }

    return root / 2 + min
}

fun main(args: Array<String>) {
    val correct = expect(0, calcSpiralDistance(1)) &&
        expect(3, calcSpiralDistance(12)) &&
        expect(2, calcSpiralDistance(23)) &&
        expect(31, calcSpiralDistance(1024))

    if (correct) {
        println("Test cases passed. Running on input.")
        println("Final answer: ${ calcSpiralDistance(368078) }")
    } else {
        println("Some test cases failed.")
    }
}
