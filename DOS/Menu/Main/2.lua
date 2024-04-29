local cat = require(".../DOS.script.cat")
local menu_runing = 1
--tip
while menu_runing == 1 do
--test pine
    cat.Background.Set(1,1,51,19,colors.lightBlue,true)
--menu title
    cat.Text(2,1,colors.orange,colors.black,"MainMenu - <2>")
--============mainmenu image==================--
--editmenu image
    cat.Text(51,1,colors.orange,colors.black,"+")
    cat.Text(1,10,colors.white,colors.black,"<")
    cat.Text(51,10,colors.white,colors.black,">")
--menu image
    paintutils.drawPixel(1,19,colors.lime)
--lua config
local lua_1 = {}
local j = 1
for i in io.lines(".../DOS/Menu/2/lua_1.txt") do
    lua_1[j] = i
    j = j+1
end
local Icon1 = cat.Icon(tonumber(lua_1[1]),tonumber(lua_1[2]),lua_1[4])
cat.Text(tonumber(lua_1[1])+3,tonumber(lua_1[2])+7,colors.black,colors.lightBlue,lua_1[5])
local lua_2 = {}
local j = 1
for i in io.lines(".../DOS/Menu/2/lua_2.txt") do
    lua_2[j] = i
    j = j+1
end
local Icon2 = cat.Icon(tonumber(lua_2[1]),tonumber(lua_2[2]),lua_2[4])
cat.Text(tonumber(lua_2[1])+3,tonumber(lua_2[2])+7,colors.black,colors.lightBlue,lua_2[5])
local lua_3 = {}
local j = 1
for i in io.lines(".../DOS/Menu/2/lua_3.txt") do
    lua_3[j] = i
    j = j+1
end
local Icon3 = cat.Icon(tonumber(lua_3[1]),tonumber(lua_3[2]),lua_3[4])
cat.Text(tonumber(lua_3[1])+3,tonumber(lua_3[2])+7,colors.black,colors.lightBlue,lua_3[5])
local lua_4 = {}
local j = 1
for i in io.lines(".../DOS/Menu/2/lua_4.txt") do
    lua_4[j] = i
    j = j+1
end
local Icon4 = cat.Icon(tonumber(lua_4[1]),tonumber(lua_4[2]),lua_4[4])
cat.Text(tonumber(lua_4[1])+3,tonumber(lua_4[2])+7,colors.black,colors.lightBlue,lua_4[5])
local lua_5 = {}
local j = 1
for i in io.lines(".../DOS/Menu/2/lua_5.txt") do
    lua_5[j] = i
    j = j+1
end
local Icon5 = cat.Icon(tonumber(lua_5[1]),tonumber(lua_5[2]),lua_5[4])
cat.Text(tonumber(lua_5[1])+3,tonumber(lua_5[2])+7,colors.black,colors.lightBlue,lua_5[5])
local lua_6 = {}
local j = 1
for i in io.lines(".../DOS/Menu/2/lua_6.txt") do
    lua_6[j] = i
    j = j+1
end
local Icon6 = cat.Icon(tonumber(lua_6[1]),tonumber(lua_6[2]),lua_6[4])
cat.Text(tonumber(lua_6[1])+3,tonumber(lua_6[2])+7,colors.black,colors.lightBlue,lua_6[5])
local lua_7 = {}
local j = 1
for i in io.lines(".../DOS/Menu/2/lua_7.txt") do
    lua_7[j] = i
    j = j+1
end
local Icon7 = cat.Icon(tonumber(lua_7[1]),tonumber(lua_7[2]),lua_7[4])
cat.Text(tonumber(lua_7[1])+3,tonumber(lua_7[2])+7,colors.black,colors.lightBlue,lua_7[5])
local lua_8 = {}
local j = 1
for i in io.lines(".../DOS/Menu/2/lua_8.txt") do
    lua_8[j] = i
    j = j+1
end
local Icon8 = cat.Icon(tonumber(lua_8[1]),tonumber(lua_8[2]),lua_8[4])
cat.Text(tonumber(lua_8[1])+3,tonumber(lua_8[2])+7,colors.black,colors.lightBlue,lua_8[5])
--Icon image
--luatest
--monitoring event:mouse_click
    local event,click,click_x,click_y = os.pullEvent("mouse_click")

--============Icon program============--
--luaprogram
    cat.Button.Icon(Icon1,function ()shell.run(lua_1[3]) end,click_x,click_y,click)
    cat.Button.Icon(Icon2,function ()shell.run(lua_2[3]) end,click_x,click_y,click)
    cat.Button.Icon(Icon3,function ()shell.run(lua_3[3]) end,click_x,click_y,click)
    cat.Button.Icon(Icon4,function ()shell.run(lua_4[3]) end,click_x,click_y,click)
    cat.Button.Icon(Icon5,function ()shell.run(lua_5[3]) end,click_x,click_y,click)
    cat.Button.Icon(Icon6,function ()shell.run(lua_6[3]) end,click_x,click_y,click)
    cat.Button.Icon(Icon7,function ()shell.run(lua_7[3]) end,click_x,click_y,click)
    cat.Button.Icon(Icon8,function ()shell.run(lua_8[3]) end,click_x,click_y,click)
--============mainmenuprogram============--
--menu program
    cat.Button.Set(1,19,1,1,function ()
        shell.run("DOS/System/menubutton")
    end,click_x,click_y,click)
--editmenu program
    cat.Button.Set(51,1,1,1,function ()
        shell.run("DOS/System/editmenu")
    end,click_x,click_y,click)
--menuchange program
    cat.Button.Set(1,10,1,1,function ()
        menu_runing = 0
    end,click_x,click_y,click)
    cat.Button.Set(51,10,1,1,function ()
        shell.run("DOS/Menu/Main/3")
    end,click_x,click_y,click)
--monitoring menu whether close
end
