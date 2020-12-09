using Base.Iterators


function is_sum(nums, n)
    for i in 1:length(nums), j in i + 1:length(nums)
        if nums[i] + nums[j] == n
            return true
        end
    end
    false
end


function part1()
    preamble_len = 25
    open("inputfiles/day9/input.txt") do io
        numbuffer = sizehint!(Int[], preamble_len)
        lines = Iterators.Stateful(parse(Int, l) for l in eachline(io))
        while length(numbuffer) < preamble_len
            push!(numbuffer, first(lines))
        end
        n = 0
        while (n = first(lines); is_sum(numbuffer, n))
            popfirst!(numbuffer)
            push!(numbuffer, n)
        end
        n
    end
end


function part2()
    invalid = part1()
    
    nums = open("inputfiles/day9/input.txt") do io
        parse.(Int, eachline(io))
    end
    
    for i in 1:length(nums)
        for j in i + 1:length(nums)
            if sum(@view nums[i:j]) > invalid
                break
            elseif sum(@view nums[i:j]) == invalid
                return minimum(@view nums[i:j]) + maximum(@view nums[i:j])
            end
        end
    end
end
