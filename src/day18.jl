using Base.Iterators


function eager_eval(s)
    acc = 0
    i = 1
    
    cur_op = false
    
    while i <= length(s)
        while i < length(s) && s[i] == ' '
            i += 1
        end
        if i > length(s)
            break
        end
        if s[i] == '('
            i += 1
            start = i
            depth = 1
            while depth > 0
                if s[i] == '('
                    depth += 1
                elseif s[i] == ')'
                    depth -= 1
                end
                i += 1
            end
            stop = i - 2
            
            slice = @view s[start:stop]
            subproblem = eager_eval(slice)
            
            if cur_op
                acc *= subproblem
            else
                acc += subproblem
            end
        elseif isdigit(s[i])
            start = i
            while i < length(s) && isdigit(s[i])
                i += 1
            end
            stop = i
            
            num = parse(Int, String(@view s[start:stop]))
            i += 1
            if cur_op
                acc *= num
            else
                acc += num
            end
        elseif s[i] in ['+', '*']
            if s[i] == '+'
                cur_op = false
            else
                cur_op = true
            end
            i += 1
        end
    end
    
    acc
end


function part1()
    open("inputfiles/day18/input.txt") do io
        sum(eager_eval(Vector{Char}(l)) for l in eachline(io))
    end
end


struct OppInt
    n::Int
end


Base.:+(a::OppInt, b::OppInt) = OppInt(a.n * b.n)
Base.:*(a::OppInt, b::OppInt) = OppInt(a.n + b.n)


function opp_eval(s)
    s = replace(s, "*" => "/")
    s = replace(s, "+" => "*")
    s = replace(s, "/" => "+")
    s = replace(s, r"(\d+)" => s"Main.OppInt(\1)")
    Meta.eval(Meta.parse(s)).n
end


function part2()
    open("inputfiles/day18/input.txt") do io
        sum(opp_eval(l) for l in eachline(io))
    end
end
