import streams
import strutils
import sequtils
import posix

proc calcChecksum(filepath: string): int =
    var
        fs = newFileStream(filepath, fmRead)
        line = ""

    if not isNil(fs):
        var checksum = 0.0
        while(fs.readLine(line)):
            var 
                max = NegInf
                min = Inf
                nums = map(splitWhitespace(line), proc(s: string): int = parseInt(s))

            for i, n in nums:
                var num = float(n)
                if num < min:
                    min = num

                if num > max:
                    max = num
            
            checksum += max - min
        
        fs.close()
        return int(checksum)

echo "Running test"
var testResult = calcChecksum("02/test.txt")
if testResult != 18:
    echo "Test failed. Expected 18, got ", testResult
else:
    echo "Test passed! Running on puzzle input"
    echo "Final answer: ", calcChecksum("02/input.txt")