

function is_password_valid(l)
    parts = split(l)
    nums = parse.(Int, split(parts[1], '-'))
    c = parts[2][1]
    x = count(x -> x == c, parts[3])
    nums[1] <= x <= nums[2]
end


function part1()
    open("inputfiles/day2/input.txt") do io
        count(is_password_valid, eachline(io))
    end
end


function is_password_valid2(l)
    parts = split(l)
    (a, b) = parse.(Int, split(parts[1], '-'))
    c = parts[2][1]
    parts[3][a] == c && parts[3][b] != c || parts[3][a] != c && parts[3][b] == c
end


function part2()
    open("inputfiles/day2/input.txt") do io
        count(is_password_valid2, eachline(io))
    end
end
