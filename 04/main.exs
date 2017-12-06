expect = fn (expected, actual) ->
    if expected === actual do
        IO.puts("Test passed!")
    else
        IO.puts("Test failed. Stopping tests.")
        System.halt(0)
    end
end

isValidPassphrase = fn phrase -> 
    words = String.split(phrase, " ")
    Enum.count(Enum.uniq(words)) === Enum.count(words)
end

expect.(isValidPassphrase.("aa bb cc dd ee"), true)
expect.(isValidPassphrase.("aa bb cc dd aa"), false)
expect.(isValidPassphrase.("aa bb cc dd aaa"), true)

IO.puts("Running test input")
{ :ok, data } = File.read "04/input.txt"
lines = String.split(data, "\n")
answer = Enum.reduce(lines, 0, fn(line, acc) -> 
    if isValidPassphrase.(line) do 
        1 + acc 
    else 
        0 + acc 
    end
end)
IO.puts("Final answer: #{ answer }")
