

function bordpass_num(s)
    row_low = 0
    row_high = 127
    
    for i in 1 : 7
        m = (row_low + row_high) ÷ 2
        if s[i] == 'F'
            row_high = m
        else
            row_low = m
        end
    end
    
    col_low = 0
    col_high = 7
    
    for i in 8 : length(s)
        m = (col_low + col_high) ÷ 2
        if s[i] == 'L'
            col_high = m
        else
            col_low = m
        end
    end
    
    8 * row_high + col_high
end


function part1()
    open("inputfiles/day5/input.txt") do io
        maximum(bordpass_num, eachline(io))
    end
end


function part2()
    nums = open("inputfiles/day5/input.txt") do io
        Set(bordpass_num(l) for l in eachline(io))
    end
    allnums = Set(1 : 1023)
    seats = sort!(collect(setdiff(allnums, nums)))
    //
    for i in 1 : length(seats)
        if seats[i] != seats[i + 1] - 1
            return seats[i + 1]
        end
    end
end
