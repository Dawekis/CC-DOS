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
            elseif i == "--lua config" then
                for j = 1,8 do
                    newmenu:write('local lua_'..j..' = {}\n')
                    newmenu:write('local j = 1\n')
                    newmenu:write('for i in io.lines(".../DOS/Menu/'..tostring(#menuname+1)..'/lua_'..j..'.txt") do\n')
                    newmenu:write('    lua_'..j..'[j] = i\n')
                    newmenu:write('    j = j+1\n')
                    newmenu:write('end\n')
                    newmenu:write('local Icon'..j..' = cat.Icon(tonumber(lua_'..j..'[1]),tonumber(lua_'..j..'[2]),lua_'..j..'[4])\n')
                    newmenu:write('cat.Text(tonumber(lua_'..j..'[1])+3,tonumber(lua_'..j..'[2])+7,colors.black,colors.lightBlue,lua_'..j..'[5])\n')
                end
            elseif i == "--luaprogram" then
                for j = 1,8 do
                    newmenu:write('    cat.Button.Icon(Icon'..j..',function ()shell.run(lua_'..j..'[3]) end,click_x,click_y,click)\n')
                end
            end
        end
        newmenu:close()
        shell.run("mkdir DOS/Menu/"..tostring(#menuname+1))
        for i = 1,8 do
            shell.run("copy","DOS/System/luaconfig.txt","DOS/Menu/"..tostring(#menuname+1).."/lua_"..i..".txt")
        end
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
        cat.Basalt.Window_Set(miniframe,"Edit Menu",colors.lightGray,nil,nil,46,14)
        local sidebar = miniframe:addFrame():setBackground(colors.gray):setPosition(46,2):setSize(15,19):setZIndex(25)
        :onGetFocus(function(self)
            self:setPosition(46-14)
        end)
        :onLoseFocus(function(self)
            self:setPosition(46)
        end)
        local sub = {
            miniframe:addFrame():setPosition(1, 2):setSize(46, 13):setBackground(colors.lightGray),
            miniframe:addFrame():setPosition(1, 2):setSize(46, 13):setBackground(colors.lightGray):hide(),
            miniframe:addFrame():setPosition(1, 2):setSize(46, 13):setBackground(colors.lightGray):hide(),
            miniframe:addFrame():setPosition(1, 2):setSize(46, 13):setBackground(colors.lightGray):hide(),
            miniframe:addFrame():setPosition(1, 2):setSize(46, 13):setBackground(colors.lightGray):hide(),
            miniframe:addFrame():setPosition(1, 2):setSize(46, 13):setBackground(colors.lightGray):hide(),
            miniframe:addFrame():setPosition(1, 2):setSize(46, 13):setBackground(colors.lightGray):hide(),
            miniframe:addFrame():setPosition(1, 2):setSize(46, 13):setBackground(colors.lightGray):hide()
        }
        local str_0 = {}
        local str_1 = {}
        local str_2 = {}
        str_0[1] = "Input you want edit lua path in here"
        str_1[1] = "Input you want edit lua Icon path in here"
        str_2[1] = "Input you want edit lua new name in here"
        sub[1]:addLabel():setText(" lua - 1")
        local luastr_1 = {}
        luastr_1[1] = cat.Basalt.Textfield(sub[1],nil,nil,str_0,1,2,46)
        luastr_1[2] = cat.Basalt.Textfield(sub[1],nil,nil,str_1,1,3,46)
        luastr_1[3] = cat.Basalt.Textfield(sub[1],nil,nil,str_2,1,4,46)
        cat.Basalt.Button_Text(sub[1],11,1,"Add",colors.red,colors.black,function ()
            local tempmenu = io.open("DOS/temp/tempmenu.lua","w")
            tempmenu:read("a")
            for i in io.lines("DOS/Menu/Main/"..item.text) do
                if i == "--luatest" then
                tempmenu:write(i.." is occupied\n")
                tempmenu:write("--monitoring event:mouse_darg\n")
                tempmenu:write("    if click_x <= 40 and click_x >= 2 and click_y <= 11 and click_y >= 2 and click == 1 then\n")
                tempmenu:write('        local myfileIcon = cat.Icon(click_x,click_y,'..'"'..luastr_1[2]:getLine(1)..'"'..')\n')
                tempmenu:write('        cat.Text(click_x + 2,click_y + 7,colors.black,colors.lightBlue,'..'"'..luastr_1[3]:getLine(1)..'"'..')\n')
                tempmenu:write('        local temp = io.open("DOS/temp/temp.txt","w");io.output(temp);io.write(click_x.."\\n");io.write(click_y);io.close(temp)\n')
                tempmenu:write("    elseif click == 2 then\n")
                tempmenu:write("        menu_runing = 0\n")
                tempmenu:write("    end\n")
                tempmenu:write('    sleep(0.01)\n')
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
            io.close(tempmenu)
            shell.run("DOS/temp/tempmenu")
            shell.run("rm DOS/temp/tempmenu")
            local config = io.open(".../DOS/Menu/"..menulist:getItemIndex().."/lua_1.txt","w")
            io.output(config)
            for i in io.lines("DOS/temp/temp.txt") do
                io.write(i.."\n")
            end
            io.write(luastr_1[1]:getLine(1).."\n")
            io.write(luastr_1[2]:getLine(1).."\n")
            io.write(luastr_1[3]:getLine(1).."\n")
            io.close(config)
            shell.run("rm DOS/temp/temp.txt")
        end)
        cat.Basalt.Button_Text(sub[1],15,1,"Rm",colors.red,colors.black,function ()
            local tip = mainFrame:addMovableFrame()
            cat.Basalt.Window_Set(tip,"Are you del?",colors.black,nil,nil,13,5)
            cat.Basalt.Button_Text(tip,6,3,"OK",colors.red,colors.black,function ()
                shell.run("rm",".../DOS/Menu/"..menulist:getItemIndex().."/lua_1.txt")
                tip:remove()
            end)
        end)

        sub[2]:addLabel():setText(" lua - 2")
        local luastr_2 = {}
        luastr_2[1] = cat.Basalt.Textfield(sub[2],nil,nil,str_0,1,2,46)
        luastr_2[2] = cat.Basalt.Textfield(sub[2],nil,nil,str_1,1,3,46)
        luastr_2[3] = cat.Basalt.Textfield(sub[2],nil,nil,str_2,1,4,46)
        cat.Basalt.Button_Text(sub[2],11,1,"Add",colors.red,colors.black,function ()
            local tempmenu = io.open("DOS/temp/tempmenu.lua","w")
            tempmenu:read("a")
            for i in io.lines("DOS/Menu/Main/"..item.text) do
                if i == "--luatest" then
                tempmenu:write(i.." is occupied\n")
                tempmenu:write("--monitoring event:mouse_darg\n")
                tempmenu:write("    if click_x <= 40 and click_x >= 2 and click_y <= 11 and click_y >= 2 and click == 1 then\n")
                tempmenu:write('        local myfileIcon = cat.Icon(click_x,click_y,'..'"'..luastr_2[2]:getLine(1)..'"'..')\n')
                tempmenu:write('        cat.Text(click_x + 2,click_y + 7,colors.black,colors.lightBlue,'..'"'..luastr_2[3]:getLine(1)..'"'..')\n')
                tempmenu:write('        local temp = io.open("DOS/temp/temp.txt","w");io.output(temp);io.write(click_x.."\\n");io.write(click_y);io.close(temp)')
                tempmenu:write("    elseif click == 2 then\n")
                tempmenu:write("        menu_runing = 0\n")
                tempmenu:write("    end\n")
                tempmenu:write('    sleep(0.01)\n')
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
            io.close(tempmenu)
            shell.run("DOS/temp/tempmenu")
            shell.run("rm DOS/temp/tempmenu")
            local config = io.open(".../DOS/Menu/"..menulist:getItemIndex().."/lua_2.txt","w")
            io.output(config)
            for i in io.lines("DOS/temp/temp.txt") do
                io.write(i.."\n")
            end
            io.write(luastr_2[1]:getLine(1).."\n")
            io.write(luastr_2[2]:getLine(1).."\n")
            io.write(luastr_2[3]:getLine(1).."\n")
            io.close(config)
            shell.run("rm DOS/temp/temp.txt")
        end)
        cat.Basalt.Button_Text(sub[2],15,1,"Rm",colors.red,colors.black,function ()
            local tip = mainFrame:addMovableFrame()
            cat.Basalt.Window_Set(tip,"Are you del?",colors.black,nil,nil,13,5)
            cat.Basalt.Button_Text(tip,6,3,"OK",colors.red,colors.black,function ()
                shell.run("rm",".../DOS/Menu/"..menulist:getItemIndex().."/lua_2.txt")
                tip:remove()
            end)
        end)

        sub[3]:addLabel():setText(" lua - 3")
        local luastr_3 = {}
        luastr_3[1] = cat.Basalt.Textfield(sub[3],nil,nil,str_0,1,2,46)
        luastr_3[2] = cat.Basalt.Textfield(sub[3],nil,nil,str_1,1,3,46)
        luastr_3[3] = cat.Basalt.Textfield(sub[3],nil,nil,str_2,1,4,46)
        cat.Basalt.Button_Text(sub[3],11,1,"Add",colors.red,colors.black,function ()
            local tempmenu = io.open("DOS/temp/tempmenu.lua","w")
            tempmenu:read("a")
            for i in io.lines("DOS/Menu/Main/"..item.text) do
                if i == "--luatest" then
                tempmenu:write(i.." is occupied\n")
                tempmenu:write("--monitoring event:mouse_darg\n")
                tempmenu:write("    if click_x <= 40 and click_x >= 2 and click_y <= 11 and click_y >= 2 and click == 1 then\n")
                tempmenu:write('        local myfileIcon = cat.Icon(click_x,click_y,'..'"'..luastr_3[2]:getLine(1)..'"'..')\n')
                tempmenu:write('        cat.Text(click_x + 2,click_y + 7,colors.black,colors.lightBlue,'..'"'..luastr_3[3]:getLine(1)..'"'..')\n')
                tempmenu:write('        local temp = io.open("DOS/temp/temp.txt","w");io.output(temp);io.write(click_x.."\\n");io.write(click_y);io.close(temp)')
                tempmenu:write("    elseif click == 2 then\n")
                tempmenu:write("        menu_runing = 0\n")
                tempmenu:write("    end\n")
                tempmenu:write('    sleep(0.01)\n')
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
            io.close(tempmenu)
            shell.run("DOS/temp/tempmenu")
            shell.run("rm DOS/temp/tempmenu")
            local config = io.open(".../DOS/Menu/"..menulist:getItemIndex().."/lua_3.txt","w")
            io.output(config)
            for i in io.lines("DOS/temp/temp.txt") do
                io.write(i.."\n")
            end
            io.write(luastr_3[1]:getLine(1).."\n")
            io.write(luastr_3[2]:getLine(1).."\n")
            io.write(luastr_3[3]:getLine(1).."\n")
            io.close(config)
            shell.run("rm DOS/temp/temp.txt")
        end)
        cat.Basalt.Button_Text(sub[3],15,1,"Rm",colors.red,colors.black,function ()
            local tip = mainFrame:addMovableFrame()
            cat.Basalt.Window_Set(tip,"Are you del?",colors.black,nil,nil,13,5)
            cat.Basalt.Button_Text(tip,6,3,"OK",colors.red,colors.black,function ()
                shell.run("rm",".../DOS/Menu/"..menulist:getItemIndex().."/lua_3.txt")
                tip:remove()
            end)
        end)

        sub[4]:addLabel():setText(" lua - 4")
        local luastr_4 = {}
        luastr_4[1] = cat.Basalt.Textfield(sub[4],nil,nil,str_0,1,2,46)
        luastr_4[2] = cat.Basalt.Textfield(sub[4],nil,nil,str_1,1,3,46)
        luastr_4[3] = cat.Basalt.Textfield(sub[4],nil,nil,str_2,1,4,46)
        cat.Basalt.Button_Text(sub[4],11,1,"Add",colors.red,colors.black,function ()
            local tempmenu = io.open("DOS/temp/tempmenu.lua","w")
            tempmenu:read("a")
            for i in io.lines("DOS/Menu/Main/"..item.text) do
                if i == "--luatest" then
                tempmenu:write(i.." is occupied\n")
                tempmenu:write("--monitoring event:mouse_darg\n")
                tempmenu:write("    if click_x <= 40 and click_x >= 2 and click_y <= 11 and click_y >= 2 and click == 1 then\n")
                tempmenu:write('        local myfileIcon = cat.Icon(click_x,click_y,'..'"'..luastr_4[2]:getLine(1)..'"'..')\n')
                tempmenu:write('        cat.Text(click_x + 2,click_y + 7,colors.black,colors.lightBlue,'..'"'..luastr_4[3]:getLine(1)..'"'..')\n')
                tempmenu:write('        local temp = io.open("DOS/temp/temp.txt","w");io.output(temp);io.write(click_x.."\\n");io.write(click_y);io.close(temp)')
                tempmenu:write("    elseif click == 2 then\n")
                tempmenu:write("        menu_runing = 0\n")
                tempmenu:write("    end\n")
                tempmenu:write('    sleep(0.01)\n')
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
            io.close(tempmenu)
            shell.run("DOS/temp/tempmenu")
            shell.run("rm DOS/temp/tempmenu")
            local config = io.open(".../DOS/Menu/"..menulist:getItemIndex().."/lua_4.txt","w")
            io.output(config)
            for i in io.lines("DOS/temp/temp.txt") do
                io.write(i.."\n")
            end
            io.write(luastr_4[1]:getLine(1).."\n")
            io.write(luastr_4[2]:getLine(1).."\n")
            io.write(luastr_4[3]:getLine(1).."\n")
            io.close(config)
            shell.run("rm DOS/temp/temp.txt")
        end)
        cat.Basalt.Button_Text(sub[4],15,1,"Rm",colors.red,colors.black,function ()
            local tip = mainFrame:addMovableFrame()
            cat.Basalt.Window_Set(tip,"Are you del?",colors.black,nil,nil,13,5)
            cat.Basalt.Button_Text(tip,6,3,"OK",colors.red,colors.black,function ()
                shell.run("rm",".../DOS/Menu/"..menulist:getItemIndex().."/lua_4.txt")
                tip:remove()
            end)
        end)

        sub[5]:addLabel():setText(" lua - 5")
        local luastr_5 = {}
        luastr_5[1] = cat.Basalt.Textfield(sub[5],nil,nil,str_0,1,2,46)
        luastr_5[2] = cat.Basalt.Textfield(sub[5],nil,nil,str_1,1,3,46)
        luastr_5[3] = cat.Basalt.Textfield(sub[5],nil,nil,str_2,1,4,46)
        cat.Basalt.Button_Text(sub[5],11,1,"Add",colors.red,colors.black,function ()
            local tempmenu = io.open("DOS/temp/tempmenu.lua","w")
            tempmenu:read("a")
            for i in io.lines("DOS/Menu/Main/"..item.text) do
                if i == "--luatest" then
                tempmenu:write(i.." is occupied\n")
                tempmenu:write("--monitoring event:mouse_darg\n")
                tempmenu:write("    if click_x <= 40 and click_x >= 2 and click_y <= 11 and click_y >= 2 and click == 1 then\n")
                tempmenu:write('        local myfileIcon = cat.Icon(click_x,click_y,'..'"'..luastr_5[2]:getLine(1)..'"'..')\n')
                tempmenu:write('        cat.Text(click_x + 2,click_y + 7,colors.black,colors.lightBlue,'..'"'..luastr_5[3]:getLine(1)..'"'..')\n')
                tempmenu:write('        local temp = io.open("DOS/temp/temp.txt","w");io.output(temp);io.write(click_x.."\\n");io.write(click_y);io.close(temp)')
                tempmenu:write("    elseif click == 2 then\n")
                tempmenu:write("        menu_runing = 0\n")
                tempmenu:write("    end\n")
                tempmenu:write('    sleep(0.01)\n')
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
            io.close(tempmenu)
            shell.run("DOS/temp/tempmenu")
            shell.run("rm DOS/temp/tempmenu")
            local config = io.open(".../DOS/Menu/"..menulist:getItemIndex().."/lua_5.txt","w")
            io.output(config)
            for i in io.lines("DOS/temp/temp.txt") do
                io.write(i.."\n")
            end
            io.write(luastr_5[1]:getLine(1).."\n")
            io.write(luastr_5[2]:getLine(1).."\n")
            io.write(luastr_5[3]:getLine(1).."\n")
            io.close(config)
            shell.run("rm DOS/temp/temp.txt")
        end)
        cat.Basalt.Button_Text(sub[5],15,1,"Rm",colors.red,colors.black,function ()
            local tip = mainFrame:addMovableFrame()
            cat.Basalt.Window_Set(tip,"Are you del?",colors.black,nil,nil,13,5)
            cat.Basalt.Button_Text(tip,6,3,"OK",colors.red,colors.black,function ()
                shell.run("rm",".../DOS/Menu/"..menulist:getItemIndex().."/lua_5.txt")
                tip:remove()
            end)
        end)

        sub[6]:addLabel():setText(" lua - 6")
        local luastr_6 = {}
        luastr_6[1] = cat.Basalt.Textfield(sub[6],nil,nil,str_0,1,2,46)
        luastr_6[2] = cat.Basalt.Textfield(sub[6],nil,nil,str_1,1,3,46)
        luastr_6[3] = cat.Basalt.Textfield(sub[6],nil,nil,str_2,1,4,46)
        cat.Basalt.Button_Text(sub[6],11,1,"Add",colors.red,colors.black,function ()
            local tempmenu = io.open("DOS/temp/tempmenu.lua","w")
            tempmenu:read("a")
            for i in io.lines("DOS/Menu/Main/"..item.text) do
                if i == "--luatest" then
                tempmenu:write(i.." is occupied\n")
                tempmenu:write("--monitoring event:mouse_darg\n")
                tempmenu:write("    if click_x <= 40 and click_x >= 2 and click_y <= 11 and click_y >= 2 and click == 1 then\n")
                tempmenu:write('        local myfileIcon = cat.Icon(click_x,click_y,'..'"'..luastr_6[2]:getLine(1)..'"'..')\n')
                tempmenu:write('        cat.Text(click_x + 2,click_y + 7,colors.black,colors.lightBlue,'..'"'..luastr_6[3]:getLine(1)..'"'..')\n')
                tempmenu:write('        local temp = io.open("DOS/temp/temp.txt","w");io.output(temp);io.write(click_x.."\\n");io.write(click_y);io.close(temp)')
                tempmenu:write("    elseif click == 2 then\n")
                tempmenu:write("        menu_runing = 0\n")
                tempmenu:write("    end\n")
                tempmenu:write('    sleep(0.01)\n')
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
            io.close(tempmenu)
            shell.run("DOS/temp/tempmenu")
            shell.run("rm DOS/temp/tempmenu")
            local config = io.open(".../DOS/Menu/"..menulist:getItemIndex().."/lua_6.txt","w")
            io.output(config)
            for i in io.lines("DOS/temp/temp.txt") do
                io.write(i.."\n")
            end
            io.write(luastr_6[1]:getLine(1).."\n")
            io.write(luastr_6[2]:getLine(1).."\n")
            io.write(luastr_6[3]:getLine(1).."\n")
            io.close(config)
            shell.run("rm DOS/temp/temp.txt")
        end)
        cat.Basalt.Button_Text(sub[6],15,1,"Rm",colors.red,colors.black,function ()
            local tip = mainFrame:addMovableFrame()
            cat.Basalt.Window_Set(tip,"Are you del?",colors.black,nil,nil,13,5)
            cat.Basalt.Button_Text(tip,6,3,"OK",colors.red,colors.black,function ()
                shell.run("rm",".../DOS/Menu/"..menulist:getItemIndex().."/lua_6.txt")
                tip:remove()
            end)
        end)

        sub[7]:addLabel():setText(" lua - 7")
        local luastr_7 = {}
        luastr_7[1] = cat.Basalt.Textfield(sub[7],nil,nil,str_0,1,2,46)
        luastr_7[2] = cat.Basalt.Textfield(sub[7],nil,nil,str_1,1,3,46)
        luastr_7[3] = cat.Basalt.Textfield(sub[7],nil,nil,str_2,1,4,46)
        cat.Basalt.Button_Text(sub[7],11,1,"Add",colors.red,colors.black,function ()
            local tempmenu = io.open("DOS/temp/tempmenu.lua","w")
            tempmenu:read("a")
            for i in io.lines("DOS/Menu/Main/"..item.text) do
                if i == "--luatest" then
                tempmenu:write(i.." is occupied\n")
                tempmenu:write("--monitoring event:mouse_darg\n")
                tempmenu:write("    if click_x <= 40 and click_x >= 2 and click_y <= 11 and click_y >= 2 and click == 1 then\n")
                tempmenu:write('        local myfileIcon = cat.Icon(click_x,click_y,'..'"'..luastr_7[2]:getLine(1)..'"'..')\n')
                tempmenu:write('        cat.Text(click_x + 2,click_y + 7,colors.black,colors.lightBlue,'..'"'..luastr_7[3]:getLine(1)..'"'..')\n')
                tempmenu:write('        local temp = io.open("DOS/temp/temp.txt","w");io.output(temp);io.write(click_x.."\\n");io.write(click_y);io.close(temp)')
                tempmenu:write("    elseif click == 2 then\n")
                tempmenu:write("        menu_runing = 0\n")
                tempmenu:write("    end\n")
                tempmenu:write('    sleep(0.01)\n')
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
            io.close(tempmenu)
            shell.run("DOS/temp/tempmenu")
            shell.run("rm DOS/temp/tempmenu")
            local config = io.open(".../DOS/Menu/"..menulist:getItemIndex().."/lua_7.txt","w")
            io.output(config)
            for i in io.lines("DOS/temp/temp.txt") do
                io.write(i.."\n")
            end
            io.write(luastr_7[1]:getLine(1).."\n")
            io.write(luastr_7[2]:getLine(1).."\n")
            io.write(luastr_7[3]:getLine(1).."\n")
            io.close(config)
            shell.run("rm DOS/temp/temp.txt")
        end)
        cat.Basalt.Button_Text(sub[7],15,1,"Rm",colors.red,colors.black,function ()
            local tip = mainFrame:addMovableFrame()
            cat.Basalt.Window_Set(tip,"Are you del?",colors.black,nil,nil,13,5)
            cat.Basalt.Button_Text(tip,6,3,"OK",colors.red,colors.black,function ()
                shell.run("rm",".../DOS/Menu/"..menulist:getItemIndex().."/lua_7.txt")
                tip:remove()
            end)
        end)

        sub[8]:addLabel():setText(" lua - 8")
        local luastr_8 = {}
        luastr_8[1] = cat.Basalt.Textfield(sub[8],nil,nil,str_0,1,2,46)
        luastr_8[2] = cat.Basalt.Textfield(sub[8],nil,nil,str_1,1,3,46)
        luastr_8[3] = cat.Basalt.Textfield(sub[8],nil,nil,str_2,1,4,46)
        cat.Basalt.Button_Text(sub[8],11,1,"Add",colors.red,colors.black,function ()
            local tempmenu = io.open("DOS/temp/tempmenu.lua","w")
            tempmenu:read("a")
            for i in io.lines("DOS/Menu/Main/"..item.text) do
                if i == "--luatest" then
                tempmenu:write(i.." is occupied\n")
                tempmenu:write("--monitoring event:mouse_darg\n")
                tempmenu:write("    if click_x <= 40 and click_x >= 2 and click_y <= 11 and click_y >= 2 and click == 1 then\n")
                tempmenu:write('        local myfileIcon = cat.Icon(click_x,click_y,'..'"'..luastr_8[2]:getLine(1)..'"'..')\n')
                tempmenu:write('        cat.Text(click_x + 2,click_y + 7,colors.black,colors.lightBlue,'..'"'..luastr_8[3]:getLine(1)..'"'..')\n')
                tempmenu:write('        local temp = io.open("DOS/temp/temp.txt","w");io.output(temp);io.write(click_x.."\\n");io.write(click_y);io.close(temp)')
                tempmenu:write("    elseif click == 2 then\n")
                tempmenu:write("        menu_runing = 0\n")
                tempmenu:write("    end\n")
                tempmenu:write('    sleep(0.01)\n')
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
            io.close(tempmenu)
            shell.run("DOS/temp/tempmenu")
            shell.run("rm DOS/temp/tempmenu")
            local config = io.open(".../DOS/Menu/"..menulist:getItemIndex().."/lua_8.txt","w")
            io.output(config)
            for i in io.lines("DOS/temp/temp.txt") do
                io.write(i.."\n")
            end
            io.write(luastr_8[1]:getLine(1).."\n")
            io.write(luastr_8[2]:getLine(1).."\n")
            io.write(luastr_8[3]:getLine(1).."\n")
            io.close(config)
            shell.run("rm DOS/temp/temp.txt")
        end)
        cat.Basalt.Button_Text(sub[8],15,1,"Rm",colors.red,colors.black,function ()
            local tip = mainFrame:addMovableFrame()
            cat.Basalt.Window_Set(tip,"Are you del?",colors.black,nil,nil,13,5)
            cat.Basalt.Button_Text(tip,6,3,"OK",colors.red,colors.black,function ()
                shell.run("rm",".../DOS/Menu/"..menulist:getItemIndex().."/lua_8.txt")
                tip:remove()
            end)
        end)
        local y = 3
        for k,v in pairs(sub)do
            sidebar:addButton()
            :setText(" lua - "..k)
            :setBackground(colors.black)
            :setForeground(colors.white)
            :setSize(13,1)
            :setPosition(2, y)
            :onClick(function()
                for a, b in pairs(sub)do
                        b:hide()
                        v:show()
                end
            end)
            y = y + 1
        end
    else
        basalt.debug("Don't edit 1.lua!")
    end
end)
basalt.autoUpdate()