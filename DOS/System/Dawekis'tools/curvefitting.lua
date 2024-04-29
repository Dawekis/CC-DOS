local basalt = require(".../DOS.script.basalt")
local cat = require(".../DOS.script.cat")
local mainFrame = basalt.createFrame()
cat.Basalt.Window_Over(mainFrame,"Curve fitting",colors.lightBlue)
local j = 1
local str_1 = {}
local str_2 = {}
local str_3 = {}
local str_4 = {}
for i in io.lines("DOS/UserData/Curve fitting/Curve_fitting_config.txt") do
    str_1[j] = i
    j = j+1
end
j = 1
str_2[1] = str_1[2]
str_3[1] = str_1[3]
str_4[1] = str_1[4]
mainFrame:addLabel():setText("Max data:"):setPosition(1,2):setForeground(colors.black)
mainFrame:addLabel():setText("Min data:"):setPosition(18,2):setForeground(colors.black)
mainFrame:addLabel():setText("Up limit:"):setPosition(34,2):setForeground(colors.black)
local sidebar = mainFrame:addFrame():setBackground(colors.lightGray):setPosition(-28,3):setSize(30,16):setZIndex(25)
:onGetFocus(function(self)
    self:setPosition(1)
end)
:onLoseFocus(function(self)
    self:setPosition(-28)
end)

local mainscreen = mainFrame:addFrame()
:setPosition(2,3)
:setSize(49,16)
:setBackground(colors.lightBlue)

local mainscreen_x,mainscreen_y = mainscreen:getSize()

local Scrollbar_x = mainFrame:addScrollbar()
:setBarType("horizontal")
:setPosition(1,19)
:setSize(50,1)
:onChange(function (self,_,value)
    mainscreen:setOffset(value-1,val_y)
    val_x = value-1
end)

local Scrollbar_y = mainFrame:addScrollbar()
:setPosition(51,3)
:setSize(1,17)
:onChange(function (self,_,value)
    mainscreen:setOffset(val_x,value-1)
    val_y = value-1
end)

local aGraph = mainscreen:addGraph():setGraphColor(colors.blue):setBackground(colors.white):setGraphSymbol("")
:setSize(51,19)

sidebar:addLabel():setText("Enter decimals,do not enter"):setPosition(3,13):setForeground(colors.black)
sidebar:addLabel():setText(" fractions and letters."):setPosition(0,14):setForeground(colors.black)
sidebar:addLabel():setText("Data points number:"):setPosition(2,2)
local pnum = cat.Basalt.Textfield(sidebar,colors.white,colors.black,str_1,21,2,9,1)
sidebar:addLabel():setText("Zoom ratio:"):setPosition(2,4)
local zoom = cat.Basalt.Textfield(sidebar,colors.white,colors.black,str_2,21,4,9,1)
sidebar:addLabel():setText("X-axis : Y-axis:"):setPosition(2,6)
local xy = cat.Basalt.Textfield(sidebar,colors.white,colors.black,str_3,21,6,9,1)
sidebar:addLabel():setText("Up limit:"):setPosition(2,8)
local uplimit = cat.Basalt.Textfield(sidebar,colors.white,colors.black,str_4,21,8,9,1)
cat.Basalt.Button_Text(sidebar,14,11,"OK",colors.red,colors.black,function ()
    local j = 1
    local updata = io.open("DOS/UserData Curve fitting/Curve_fitting_config.txt","w")
    io.output(updata)
    local str = {}
    str[1] = pnum:getLine(1)
    str[2] = zoom:getLine(1)
    str[3] = xy:getLine(1)
    str[4] = uplimit:getLine(1)
    for i,j in pairs(str) do
        io.write(tostring(j).."\n")
    end
    io.close(updata)
end)

basalt.onEvent(function(event, side, channel, replyChannel, message, distance)
    local min = 999999
    local max = 0
    aGraph:setSize((tonumber(xy:getLine(1)) or 3.1)*16*(tonumber(zoom:getLine(1)) or 1),16*(tonumber(zoom:getLine(1)) or 1))
    :setMaxEntries(tonumber(pnum:getLine(1)) or 10)
    :setMaxValue(tonumber(uplimit:getLine(1)) or 100)
    for i in io.lines("DOS/UserData/Curve fitting/Data.txt") do
        aGraph:addDataPoint(tonumber(i))
        if max < tonumber(i) then
            max = tonumber(i)
        end
        if min > tonumber(i) then
            min = tonumber(i)
        end
        j = j + 1
    end
    mainFrame:addLabel():setText(tostring(max)):setPosition(10,2):setForeground(colors.black)
    mainFrame:addLabel():setText(tostring(min)):setPosition(27,2):setForeground(colors.black)
    mainFrame:addLabel():setText(aGraph:getMaxValue()):setPosition(43,2):setForeground(colors.black)
    Scrollbar_x:setScrollAmount((tonumber(xy:getLine(1)) or 3.1)*16*(tonumber(zoom:getLine(1)) or 1)-mainscreen_x)
    Scrollbar_y:setScrollAmount(16*(tonumber(zoom:getLine(1)) or 1)-mainscreen_y)
end)
basalt.autoUpdate()