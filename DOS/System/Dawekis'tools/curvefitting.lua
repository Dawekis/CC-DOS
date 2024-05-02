local basalt = require(".../DOS.script.basalt")
local cat = require(".../DOS.script.cat")
local str = {}
str[1] = ""
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
local Max_data_label = mainFrame:addLabel():setText("Max data:"):setPosition(1,2):setForeground(colors.black)
local Min_data_label = mainFrame:addLabel():setText("Min data:"):setPosition(18,2):setForeground(colors.black)
local Up_limit_label = mainFrame:addLabel():setText("Up limit:"):setPosition(34,2):setForeground(colors.black)
local Max_data = mainFrame:addLabel():setText(""):setPosition(10,2):setForeground(colors.black)
local Min_data = mainFrame:addLabel():setText(""):setPosition(27,2):setForeground(colors.black)
local Up_limit = mainFrame:addLabel():setText(""):setPosition(43,2):setForeground(colors.black)
local sidebar = mainFrame:addFrame():setPosition(-28,4):setSize(30,16):setZIndex(25)

:onGetFocus(function(self)
    self:setPosition(1)
end)
:onLoseFocus(function(self)
    self:setPosition(-28)
end)

local sub = {
    sidebar:addFrame():setPosition(1, 2):setSize(30,15):setBackground(colors.lightGray),
    sidebar:addFrame():setPosition(1, 2):setSize(30,15):hide()
}

local function openSubFrame(id)
    if(sub[id]~=nil)then
        for k,v in pairs(sub)do
            v:hide()
        end
        sub[id]:show()
    end
end

local menubar = sidebar:addMenubar():setScrollable()
    :setSize(30,1)
    :onChange(function(self, val)
        openSubFrame(self:getItemIndex())
    end)
    :addItem("BasicSetup")
    :addItem("ScreenProjection")

local mainscreen = mainFrame:addFrame()
:setPosition(2,4)
:setSize(49,16)
:setBackground(colors.lightBlue)

local mainscreen_x,mainscreen_y = mainscreen:getSize()

local Scrollbar_x = mainFrame:addScrollbar()
:setBarType("horizontal")
:setPosition(1,3)
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

sub[1]:addLabel():setText("Enter decimals,do not enter"):setPosition(3,11):setForeground(colors.black)
sub[1]:addLabel():setText(" fractions and letters."):setPosition(0,12):setForeground(colors.black)
sub[1]:addLabel():setText("Data points number:"):setPosition(2,1)
local pnum = cat.Basalt.Textfield(sub[1],colors.white,colors.black,str_1,21,1,9,1)
sub[1]:addLabel():setText("Zoom ratio:"):setPosition(2,3)
local zoom = cat.Basalt.Textfield(sub[1],colors.white,colors.black,str_2,21,3,9,1)
sub[1]:addLabel():setText("X-axis : Y-axis:"):setPosition(2,5)
local xy = cat.Basalt.Textfield(sub[1],colors.white,colors.black,str_3,21,5,9,1)
sub[1]:addLabel():setText("Up limit:"):setPosition(2,7)
sub[1]:addLabel():setText("Lua path:"):setPosition(2,13):setForeground(colors.black)
local uplimit = cat.Basalt.Textfield(sub[1],colors.white,colors.black,str_4,21,7,9,1)
cat.Basalt.Button_Text(sub[1],14,9,"OK",colors.red,colors.black,function ()
    local j = 1
    local updata = io.open("DOS/UserData/Curve fitting/Curve_fitting_config.txt","w")
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

local myThread = mainFrame:addThread():start(function ()
    shell.run("")
end)
local run_lua = cat.Basalt.Textfield(sub[1],colors.white,colors.black,str,11,13,19,1)
cat.Basalt.Button_Text(sub[1],11,14,"Quick run",colors.red,colors.black,function ()
    myThread:start(function ()
        shell.run(run_lua:getLine(1) or "")
    end)
end)
cat.Basalt.Button_Text(sub[1],26,14,"Stop",colors.red,colors.black,function ()
    myThread:start(function ()
        shell.run("")
    end)
end)

local choseframe = sub[2]:addFrame():setPosition(2,2):setSize(28,12)
local monitorlist = cat.Basalt.List(choseframe,colors.lightGray,colors.black)
local monitorname = {peripheral.find("monitor")}
for i,j in pairs(monitorname) do 
    monitorlist:addItem(peripheral.getName(j))
end

monitorFrame = nil

cat.Basalt.Button_Text(sub[2],26,14,"Stop",colors.red,colors.black,function ()
    if monitorFrame ~= nil then
        basalt.stop()
        shell.run("DOS/System/Dawekis'tools/curvefitting")
    end
end)
cat.Basalt.Button_Text(sub[2],2,14,"Start projection",colors.red,colors.black,function ()
    local monitor = peripheral.wrap(monitorlist:getItem(monitorlist:getItemIndex()).text)
    monitorFrame = basalt.addMonitor()
    monitorFrame:setMonitor(monitor)
    MonitorGraph = monitorFrame:addGraph():setGraphColor(colors.blue):setBackground(colors.white):setGraphSymbol("")
    :setSize(51,19)
    basalt.onEvent(function(event, side, channel, replyChannel, message, distance)
        local min = 999999
        local max = 0
        MonitorGraph:setSize(51,19)
        :setMaxEntries(tonumber(pnum:getLine(1)) or 10)
        :setMaxValue(tonumber(uplimit:getLine(1)) or 100)
        for i in io.lines("DOS/UserData/Curve fitting/Data.txt") do
            MonitorGraph:addDataPoint(tonumber(i))
            if max < tonumber(i) then
                max = tonumber(i)
            end
            if min > tonumber(i) then
                min = tonumber(i)
            end
            j = j + 1
        end
    end)
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
    Max_data_label:setText("Max data:")
    Min_data_label:setText("Min data:")
    Up_limit_label:setText("Up_limit:")
    Max_data:setText(tostring(max))
    Min_data:setText(tostring(min))
    Up_limit:setText(aGraph:getMaxValue())
    Scrollbar_x:setScrollAmount((tonumber(xy:getLine(1)) or 3.1)*16*(tonumber(zoom:getLine(1)) or 1)-mainscreen_x)
    Scrollbar_y:setScrollAmount(16*(tonumber(zoom:getLine(1)) or 1)-mainscreen_y)
end)

basalt.autoUpdate()