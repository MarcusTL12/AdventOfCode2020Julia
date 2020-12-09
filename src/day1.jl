

function part1()
    numbers = open("inputfiles/day1/input.txt") do io
        [parse(Int, l) for l in eachline(io)]
    end
    # 
    for i in 1:length(numbers), j in i + 1:length(numbers)
        if numbers[i] + numbers[j] == 2020
            return numbers[i] * numbers[j]
        end
    end
end


function part2()
    numbers = open("inputfiles/day1/input.txt") do io
        [parse(Int, l) for l in eachline(io)]
    end
    # 
    for i in 1:length(numbers),
        j in i + 1:length(numbers),
        k in j + 1:length(numbers)
        if numbers[i] + numbers[j] + numbers[k] == 2020
            return numbers[i] * numbers[j] * numbers[k]
        end
    end
end
