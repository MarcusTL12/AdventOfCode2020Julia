

reg1 = r"(?:\w\s?)+"
reg2 = r"\w"


function part1()
    inp = open(String ∘ read, "inputfiles/day6/input.txt")
    
    a = 0
    
    for m in eachmatch(reg1, inp)
        s = Set{SubString{String}}()
        for m in eachmatch(reg2, m.match)
            push!(s, m.match)
        end
        a += length(s)
    end
    
    a
end


function part2()
    inp = open(String ∘ read, "inputfiles/day6/input.txt")
    
    a = 0
    
    for m in eachmatch(reg1, inp)
        ss = Set{Char}[]
        for l in split(m.match, '\n')
            if length(l) > 0
                push!(ss, Set(c for c in l))
            end
        end
        if length(ss) > 0
            s = intersect(ss...)
            a += length(s)
        end
    end
    
    a
end
