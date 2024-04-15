local basalt = require(".../DOS.script.basalt")
local cat = require(".../DOS.script.cat")
local mainFrame = basalt.createFrame()
local mainscreen = mainFrame:addFrame()
:setPosition(1,3)
:setSize(50,16)
:setBackground(colors.lightBlue)
cat.Basalt.Scrollbar(mainFrame,mainscreen)
cat.Basalt.Window_Over(mainFrame,"EditMenu",colors.lightBlue)
local menulist = cat.Basalt.List(mainscreen,colors.lightBlue,colors.black)
local menuname = fs.list("DOS/Menu/Main")
for i = 1,#menuname do
    menulist:addItem(menuname[i])
end
--Add Menu program
cat.Basalt.Button_Text(mainFrame,1,2,"Add",colors.white,colors.black,function ()
    local miniframe = mainFrame:addMovableFrame()
    cat.Basalt.Window_Set(miniframe,"Add Menu",colors.black)
    cat.Basalt.Button_Text(miniframe,19,8,"OK",colors.red,colors.black,function ()
        local menuname = fs.list("DOS/Menu/Main")
        local newmenu = io.open("DOS/Menu/Main/"..tostring(#menuname+1)..".lua","w")
        newmenu:read("a")
        for i in io.lines("DOS/System/menuframe.lua") do
            newmenu:write(i.."\n")
            if i == "--menu title" then
                newmenu:write('    cat.Text(2,1,colors.orange,colors.black,"MainMenu - <'..tostring(#menuname+1)..'>")'.."\n")
        elseif i == "--menuchange program" then
                newmenu:write('    cat.Button.Set(1,10,1,1,function ()'.."\n")
                newmenu:write('        menu_runing = 0'.."\n")
                newmenu:write('    end,click_x,click_y,click)'.."\n")
                newmenu:write('    cat.Button.Set(51,10,1,1,function ()'.."\n")
                newmenu:write('        shell.run("DOS/Menu/Main/'..tostring(#menuname+2)..'")'.."\n")
                newmenu:write('    end,click_x,click_y,click)'.."\n")
            end
        end
        newmenu:close()
        shell.run("mkdir DOS/Menu/"..tostring(#menuname+1))
        menulist:addItem(tostring(#menuname+1)..".lua")
        menuname = fs.list("DOS/Menu/Main")
        miniframe:remove()
    end)
end)
--Remove Menu program
cat.Basalt.Button_Text(mainFrame,10,2,"Rm",colors.white,colors.black,function ()
    local miniframe = mainFrame:addMovableFrame()
    cat.Basalt.Window_Set(miniframe,"Remove Menu",colors.black)
    cat.Basalt.Button_Text(miniframe,19,8,"OK",colors.red,colors.black,function ()
        menuname = fs.list("DOS/Menu/Main")
        if #menuname > 1 then
            shell.run("rm","DOS/Menu/"..tostring(#menuname))
            shell.run("rm","DOS/Menu/Main/"..tostring(#menuname)..".lua")
            miniframe:remove()
            basalt.stop()
            shell.run("DOS/System/editmenu.lua")
        else
            basalt.debug("Don't removed 1.lua!")
            miniframe:remove()
        end
    end)
end)
--Edit Menu program
menulist:onSelect(function (self,event,item)
    
end)
basalt.autoUpdate()