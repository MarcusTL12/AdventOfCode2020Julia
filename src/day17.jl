using Base.Iterators


dirs3 = collect(
    x for x in product((-1, 0, 1), (-1, 0, 1), (-1, 0, 1)) if x != (0, 0, 0)
)

dirs4 = collect(
    x for x in product((-1, 0, 1), (-1, 0, 1), (-1, 0, 1), (-1, 0, 1))
    if x != (0, 0, 0, 0)
)


function count_neighbours(map, coord, dirs)
    count((coord .+ d) in map for d in dirs)
end


function do_step(from)
    minx = minimum(x for (x, _, _) in from) - 1
    miny = minimum(y for (_, y, _) in from) - 1
    minz = minimum(z for (_, _, z) in from) - 1
    maxx = maximum(x for (x, _, _) in from) + 1
    maxy = maximum(y for (_, y, _) in from) + 1
    maxz = maximum(z for (_, _, z) in from) + 1
    
    to = sizehint!(Set{NTuple{3,Int}}(), length(from))
    
    for z in minz:maxz, y in miny:maxy, x in minx:maxx
        c = (x, y, z)
        neighbours = count_neighbours(from, c, dirs3)
        if c in from
            if 2 <= neighbours <= 3
                push!(to, c)
            end
        else
            if neighbours == 3
                push!(to, c)
            end
        end
    end
    to
end


function do_step4d(from)
    minx = minimum(x for (x, _, _, _) in from) - 1
    miny = minimum(y for (_, y, _, _) in from) - 1
    minz = minimum(z for (_, _, z, _) in from) - 1
    minw = minimum(w for (_, _, _, w) in from) - 1
    maxx = maximum(x for (x, _, _, _) in from) + 1
    maxy = maximum(y for (_, y, _, _) in from) + 1
    maxz = maximum(z for (_, _, z, _) in from) + 1
    maxw = maximum(w for (_, _, _, w) in from) + 1
    
    to = sizehint!(Set{NTuple{4,Int}}(), length(from))
    
    for w in minw:maxw, z in minz:maxz, y in miny:maxy, x in minx:maxx
        c = (x, y, z, w)
        neighbours = count_neighbours(from, c, dirs4)
        if c in from
            if 2 <= neighbours <= 3
                push!(to, c)
            end
        else
            if neighbours == 3
                push!(to, c)
            end
        end
    end
    to
end


function part1()
    inp = open("inputfiles/day17/input.txt") do io
        s = Set{NTuple{3,Int}}()
        for (y, l) in enumerate(eachline(io))
            for (x, c) in enumerate(l)
                if c == '#'
                    push!(s, (x, y, 0))
                end
            end
        end
        s
    end
    for _ in 1:6
        inp = do_step(inp)
    end
    length(inp)
end


function part2()
    inp = open("inputfiles/day17/input.txt") do io
        s = Set{NTuple{4,Int}}()
        for (y, l) in enumerate(eachline(io))
            for (x, c) in enumerate(l)
                if c == '#'
                    push!(s, (x, y, 0, 0))
                end
            end
        end
        s
    end
    for _ in 1:6
        inp = do_step4d(inp)
    end
    length(inp)
end
