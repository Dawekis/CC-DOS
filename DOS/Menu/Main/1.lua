local cat = require(".../DOS.script.cat")
while true do
    cat.Background.Set(1,1,51,19,colors.lightBlue,true)
    cat.Text(2,1,colors.orange,colors.black,"MainMenu - <1>")
    cat.Background.Load(11,1,"DOS/Image/logo_0.nfp")
    --editmenu image
    cat.Text(51,1,colors.orange,colors.black,"+")
    cat.Text(1,10,colors.white,colors.black,"<")
    cat.Text(51,10,colors.white,colors.black,">")
    --menu image
    paintutils.drawPixel(1,19,colors.lime)
    --myfile image
    local myfileIcon = cat.Icon(1,2,"DOS/Image/MyFile.nfp")
    cat.Text(3,8,colors.black,colors.lightBlue,"My File")
    --favorite image
    local FavoriteIcon = cat.Icon(1,11,"DOS/Image/Favorite.nfp")
    cat.Text(2,17,colors.black,colors.lightBlue,"Favorite")
    --cmd image
    local CmdIcon = cat.Icon(13,2,"DOS/Image/Cmd.nfp")
    cat.Text(17,8,colors.black,colors.lightBlue,"Cmd")
    --setup image
    local SetupIcon = cat.Icon(13,11,"DOS/Image/Seting.nfp")
    cat.Text(16,17,colors.black,colors.lightBlue,"Setup")
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
    --cmd program
    cat.Button.Icon(CmdIcon,function ()
        shell.run("DOS/System/Cmd")
    end,click_x,click_y,click)
    --setup program
    cat.Button.Icon(SetupIcon,function ()
        shell.run("DOS/System/seting")
    end,click_x,click_y,click)
    --Dawekis'tools program
    cat.Button.Set(28,2,14,17,function ()
        shell.run("DOS/System/Dawekis'tools")
    end,click_x,click_y,click)
    --menu program
    cat.Button.Set(1,19,1,1,function ()
        shell.run("DOS/System/menubutton")
    end,click_x,click_y,click)
    cat.Button.Set(51,1,1,1,function ()
        shell.run("DOS/System/editmenu")
    end,click_x,click_y,click)
    --menuchange program
    cat.Button.Set(51,10,1,1,function ()
        shell.run("DOS/Menu/Main/2")
    end,click_x,click_y,click)
end