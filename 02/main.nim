import streams
import strutils
import sequtils

proc calcMinMaxChecksum(filepath: string): int =
    var
        fs = newFileStream(filepath, fmRead)
        line = ""
        checksum = 0.0

    if not isNil(fs):
        while fs.readLine(line):
            var 
                max = NegInf
                min = Inf
                nums = map(splitWhitespace(line), proc(s: string): float = parseFloat(s))

            for i, n in nums:
                if n < min:
                    min = n

                if n > max:
                    max = n
            
            checksum += max - min
        
        fs.close()
        return int(checksum)
    else:
        var e: ref OSError
        new(e)
        e.msg = "File is nil"
        raise e

proc calcDivisibleChecksum(filepath: string): int =
    var
        fs = newFileStream(filepath, fmRead)
        line = ""
        checksum = 0
    
    if not isNil(fs):
        while fs.readLine(line):
            var nums = map(splitWhitespace(line), proc(s: string): int = parseInt(s))
            
            for i in 0..len(nums)-2:
                for j in i+1..len(nums)-1:
                    var 
                        numerator = max(nums[i], nums[j])
                        denominator = min(nums[i], nums[j])
                    if numerator %% denominator == 0:
                        checksum += numerator /% denominator
    else:
        var e: ref OSError
        new(e)
        e.msg = "File is nil"
        raise e
    
    fs.close()
    return checksum

echo "======== PART 1 ========"
echo "Running test"
var testResult = calcMinMaxChecksum("02/test-1.txt")
if testResult != 18:
    echo "Test failed. Expected 18, got ", testResult
else:
    echo "Test passed! Running on puzzle input"
    echo "Final answer: ", calcMinMaxChecksum("02/input.txt")
echo ""
echo "======== PART 2 ========"
testResult = calcDivisibleChecksum("02/test-2.txt")
if testResult != 9:
    echo "Test failed. Expected 9, got ", testResult
else:
    echo "Test passed! Running on puzzle input"
    echo "Final answer: ", calcDivisibleChecksum("02/input.txt")
