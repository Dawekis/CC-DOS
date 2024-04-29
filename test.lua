require("math")
local i = 0
while true do
  shell.run("rm","DOS/System/Dawekis'tools/UserData/Data.txt")
  for j = i,10+i do
    local file = io.open("DOS/System/Dawekis'tools/UserData/Data.txt","a")
    io.output(file)
    io.write(string.format("%.2f",tostring(1+math.cos(j))).."\n")
    io.close(file)
  end
  i = i + 1
  sleep(0.001)
end