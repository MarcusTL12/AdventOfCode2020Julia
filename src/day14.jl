using Combinatorics


mask_reg = r"mask = (.+)"
mem_reg = r"mem\[(\d+)\] = (\d+)"


function part1()
    open("inputfiles/day14/input.txt") do io
        mask = Dict{Int,Bool}()
        mem = Dict{Int,Int}()
        for l in eachline(io)
            if (m = match(mask_reg, l); !isnothing(m))
                for (i, c) in enumerate(reverse(m.captures[1]))
                    if c == 'X' && haskey(mask, i)
                        delete!(mask, i)
                    elseif c == '1'
                        mask[i] = true
                    elseif c == '0'
                        mask[i] = false
                    end
                end
            elseif (m = match(mem_reg, l); !isnothing(m))
                i = parse(Int, m.captures[1])
                n = parse(Int, m.captures[2])
                mem[i] = n
                for (k, v) in mask
                    if v
                        mem[i] |= 1 << (k - 1)
                    else
                        mem[i] &= ~(1 << (k - 1))
                    end
                end
            end
        end
        sum(values(mem))
    end
end


function part2()
    open("inputfiles/day14/input.txt") do io
        mask = Dict{Int,Bool}()
        mem = Dict{Int,Int}()
        address_floating = Int[]
        for l in eachline(io)
            if (m = match(mask_reg, l); !isnothing(m))
                for (i, c) in enumerate(reverse(m.captures[1]))
                    if c == 'X' && haskey(mask, i)
                        delete!(mask, i)
                    elseif c == '1'
                        mask[i] = true
                    elseif c == '0'
                        mask[i] = false
                    end
                end
            elseif (m = match(mem_reg, l); !isnothing(m))
                address = parse(Int, m.captures[1])
                n = parse(Int, m.captures[2])
                for (k, v) in mask
                    if v
                        address |= 1 << (k - 1)
                    end
                end
                resize!(address_floating, 0)
                for i in 1 : 36
                    if !haskey(mask, i)
                        address &= ~(1 << (i - 1))
                        push!(address_floating, i)
                    end
                end
                mem[address] = n
                for comb in combinations(address_floating)
                    effective_address = address + sum(2^(k - 1) for k in comb)
                    mem[effective_address] = n
                end
            end
        end
        sum(values(mem))
    end
end
