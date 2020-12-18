

struct EagerInt
    n::Int
end


Base.:+(a::EagerInt, b::EagerInt) = EagerInt(a.n + b.n)
Base.:|(a::EagerInt, b::EagerInt) = EagerInt(a.n * b.n)


function eager_eval(s)
    s = replace(s, "*" => "|")
    s = replace(s, r"(\d+)" => s"Main.EagerInt(\1)")
    Meta.eval(Meta.parse(s)).n
end


function part1()
    open("inputfiles/day18/input.txt") do io
        sum(eager_eval(l) for l in eachline(io))
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
