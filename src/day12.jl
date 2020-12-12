

reg = r"(\w)(\d+)"


function part1()
    open("inputfiles/day12/input.txt") do io
        dir = 1 + 0im
        pos = 0im
        for l in eachline(io)
            m = match(reg, l)
            n = parse(Int, m.captures[2])
            if m.captures[1] == "N"
                pos += 1im * n
            elseif m.captures[1] == "S"
                pos -= 1im * n
            elseif m.captures[1] == "E"
                pos += n
            elseif m.captures[1] == "W"
                pos -= n
            elseif m.captures[1] == "F"
                pos += dir * n
            elseif m.captures[1] == "L"
                dir *= 1im^(n ÷ 90)
            elseif m.captures[1] == "R"
                dir *= (-1im)^(n ÷ 90)
            end
        end
        abs(real(pos)) + abs(imag(pos))
    end
end


function part2()
    open("inputfiles/day12/input.txt") do io
        pos = 0im
        waypoint = 10 + 1im
        for l in eachline(io)
            m = match(reg, l)
            n = parse(Int, m.captures[2])
            if m.captures[1] == "N"
                waypoint += 1im * n
            elseif m.captures[1] == "S"
                waypoint -= 1im * n
            elseif m.captures[1] == "E"
                waypoint += n
            elseif m.captures[1] == "W"
                waypoint -= n
            elseif m.captures[1] == "F"
                pos += waypoint * n
            elseif m.captures[1] == "L"
                waypoint *= 1im^(n ÷ 90)
            elseif m.captures[1] == "R"
                waypoint *= (-1im)^(n ÷ 90)
            end
        end
        abs(real(pos)) + abs(imag(pos))
    end
end
