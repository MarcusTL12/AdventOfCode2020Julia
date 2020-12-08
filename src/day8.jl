

function part1()
    inp = open("inputfiles/day8/input.txt") do io
        collect(eachline(io))
    end
    
    i = 1
    
    acc = 0
    
    i_set = Set{Int}()
    
    while !(i in i_set)
        push!(i_set, i)
        op, n = split(inp[i])
        
        if op == "acc"
            acc += parse(Int, n)
        elseif op == "jmp"
            i += parse(Int, n) - 1
        else
        end
        
        i += 1
    end
    
    acc
end


function part2()
    inp = open("inputfiles/day8/input.txt") do io
        collect(eachline(io))
    end
    
    for change_ind in 1 : length(inp)
        n_inp = copy(inp)
        
        let tmp = inp[change_ind]
            op, n = split(tmp)
            if op == "jmp"
                op = "nop"
            elseif op == "nop"
                op == "jmp"
            else
                continue
            end
            n_inp[change_ind] = "$op $n"
        end
        
        i = 1
        
        acc = 0
        
        i_set = Set{Int}()
        
        while !(i in i_set) && 1 <= i <= length(inp)
            push!(i_set, i)
            op, n = split(n_inp[i])
            
            if op == "acc"
                acc += parse(Int, n)
            elseif op == "jmp"
                nn = parse(Int, n)
                i += nn - 1
            end
            
            i += 1
        end
        
        if i > length(inp)
            println(change_ind)
            return acc
        end
    end
end
