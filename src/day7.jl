

reg1 = r"(.+) bags contain (.+)"
reg2 = r"(\d+) (\w+ \w+) bags?"


function part1()
    inp = open("inputfiles/day7/input.txt") do io
        Dict(begin
            m = match(reg1, l)
            m.captures[1] => [begin
                parse(Int, m.captures[1]), m.captures[2]
            end::Tuple{Int,SubString{String}}
            for m in eachmatch(reg2, m.captures[2])]
        end for l in eachline(io))
    end
    
    shiny_gold_memo = Dict{String,Bool}()
    
    function has_shiny_gold(bag)
        if haskey(shiny_gold_memo, bag)
            return shiny_gold_memo[bag]
        end
        
        ret = any(b[2] == "shiny gold" for b in inp[bag])
        if !ret
            ret = any(has_shiny_gold, (b[2] for b in inp[bag]))
        end
        shiny_gold_memo[bag] = ret
        ret
    end
    
    count(has_shiny_gold, keys(inp))
end


function part2()
    inp = open("inputfiles/day7/input.txt") do io
        Dict(begin
            m = match(reg1, l)
            m.captures[1] => [begin
                parse(Int, m.captures[1]), m.captures[2]
            end::Tuple{Int,SubString{String}}
            for m in eachmatch(reg2, m.captures[2])]
        end for l in eachline(io))
    end
    
    bag_count_memo = Dict{String,Int}()
    
    function bag_count(bag)
        if haskey(bag_count_memo, bag)
            return bag_count_memo[bag]
        end
        
        ret = if !isempty(inp[bag])
            1 + sum(begin
                amt * bag_count(bag)
            end for (amt, bag) in inp[bag])
        else
            1
        end
        
        bag_count_memo[bag] = ret
        ret
    end
    
    bag_count("shiny gold") - 1
end
