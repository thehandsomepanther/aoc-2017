expect = fn (expected, actual) ->
    if expected === actual do
        IO.puts("Test passed!")
    else
        IO.puts("Test failed. Stopping tests.")
        System.halt(0)
    end
end

isUniquePassphrase = fn phrase -> 
    words = String.split(phrase, " ")
    Enum.count(Enum.uniq(words)) === Enum.count(words)
end

isNonAnagramicPassphrase = fn phrase ->
    words = String.split(phrase, " ")
    Enum.count(words) === Enum.count(Enum.uniq(Enum.map(words, fn word -> 
        Enum.join(Enum.sort(String.split(word, ""))) 
    end)))
end

IO.puts("======== PART 1 ========")
expect.(isUniquePassphrase.("aa bb cc dd ee"), true)
expect.(isUniquePassphrase.("aa bb cc dd aa"), false)
expect.(isUniquePassphrase.("aa bb cc dd aaa"), true)

IO.puts("Running test input")
{ :ok, data } = File.read "04/input.txt"
lines = String.split(data, "\n")
answer = Enum.reduce(lines, 0, fn(line, acc) -> 
    if isUniquePassphrase.(line) do 
        1 + acc 
    else 
        0 + acc 
    end
end)
IO.puts("Final answer: #{ answer }\n")

IO.puts("======== PART 2 ========")
expect.(isNonAnagramicPassphrase.("abcde fghij"), true)
expect.(isNonAnagramicPassphrase.("abcde xyz ecdab"), false)
expect.(isNonAnagramicPassphrase.("a ab abc abd abf abj"), true)
expect.(isNonAnagramicPassphrase.("iiii oiii ooii oooi oooo"), true)
expect.(isNonAnagramicPassphrase.("oiii ioii iioi iiio"), false)

IO.puts("Running test input")
answer = Enum.reduce(lines, 0, fn(line, acc) -> 
    if isNonAnagramicPassphrase.(line) do 
        1 + acc 
    else 
        0 + acc 
    end
end)
IO.puts("Final answer: #{ answer }\n")
