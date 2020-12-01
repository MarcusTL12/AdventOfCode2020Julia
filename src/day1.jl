using Base.Iterators


function part1()
    numbers = open("inputfiles/day1/input.txt") do io
        [parse(Int, l) for l in eachline(io)]
    end
    #
    for (a, b) in product(numbers, numbers)
        if a + b == 2020
            return a * b
        end
    end
end


function part2()
    numbers = open("inputfiles/day1/input.txt") do io
        [parse(Int, l) for l in eachline(io)]
    end
    #
    for (a, b, c) in product(numbers, numbers, numbers)
        if a + b + c == 2020
            return a * b * c
        end
    end
end
