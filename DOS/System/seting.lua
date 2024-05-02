local basalt = require(".../DOS.script.basalt")
local cat = require(".../DOS.script.cat")
local mainFrame = basalt.createFrame()
local mainscreen = mainFrame:addFrame()
:setPosition(1,3)
:setSize(50,16)
:setBackground(colors.lightBlue)
cat.Basalt.Scrollbar(mainFrame,mainscreen)
cat.Basalt.Window_Over(mainFrame,"Set up",colors.lightBlue)
local setlist = cat.Basalt.List(mainscreen,colors.lightBlue,colors.black)

setlist:addItem("Equipment management")
setlist:addItem("Screen projection")

setlist:onSelect(function (self,event,item)
    local runing = setlist:getItemIndex()
    --Equipment management
    if runing == 1 then
        local runscreen = mainFrame:addMovableFrame()
        cat.Basalt.Window_Set(runscreen," Equipment management",colors.black)
        local runframe = runscreen:addFrame():setPosition(2,2):setSize(37,12):setBackground(colors.lightGray)
        cat.Basalt.Scrollbar(runscreen,runframe,nil,39,2,12)
        local eqlist = cat.Basalt.List(runframe,colors.lightGray,colors.black)
        local eqname = peripheral.getNames()
        runscreen:addLabel():setText("Equipment total namber:"..tostring(#eqname)):setPosition(2,14)
        for i,j in pairs(eqname) do
            eqlist:addItem(j)
        end
        --Screen projection
    elseif runing == 2 then
        local runscreen = mainFrame:addMovableFrame()
        cat.Basalt.Window_Set(runscreen," Screen projection",colors.black)
        runscreen:addPane():setPosition(2,2):setSize(37,1):setBackground(colors.lightGray)
        local runframe = runscreen:addFrame():setPosition(2,2):setSize(37,12):setBackground(colors.lightGray)
        cat.Basalt.Scrollbar(runscreen,runframe,nil,39,2,12)
        local monitorlist = cat.Basalt.List(runframe,colors.lightGray,colors.black)
        local monitorname = {peripheral.find("monitor")}
        runscreen:addLabel():setText("Available monitor number:"..tostring(#monitorname)):setPosition(2,14)
        for i,j in pairs(monitorname) do
            monitorlist:addItem(peripheral.getName(j))
        end
        monitorlist:onSelect(function (self,event,item)
            local tip = runscreen:addMovableFrame()
            cat.Basalt.Window_Set(tip," Are you true?",colors.black,nil,nil,16,5)
            cat.Basalt.Button_Text(tip,8,3,"OK",colors.red,colors.black,function ()
                monitorname[monitorlist:getItemIndex()].setTextScale(1)
                local size_x,size_y = monitorname[monitorlist:getItemIndex()].getSize()
                local c_x = size_x/51
                local c_y = size_y/19
                local c = math.min(c_x,c_y)
                if c < 0.5 then
                    tip:remove()
                    local tips = runscreen:addMovableFrame()
                    cat.Basalt.Window_Set(tips," The monitor is so small!",colors.black,nil,nil,26,5)
                    cat.Basalt.Button_Text(tips,13,3,"OK",colors.red,colors.black,function ()
                        tips:remove()
                    end)
                else
                    monitorname[monitorlist:getItemIndex()].setTextScale(c)
                    tip:remove()
                    shell.run("bg monitor",item.text,".../DOS/System/startup.lua")
                end
            end)
        end)
    end
end)
basalt.autoUpdate()