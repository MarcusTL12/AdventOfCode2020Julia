using Base.Iterators


dirs = [
    (1, 0),
    (1, 1),
    (0, 1),
    (-1, 1),
    (-1, 0),
    (-1, -1),
    (0, -1),
    (1, -1),
]


function do_step(from, to)
    w, h = size(from)
    did_something = false
    for i in 1:w, j in 1:h
        neighbours = count(get(from, (i, j) .+ d, 0) == 2 for d in dirs)
        
        if from[i, j] == 1 && neighbours == 0
            did_something = true
            to[i, j] = 2
        elseif from[i, j] == 2 && neighbours >= 4
            did_something = true
            to[i, j] = 1
        else
            to[i, j] = from[i, j]
        end
    end
    did_something
end


function part1()
    a = open("inputfiles/day11/input.txt") do io
        buff = Int[]
        w = 0
        h = 0
        for l in eachline(io)
            w = length(l)
            h += 1
            append!(buff, (c == 'L' for c in l))
        end
        reshape(buff, w, h)
    end
    
    b = copy(a)
    
    while do_step(a, b)
        a, b = b, a
    end
    
    count(x == 2 for x in a)
end


function find_straight_line_neighbours(layout, pos)
    n = 0
    for d in dirs
        for i in countfrom(1)
            np = pos .+ i .* d
            occ = get(layout, np, 1)
            if occ == 2
                n += 1
                break
            elseif occ == 1
                break
            end
        end
    end
    n
end


function do_step2(from, to)
    w, h = size(from)
    did_something = false
    for i in 1:w, j in 1:h
        neighbours = find_straight_line_neighbours(from, (i, j))
        
        if from[i, j] == 1 && neighbours == 0
            did_something = true
            to[i, j] = 2
        elseif from[i, j] == 2 && neighbours >= 5
            did_something = true
            to[i, j] = 1
        else
            to[i, j] = from[i, j]
        end
    end
    did_something
end


function part2()
    a = open("inputfiles/day11/input.txt") do io
        buff = Int[]
        w = 0
        h = 0
        for l in eachline(io)
            w = length(l)
            h += 1
            append!(buff, (c == 'L' for c in l))
        end
        reshape(buff, w, h)
    end
    
    b = copy(a)
    
    while do_step2(a, b)
        a, b = b, a
    end
    
    count(x == 2 for x in a)
end
