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
                tempmenu:write("    if click_x <= 40 and click_x >= 2 and click_y <= 11 and click_y >= 2 and click == 1 then\n")
                tempmenu:write('        local myfileIcon = cat.Icon(click_x,click_y,'..'"'..str_1[1]..'"'..')\n')
                tempmenu:write('        cat.Text(click_x + 2,click_y + 7,colors.black,colors.lightBlue,'..'"'..str_2[1]..'"'..')\n')
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
            tempmenu:close()
            shell.run("DOS/temp/tempmenu")
            shell.run("rm DOS/temp/tempmenu")
        end)
    else
        basalt.debug("Don't edit 1.lua!")
    end
end)
