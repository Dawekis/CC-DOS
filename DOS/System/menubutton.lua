local basalt = require(".../DOS.script.basalt")
local cat = require(".../DOS.script.cat")
    cat.Background.Set(1,12,8,7,colors.white)
    --menu program name list
    local shutdown = cat.Text(1,17,colors.black,colors.white,"Shutdown")
    local restart = cat.Text(1,18,colors.black,colors.white,"Restart")
    local myflie = cat.Text(1,16,colors.black,colors.white,"MyFile")
    local favorite = cat.Text(1,15,colors.black,colors.white,"Favorite")
    local cmd = cat.Text(1,14,colors.black,colors.white,"Cmd")
    local setup = cat.Text(1,13,colors.black,colors.white,"Setup")
    local Dawekis_tools = cat.Text(1,12,colors.black,colors.white,"D'Tools")
    --monitoring event:mouse_click
    local event,click,click_x,click_y = os.pullEvent("mouse_click")
    --Shutdown
    cat.Button.Text(shutdown,function ()
        term.setBackgroundColor(colors.black)
        shell.run("shutdown")
    end,click_x,click_y,click)
    --Restart
    cat.Button.Text(restart,function ()
        shell.run("reboot")
    end,click_x,click_y,click)
    --MyFile
    cat.Button.Text(myflie,function ()
        shell.run("DOS/System//myfile")
    end,click_x,click_y,click)
    --Favorite
    cat.Button.Text(favorite,function ()
        shell.run("DOS/System/favorite")
    end,click_x,click_y,click)
    --Cmd
    cat.Button.Text(cmd,function ()
        shell.run("DOS/System/cmd")
    end,click_x,click_y,click)
    --Setup
    cat.Button.Text(setup,function ()
        shell.run("DOS/System/seting")
    end,click_x,click_y,click)
        --Tools
    cat.Button.Text(Dawekis_tools,function ()
        shell.run("DOS/System/Dawekis'tools")
    end,click_x,click_y,click)