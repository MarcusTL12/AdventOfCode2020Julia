

reg = r"(\d+)-(\d+) (\w): (\w+)"


function is_password_valid(l)
    m = match(reg, l)
    a = parse(Int, m.captures[1])
    b = parse(Int, m.captures[2])
    c = m.captures[3][1]
    x = count(x -> x == c, m.captures[4])
    a <= x <= b
end


function part1()
    open("inputfiles/day2/input.txt") do io
        count(is_password_valid, eachline(io))
    end
end


function is_password_valid2(l)
    m = match(reg, l)
    a = parse(Int, m.captures[1])
    b = parse(Int, m.captures[2])
    c = m.captures[3][1]
    count(i -> m.captures[4][i] == c, (a, b)) == 1
end


function part2()
    open("inputfiles/day2/input.txt") do io
        count(is_password_valid2, eachline(io))
    end
end
