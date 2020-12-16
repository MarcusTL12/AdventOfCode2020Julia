using Base.Iterators


rule_reg = r"(.+): (\d+)-(\d+) or (\d+)-(\d+)"


function load_input(filename)
    open(filename) do io
        lines = Iterators.Stateful(eachline(io))
        
        rules = []
        
        while (l = first(lines); l != "your ticket:")
            m = match(rule_reg, l)
            if isnothing(m)
                continue
            end
            name = m.captures[1]
            n = parse.(Int, m.captures[2:5])
            push!(rules, (name, ((n[1], n[2]), (n[3], n[4]))))
        end
        
        your_ticket = parse.(Int, split(first(lines), ','))
        
        tickets = []
        
        first(lines)
        first(lines)
        for l in lines
            push!(tickets, parse.(Int, split(l, ',')))
        end
        rules, your_ticket, tickets
    end
end


function inrange(n, ((a, b), (c, d)))
    a <= n <= b || c <= n <= d
end


function part1()
    rules, _, tickets = load_input("inputfiles/day16/input.txt")
    
    res = 0
    
    for ticket in tickets
        for val in ticket
            if !any(inrange(val, r) for (_, r) in rules)
                res += val
            end
        end
    end
    
    res
end


function part2()
    rules, your_ticket, tickets = load_input("inputfiles/day16/input.txt")
    
    filter!(x -> all(any(inrange(val, r) for (_, r) in rules) for val in x),
    tickets)
    
    possible_rules = [Set(1:length(rules)) for _ in your_ticket]
    
    for ticket in tickets
        for (i, (_, rule)) in enumerate(rules)
            for (j, val) in enumerate(ticket)
                if !inrange(val, rule)
                    delete!(possible_rules[j], i)
                end
            end
        end
    end
    
    accounted_for = Set()
    
    while any(length(r) > 1 for r in possible_rules)
        for s in possible_rules
            if length(s) == 1 && !(only(s) in accounted_for)
                s = only(s)
                push!(accounted_for, s)
                for r in possible_rules
                    if length(r) > 1
                        delete!(r, s)
                    end
                end
            end
        end
    end
    
    actual_rules = [only(s) for s in possible_rules]
    
    prod(v for (i, v) in enumerate(your_ticket)
    if startswith(rules[actual_rules[i]][1], "departure"))
end
