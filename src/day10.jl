

function part1()
    adapters = open("inputfiles/day10/input.txt") do io
        parse.(Int, eachline(io))
    end
    
    diff1s = 0
    diff3s = 0
    
    push!(adapters, 0)
    push!(adapters, maximum(adapters) + 3)
    sort!(adapters)
    
    for i in 1:length(adapters) - 1
        if adapters[i + 1] - adapters[i] == 1
            diff1s += 1
        elseif adapters[i + 1] - adapters[i] == 3
            diff3s += 1
        end
    end
    
    println("$diff1s * $diff3s = $(diff1s * diff3s)")
end


function part2()
    adapters = open("inputfiles/day10/input.txt") do io
        parse.(Int, eachline(io))
    end
    
    push!(adapters, 0)
    push!(adapters, maximum(adapters) + 3)
    sort!(adapters)
    
    amt_combs_from_ind = zeros(Int, length(adapters))
    amt_combs_from_ind[end] = 1
    
    for i in length(adapters) - 1:-1:1
        tmp = 0
        for j in 1:3
            if i + j <= length(adapters) && 1 <= adapters[i + j] - adapters[i] <= 3
                tmp += amt_combs_from_ind[i + j]
            end
        end
        amt_combs_from_ind[i] = tmp
    end
    
    amt_combs_from_ind[1]
end
