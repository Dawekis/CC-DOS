require("math")
local i = 1
while i < 90000 do
        local file = io.open("DOS/UserData/Curve fitting/Data.txt","w")
        for j = i,10+i do
        io.output(file)
        io.write(tostring(string.format("%.2f",math.cos(j)+1)).."\n")
        i = i+1
        end
        io.close(file)
        sleep(0.1)
end