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
    cat.Basalt.Window_Set(miniframe,"Add Menu",colors.black,nil,nil,10,5)
    cat.Basalt.Button_Text(miniframe,5,3,"OK",colors.red,colors.black,function ()
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
    cat.Basalt.Window_Set(miniframe,"Rm Menu",colors.black,nil,nil,10,5)
    cat.Basalt.Button_Text(miniframe,5,3,"OK",colors.red,colors.black,function ()
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
    if item.text ~= "1.lua" then
        local miniframe = mainFrame:addMovableFrame()
        cat.Basalt.Window_Set(miniframe,"Edit Menu",colors.black,nil,nil,46,14)
        local str_0 = {}
        str_0[1] = "Input you want add lua path in here"
        local string_0 = cat.Basalt.Textfield(miniframe,nil,nil,str_0,1,2,46)
        local str_1 = {}
        str_1[1] = "Input you want add lua Icon path in here"
        local string_1 = cat.Basalt.Textfield(miniframe,nil,nil,str_1,1,4,46)
        local str_2 = {}
        str_2[1] = "Input you want add lua new name in here"
        local string_2 = cat.Basalt.Textfield(miniframe,nil,nil,str_2,1,6,46)
        cat.Basalt.Button_Text(miniframe,23,9,"OK",colors.red,colors.black,function ()
            local str_0 = string_0:getLines()
            local str_1 = string_1:getLines()
            local str_2 = string_2:getLines()
            local tempmenu = io.open("DOS/temp/tempmenu.lua","w")
            tempmenu:read("a")
            for i in io.lines("DOS/Menu/Main/"..item.text) do
                if i == "--Icon1" or i == "--Icon2" or i == "--Icon3" or i == "--Icon8" or
                i == "--Icon4" or i == "--Icon5" or i == "--Icon6" or i == "--Icon7" then
                tempmenu:write(i.." is occupied\n")
                tempmenu:write("--monitoring event:mouse_darg\n")
                tempmenu:write('    local myfileIcon = cat.Icon(click_x,click_y,'..'"'..str_1[1]..'"'..')\n')
                tempmenu:write('    cat.Text(click_x + 2,click_y + 7,colors.black,colors.lightBlue,'..'"'..str_2[1]..'"'..')\n')
                tempmenu:write('    sleep(0.01)')
                tempmenu:write("end")
                break 
                elseif i == "--test pine" then
                tempmenu:write('    local event,click,click_x,click_y = os.pullEvent("mouse_drag")\n')
                elseif i == "--tip" then
                tempmenu:write('cat.Background.Set(1,1,51,19,colors.lightBlue,true)\n')
                tempmenu:write('cat.Text(2,8,colors.black,colors.lightBlue,"Please use the left mouse button to drag the icon to the you want position")\n')
                tempmenu:write('cat.Text(2,10,colors.black,colors.lightBlue,"After dragging with the left mouse button, the icon will automatically appear")\n')
                else
                    tempmenu:write(i.."\n")
                end
            end
            tempmenu:close()
            shell.run("DOS/temp/tempmenu")
            shell.run("rm DOS/temp/tempmenu")
        end)
    else
        basalt.debug("Don't edit 1.lua!")
    end
end)
basalt.autoUpdate()