local cat = require(".../DOS.script.cat")
local menu_runing = 1
--tip
while menu_runing == 1 do
--test pine
    cat.Background.Set(1,1,51,19,colors.lightBlue,true)
--menu title
--============mainmenu image==================--
--editmenu image
    cat.Text(51,1,colors.orange,colors.black,"+")
    cat.Text(1,10,colors.white,colors.black,"<")
    cat.Text(51,10,colors.white,colors.black,">")
--menu image
    paintutils.drawPixel(1,19,colors.lime)
--lua config
--Icon image
--luatest
--monitoring event:mouse_click
    local event,click,click_x,click_y = os.pullEvent("mouse_click")

--============Icon program============--
--luaprogram
--============mainmenuprogram============--
--menu program
    cat.Button.Set(1,19,1,1,function ()
        shell.run("DOS/System/menubutton")
    end,click_x,click_y,click)
--editmenu program
    cat.Button.Set(51,1,1,1,function ()
        shell.run("DOS/System/editmenu")
    end,click_x,click_y,click)
--menuchange program
--monitoring menu whether close
end