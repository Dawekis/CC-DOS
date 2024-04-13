cat = require(".../DOS.script.cat")
menu_runing = 1
while menu_runing == 1 do
    cat.Background.Set(1,1,51,19,colors.lightBlue,true)
    paintutils.drawPixel(1,19,colors.lime)
    cat.Text(2,1,colors.orange,colors.black,"MainMenu - <1>")
    local event,click,click_x,click_y = os.pullEvent("mouse_click")
    cat.Button.Set(1,19,1,1,function ()
        cat.Background.Set(1,16,8,3,colors.white)
        --menu program name list
        local shutdown = cat.Text(1,17,colors.black,colors.white,"Shutdown")
        local restart = cat.Text(1,18,colors.black,colors.white,"Restart")
        local myflie = cat.Text(1,16,colors.black,colors.white,"MyFile")
        --monitoring event:mouse_click
        local event,click,click_x,click_y = os.pullEvent("mouse_click")
        --Shutdown
        cat.Button.Text(shutdown,function ()
            term.setBackgroundColor(colors.black)
            shell.run("clear")
            menu_runing = 0
        end,click_x,click_y,click)
        --Restart
        cat.Button.Text(restart,function ()
            shell.run("DOS/Start/startup")
            shell.exit()
            menu_runing = 0
        end,click_x,click_y,click)
        --MyFile
        cat.Button.Text(myflie,function ()
            shell.run("DOS/Start/myfile")
        end,click_x,click_y,click)
    end,click_x,click_y,click)
end