
# inp = [0, 3, 6]
inp = [14,8,16,0,1,17]


function part1()
    last_time = Dict(inp[i] => i for i in 1:length(inp))
    amt_times = Dict(i => 1 for i in inp)
    
    i = length(inp) + 1
    lastnum = inp[end]
    
    while i <= 2020
        n = if amt_times[lastnum] == 1
            0
        else
            i - 1 - last_time[lastnum]
        end
        last_time[lastnum] = i - 1
        amt_times[n] = get(amt_times, n, 0) + 1
        lastnum = n
        i += 1
    end
    
    println(lastnum)
end


function part2()
    last_time = Dict(inp[i] => i for i in 1:length(inp))
    amt_times = Dict(i => 1 for i in inp)
    
    i = length(inp) + 1
    lastnum = inp[end]
    
    while i <= 30000000
        n = if amt_times[lastnum] == 1
            0
        else
            i - 1 - last_time[lastnum]
        end
        last_time[lastnum] = i - 1
        amt_times[n] = get(amt_times, n, 0) + 1
        lastnum = n
        i += 1
    end
    
    println(lastnum)
end
