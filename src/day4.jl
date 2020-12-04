

reg1 = r"((?:\w{3}:.+\s?)+)"
reg2 = r"(\w{3}):(\S+)"
reg_height = r"(\d+)(\w{2})"
reg_color = r"#[a-f0-9]{6}"
reg_pid = r"\d{9}"

eye_colors = Set(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])

function part1()
    s = open(String ∘ read, "inputfiles/day4/input.txt")
    
    required = Set(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
    
    x = 0
    
    for m in eachmatch(reg1, s)
        fields = Set{SubString{String}}()
        for m in eachmatch(reg2, m.match)
            push!(fields, m.captures[1])
        end
        
        valid = isempty(setdiff(required, fields))
        
        x += valid
    end
    
    x
end


function part2()
    s = open(String ∘ read, "inputfiles/day4/input.txt")
    
    x = 0
    
    for m in eachmatch(reg1, s)
        fields = Dict{String,String}()
        for m in eachmatch(reg2, m.match)
            push!(fields, m.captures[1] => m.captures[2])
        end
        
        valid = true
        
        valid &= 1920 <= parse(Int, get(fields, "byr", "0")) <= 2002
        valid &= 2010 <= parse(Int, get(fields, "iyr", "0")) <= 2020
        valid &= 2020 <= parse(Int, get(fields, "eyr", "0")) <= 2030
        
        if (m = match(reg_height, get(fields, "hgt", "0")); !isnothing(m))
            valid &= if m.captures[2] == "cm"
                150 <= parse(Int, m.captures[1]) <= 193
            elseif m.captures[2] == "in"
                59 <= parse(Int, m.captures[1]) <= 76
            else
                false
            end
        else
            valid = false
        end
        
        valid &= !isnothing(match(reg_color, get(fields, "hcl", "")))
        valid &= get(fields, "ecl", "") in eye_colors
        s = get(fields, "pid", "")
        valid &= length(s) == 9 &&
        !isnothing(match(reg_pid, get(fields, "pid", "")))
        
        x += valid
    end
    x
end
