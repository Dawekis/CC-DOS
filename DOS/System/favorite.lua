local basalt = require(".../DOS.script.basalt")
local cat = require(".../DOS.script.cat")
local id = 1
local processes = {}
local mainFrame = basalt.createFrame()
local mainscreen = mainFrame:addFrame()
:setPosition(1,3)
:setSize(50,16)
:setBackground(colors.lightBlue)
cat.Basalt.Scrollbar(mainFrame,mainscreen)
cat.Basalt.Window_Over(mainFrame,"Favorite",colors.lightBlue)
local lualist = cat.Basalt.List(mainscreen,colors.lightBlue,colors.black)
local luaname = fs.list("DOS/System/Favorite")
for i = 1,#luaname do
    lualist:addItem(luaname[i])
end
lualist:onSelect(function (self,event,item)
    shell.run("DOS/System/Favorite/")
end)
--Add program
cat.Basalt.Button_Text(mainFrame,1,2,"Add",colors.white,colors.black,function ()
    local miniframe = mainFrame:addMovableFrame()
    cat.Basalt.Window_Set(miniframe,"Add Program",colors.black)
    local string = cat.Basalt.Textfield(miniframe,colors.white,colors.black,{"Input you want add lua path in here"})
    local str = string:getLines()
    cat.Basalt.Button_Text(miniframe,19,8,"OK",colors.red,colors.black,function ()
        if fs.exists(str[1]) == true then
            shell.run("copy",str[1],"DOS/System/Favorite/"..fs.getName(str[1]))
            miniframe:remove()
            basalt.debug("Add success!","Please re-run Favorite to see you add lua.")
        else
            basalt.debug("No found "..str[1].."!")
        end
    end)
end)
--Remove program
cat.Basalt.Button_Text(mainFrame,10,2,"Rm",colors.white,colors.black,function ()
    local miniframe = mainFrame:addMovableFrame()
    cat.Basalt.Window_Set(miniframe,"Remove Program",colors.black)
    local string = cat.Basalt.Textfield(miniframe,colors.white,colors.black,{"Input you want remove lua name in here"})
    local str = string:getLines()
    cat.Basalt.Button_Text(miniframe,19,8,"OK",colors.red,colors.black,function ()
        if fs.exists("DOS/System/Favorite/"..str[1]) == true then
            shell.run("rm","DOS/System/Favorite/"..str[1])
            miniframe:remove()
            basalt.debug("Del success!","Please re-run Favorite to see you removed lua.")
        else
            basalt.debug("No found "..str[1].."!")
        end
    end)
end)
basalt.autoUpdate()