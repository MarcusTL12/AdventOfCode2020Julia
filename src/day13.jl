using Base.Iterators
using Mods


function part1()
    t, ids = open("inputfiles/day13/input.txt") do io
        lines = collect(eachline(io))
        t = parse(Int, lines[1])
        ids = parse.(Int, Iterators.filter(x -> x != "x", split(lines[2], ',')))
        t, ids
    end
    
    for i in countfrom(t)
        for id in ids
            if i % id == 0
                return (i - t) * id
            end
        end
    end
end


function part2()
    t, ids = open("inputfiles/day13/input.txt") do io
        lines = collect(eachline(io))
        t = parse(Int, lines[1])
        ids = []
        for (i, x) in enumerate(split(lines[2], ','))
            if x == "x"
                continue
            end
            id = parse(Int, x)
            push!(ids, (i - 1, id))
        end
        t, ids
    end
    
    mods = [Mod{id}(-i) for (i, id) in ids]
    
    CRT(mods...)
end
