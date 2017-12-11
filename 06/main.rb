#!/usr/bin/ruby
require 'set'

def countDupeConfig(bankStr)
    banks = bankStr.split(/\s/).map{ |x| x.to_i }
    configs = Set.new []
    cycles = 0

    while configs.add? banks.join do
        _, i = banks.each_with_index.reduce([0, 0]) do |(maxValue, maxIndex), (val, index)|
            if val > maxValue
                [val, index]
            else
                [maxValue, maxIndex]
            end
        end
        blocks = banks[i]
        banks[i] = 0

        while blocks > 0 do
            i = (i + 1) % banks.length
            banks[i] += 1
            blocks -= 1
        end

        cycles += 1
    end
    
    cycles
end

def countDupeDupeConfig(bankStr)
    banks = bankStr.split(/\s/).map{ |x| x.to_i }
    configs = {}
    cycles = 0

    while !configs[banks.join] do
        configs[banks.join] = cycles
        
        _, i = banks.each_with_index.reduce([0, 0]) do |(maxValue, maxIndex), (val, index)|
            if val > maxValue
                [val, index]
            else
                [maxValue, maxIndex]
            end
        end
        blocks = banks[i]
        banks[i] = 0

        while blocks > 0 do
            i = (i + 1) % banks.length
            banks[i] += 1
            blocks -= 1
        end

        cycles += 1
    end
    
    cycles - configs[banks.join]
end

example = '0 2 7 0'
puts "===== PART 1 ====="
answer = countDupeConfig(example)
if answer == 5
    puts "Test passed, running on input."

    open("06/input.txt") do |f|
        puts "Final answer: #{ countDupeConfig(f.read) }"
    end
else
    puts "Test failed, expected #{ 5 }, got #{ answer }"
end

puts ""
puts "===== PART 2 ====="
answer = countDupeDupeConfig(example)
if answer == 4
    puts "Test passed, running on input."

    open("06/input.txt") do |f|
        puts "Final answer: #{ countDupeDupeConfig(f.read) }"
    end
else
    puts "Test failed, expected #{ 4 }, got #{ answer }"
end
