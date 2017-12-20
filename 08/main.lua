compare = {
    ['>'] = function (l, r) return l > r end,
    ['>='] = function (l, r) return l >= r end,
    ['<'] = function (l, r) return l < r end,
    ['<='] = function (l, r) return l <= r end,
    ['=='] = function (l, r) return l == r end,
    ['!='] = function (l, r) return l ~= r end
}

mutate = {
    ['inc'] = function (val, mod) return val + mod end,
    ['dec'] = function (val, mod) return val - mod end
}

function maxRegister(filepath)
    registers = {}

    for line in io.lines(filepath) do
        tokens = {}
        for t in string.gmatch(line, "%S+") do
            table.insert(tokens, t)
        end

        registers[tokens[1]] = registers[tokens[1]] or 0
        registers[tokens[5]] = registers[tokens[5]] or 0

        if compare[tokens[6]](registers[tokens[5]], tonumber(tokens[7])) then
            registers[tokens[1]] = mutate[tokens[2]](registers[tokens[1]], tonumber(tokens[3]))
        end
    end

    max = -math.huge
    for _, value in pairs(registers) do 
        max = math.max(max, value)
    end

    return max
end

print("Running on test example.")
if maxRegister('08/example.txt') == 1 then
    print("Test passed. Running on input")
    print("Final answer: " .. maxRegister('08/input.txt'))
else
    print("Test failed.")
end
