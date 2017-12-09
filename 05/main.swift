#!usr/bin/swift
import Foundation

func parseJumps(_ jumps: String) -> [Int] {
    return jumps.split(separator: "\n").flatMap{ Int($0)! }
}

func calcJumps(_ jumps: inout [Int]) -> Int {
    var numJumps = 0
    var i = 0
    while (i >= 0 && i < jumps.count) {
        let next = i + jumps[i]
        jumps[i] = jumps[i] + 1
        numJumps += 1
        i = next
    }

    return numJumps
}

let example = "0\n3\n0\n1\n-3"
var exampleJumps = parseJumps(example)
print("Running tests on input")
let answer = calcJumps(&exampleJumps)
if (answer == 5) {
    print("Test passed, running on input")
    let dir = FileManager.default.currentDirectoryPath
    do {
        let input = try String(contentsOf: URL(fileURLWithPath: "\(dir)/05/input.txt"), encoding: .utf8)
        var inputJumps = parseJumps(input)
        print("Final answer: \(calcJumps(&inputJumps))")
    }
    catch {
        print("Error reading file: \(error)")
    }
} else {
    print("Test failed, expected 5 but got \(answer)")
}
