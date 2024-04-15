local cat = require(".../DOS.script.cat")
local menu_runing = 0
if fs.isDir("DOS/System/run") == true then
    menu_runing = 1
end
while menu_runing == 1 do
    cat.Background.Set(1,1,51,19,colors.lightBlue,true)

--menu title
    cat.Text(2,1,colors.orange,colors.black,"MainMenu - <3>")

--mainmenu image
--editmenu image
    cat.Text(51,1,colors.orange,colors.black,"+")
    cat.Text(1,10,colors.white,colors.black,"<")
    cat.Text(51,10,colors.white,colors.black,">")
--menu image
    paintutils.drawPixel(1,19,colors.lime)

--Icon image
--Icon1
--Icon2
--Icon3
--Icon4
--Icon5
--Icon6
--Icon7
--Icon8

--monitoring event:mouse_click
    local event,click,click_x,click_y = os.pullEvent("mouse_click")

--Icon program
--program1
--program2
--program3
--program4
--program5
--program6
--program7
--program8

--mainmenuprogram
--menu program
    cat.Button.Set(1,19,1,1,function ()
        shell.run("DOS/System/menubutton")
    end,click_x,click_y,click)
--editmenu program
    cat.Button.Set(51,1,1,1,function ()
        shell.run("DOS/System/editmenu")
    end,click_x,click_y,click)

--menuchange program
    cat.Button.Set(1,10,1,1,function ()
        menu_runing = 0
    end,click_x,click_y,click)
    cat.Button.Set(51,10,1,1,function ()
        shell.run("DOS/Menu/Main/4")
    end,click_x,click_y,click)

--monitoring menu whether close
    if fs.isDir("DOS/System/run") ~= true then
        menu_runing = 0
    end
end
