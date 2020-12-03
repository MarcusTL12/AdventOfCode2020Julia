

function load_input(filename)
    open(filename) do io
        flat_list = Bool[]
        w = 0
        h = 0
        for l in eachline(io)
            w = length(l)
            h += 1
            append!(flat_list, (c == '#' for c in l))
        end
        BitArray(reshape(flat_list, (w, h)))
    end
end


function posmod(a, b)
    x = (a - 1) % b + 1
    if x < 0
        x + b
    else
        x
    end
end


function count_trees(forest, slope, speed=1)
    pos = (1, 1)
    trees = 0
    while pos[2] < size(forest)[2]
        pos = pos .+ (slope, speed)
        pos = (posmod(pos[1], size(forest)[1]), pos[2])
        trees += forest[pos...]
    end
    trees
end


function part1()
    inp = load_input("inputfiles/day3/input.txt")
    
    count_trees(inp, 3)
end


function part2()
    inp = load_input("inputfiles/day3/input.txt")
    slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
    
    prod(count_trees(inp, a, b) for (a, b) in slopes)
end
