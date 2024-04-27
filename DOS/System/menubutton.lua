local basalt = require(".../DOS.script.basalt")
local cat = require(".../DOS.script.cat")
    cat.Background.Set(1,13,8,6,colors.white)
    --menu program name list
    local shutdown = cat.Text(1,17,colors.black,colors.white,"Shutdown")
    local restart = cat.Text(1,18,colors.black,colors.white,"Restart")
    local myflie = cat.Text(1,16,colors.black,colors.white,"MyFile")
    local favorite = cat.Text(1,15,colors.black,colors.white,"Favorite")
    local cmd = cat.Text(1,14,colors.black,colors.white,"Cmd")
    local setup = cat.Text(1,13,colors.black,colors.white,"Setup")
    --monitoring event:mouse_click
    local event,click,click_x,click_y = os.pullEvent("mouse_click")
    --Shutdown
    cat.Button.Text(shutdown,function ()
        term.setBackgroundColor(colors.black)
        shell.run("clear")
        shell.run("rm DOS/System/run")
    end,click_x,click_y,click)
    --Restart
    cat.Button.Text(restart,function ()
        shell.run("rm DOS/System/run")
        shell.run("DOS/System/startup")
    end,click_x,click_y,click)
    --MyFile
    cat.Button.Text(myflie,function ()
        shell.run("DOS/System//myfile")
    end,click_x,click_y,click)
    --Favorite
    cat.Button.Text(favorite,function ()
        shell.run("DOS/System/Favorite")
    end,click_x,click_y,click)
    --Cmd
    cat.Button.Text(cmd,function ()
        shell.run("DOS/System/Cmd")
    end,click_x,click_y,click)
    cat.Button.Text(setup,function ()
        shell.run("DOS/System/Seting")
    end,click_x,click_y,click)