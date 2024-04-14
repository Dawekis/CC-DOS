cat = require(".../DOS.script.cat")
menu_runing = 1
while menu_runing == 1 do
    cat.Background.Set(1,1,51,19,colors.lightBlue,true)
    cat.Text(2,1,colors.orange,colors.black,"MainMenu - <1>")
    --menu image
    paintutils.drawPixel(1,19,colors.lime)
    --myfile image
    local myfileIcon = cat.Icon(1,2,"DOS/Image/MyFile.nfp")
    cat.Text(3,8,colors.black,colors.lightBlue,"My File")
    --favorite image
    local FavoriteIcon = cat.Icon(1,11,"DOS/Image/Favorite.nfp")
    cat.Text(2,17,colors.black,colors.lightBlue,"Favorite")
    --monitoring event:mouse_click
    local event,click,click_x,click_y = os.pullEvent("mouse_click")
    --myfile program
    cat.Button.Icon(myfileIcon,function ()
        shell.run("DOS/System//myfile")
    end,click_x,click_y,click)
    --favorite program
    cat.Button.Icon(FavoriteIcon,function ()
        shell.run("DOS/System/Favorite")
    end,click_x,click_y,click)
    --menu program
    cat.Button.Set(1,19,1,1,function ()
        cat.Background.Set(1,15,8,4,colors.white)
        --menu program name list
        local shutdown = cat.Text(1,17,colors.black,colors.white,"Shutdown")
        local restart = cat.Text(1,18,colors.black,colors.white,"Restart")
        local myflie = cat.Text(1,16,colors.black,colors.white,"MyFile")
        local favorite = cat.Text(1,15,colors.black,colors.white,"Favorite")
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
            shell.run("DOS/System//startup")
            shell.exit()
            menu_runing = 0
        end,click_x,click_y,click)
        --MyFile
        cat.Button.Text(myflie,function ()
            shell.run("DOS/System//myfile")
        end,click_x,click_y,click)
        --Favorite
        cat.Button.Text(favorite,function ()
            shell.run("DOS/System/Favorite")
        end,click_x,click_y,click)
    end,click_x,click_y,click)
end