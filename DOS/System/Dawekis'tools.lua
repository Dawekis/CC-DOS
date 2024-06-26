local basalt = require(".../DOS.script.basalt")
local cat = require(".../DOS.script.cat")
require("math")
local co = require(".../DOS.script.Complex_operations")
local mainFrame = basalt.createFrame()
local mainscreen = mainFrame:addFrame()
:setPosition(1,3)
:setSize(50,16)
:setBackground(colors.lightBlue)
cat.Basalt.Window_Over(mainFrame,"Dawekis'Tools",colors.lightBlue)
cat.Basalt.Scrollbar(mainFrame,mainscreen)
local toollist = cat.Basalt.List(mainscreen,colors.lightBlue,colors.black)

toollist:addItem("Calculator")
toollist:addItem("Curve fitting")

toollist:onSelect(function (self,event,item)
    if toollist:getItemIndex() == 1 then
        local runscreen = mainFrame:addMovableFrame()
        cat.Basalt.Window_Set(runscreen," Calculator",colors.black)
        local runframe = runscreen:addFrame():setPosition(2,2):setSize(38,12):setBackground(colors.lightGray)
        runframe:addPane():setPosition(5,2):setSize(33,1):setBackground(colors.white)
        runframe:addLabel():setText("Old:"):setPosition(1,2)
        runframe:addLabel():setText("New:"):setPosition(1,3)
        runframe:addLabel():setPosition(18,7):setText("Tip")
        runframe:addLabel():setPosition(1,9):setText("you can enter +,-,*,/,(),i and number")
        runframe:addLabel():setPosition(3,11):setText("Do not enter spaces and letters")
        local str = {}
        str[1] =""
        local output = cat.Basalt.Textfield(runframe,colors.white,colors.black,str,5,3,33,1)
        cat.Basalt.Button_Text(runframe,19,5,"OK",colors.red,colors.black,function ()
            local str = output:getLine(1)
            local d1,d2 = string.find(str,"%a")
            if str ~= "" and (d1 == nil or string.sub(str,d1,d2) == "i") then
                local result = co.calculator(str)
                runframe:addLabel():setText("                                             "):setPosition(5,2)
                output:editLine(1,tostring(result))
                runframe:addLabel():setText(str):setPosition(5,2)
            else
                local tips = runframe:addMovableFrame()
                local tip = tips:addFrame():setPosition(2,2):setSize(12,4):setBackground(colors.lightGray)
                cat.Basalt.Window_Set(tips," Tip",colors.black,nil,nil,14,6)
                tip:addLabel():setPosition(1,1):setText("Do not enter")
                tip:addLabel():setPosition(3,2):setText("spaces")
                tip:addLabel():setPosition(5,3):setText("and")
                tip:addLabel():setPosition(3,4):setText("letters")
            end
        end)
    elseif toollist:getItemIndex() == 2 then
        shell.run("DOS/System/Dawekis'tools/curvefitting.lua")
    end
end)
basalt.autoUpdate()