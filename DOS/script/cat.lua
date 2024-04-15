
--===================================================================================================--
--===============这个注释没有什么意义，它只是表明cat-文件处理&图形模块是由Dawekis开发的==================--
--===================================================================================================--
--===================================================================================================--
--===================              ======              =====              ===========================--
--===================    ================    ======    ==========    ================================--
--===================    ================    ======    ==========    ================================--
--===================    ================              ==========    ================================--
--===================    ================    ======    ==========    ================================--
--===================              ======    ======    ==========    ================================--
--===================================================================================================--
--===================================================================================================--

-----------------------------------------建立模块表cat--------------------------------------------
--注释：建立名为cat的模块表，以方便后续调用

cat = {
    Background = {},
    Line = {},
    Button = {},
    File = {},
    Basalt = {}
}

--=============================================图形处理=============================================--

------------------------------------------自定义窗口-----------------------------------------------
--注释：cat.Background.Set(x轴位置，y轴位置，长，高，颜色(透明则填“”)，是否带框[blink]，是否带关闭图标[blink])

function cat.Background.Set(x,y,long,high,color,borders_blink,close_blink)
    if borders_blink == true and color ~= ""
     then
        paintutils.drawFilledBox(x,y,x+long-1,y+high-1,color)
        paintutils.drawBox(x,y,x+long-1,y+high-1,colors.black)
     elseif borders_blink ~= true and color ~= ""
     then
        paintutils.drawFilledBox(x,y,x+long-1,y+high-1,color)
    elseif close_blink == true
    then
        paintutils.drawPixel(x+long-1,y+high-1,colors.red)
    elseif borders_blink == true and color == ""
    then
        paintutils.drawBox(x,y,x+long-1,y+high-1,colors.black)
    end
end

----------------------------------------加载nfp图片---------------------------------------------------
--注释：cat.Background.Load(x轴位置，y轴位置，nfp图片路径)

function cat.Background.Load(x,y,path)
    local image = paintutils.loadImage(path)
    paintutils.drawImage(image,x,y)
end

---------------------------------------自定义横线-------------------------------------------------
--注释：cat.Line_H(x轴位置，y轴位置，长度表，颜色表）

function cat.Line.H(x,y,long_table,color_table)
    if #long_table == #color_table
    then
        paintutils.drawLine(x,y,x+long_table[1]-1,y,color_table[1])
        if #long_table ~= 1
        then
            for i = 2,#long_table,1 do
                --叠加横线，横线全部居中
                paintutils.drawLine((x+long_table[1]-1)/2-long_table[2]/2,y,(x+long_table[1]-1)/2+long_table[2]/2,y,color_table[i])
            end
        end
    end
end

---------------------------------------自定义竖线-------------------------------------------------
--注释：cat.Line.H(x轴位置，y轴位置，高度表，颜色表）

function cat.Line.V(x,y,high_table,color_table)
    if #high_table == #color_table
    then
        paintutils.drawLine(x,y,x,y+high_table[1]-1,color_table[1])
        if #long_table ~= 1
        then
            --叠加竖线，竖线全部居中
            for i = 2,#long_table,1 do
                paintutils.drawLine(x,(y+high_table[1]-1)/2-high_table[2]/2,x,(y+high_table[1]-1)/2+high_table[2]/2,color_table[i])
            end
        end
    end
end

-------------------------------------------生成&加载nfp图标----------------------------------------------
--注释：cat.Icon(x轴位置，y轴位置，nfp图标路径(不填，则使用默认图标))

function cat.Icon(x,y,path)
    if path == nil
    then
        local image = paintutils.loadImage("Icon.nfp")
        paintutils.drawImage(image,x,y)
    else
        local image = paintutils.loadImage(path)
        paintutils.drawImage(image,x,y)
    end
    return
    {x,y}
end

--------------------------------------自定义横栏菜单----------------------------------------
--注释：cat.Button.Line(菜单表，x轴位置，y轴位置，文本颜色，文本背景颜色)

function cat.Button.Line(str_table,x,y,long,text_color,background_color)
    local str = "|"
    if x == nil or y == nil and long == nil and text_color == nil or background_color == nil
    then
        paintutils.drawLine(2,2,50,2,colors.white)
        term.setCursorPos(2,2);term.setBackgroundColor(colors.white);term.setTextColor(colors.black)
        --遍历打印菜单名
        for i = 1,#str_table,1 do
            str = str..str_table[i].."|"
        end
    else
        paintutils.drawLine(x,y,x+long-1,y,color)
        term.setCursorPos(x,y);term.setBackgroundColor(background_color);term.setTextColor(text_color)
        --遍历打印菜单名
        for i = 1,#str_table,1 do
            str = str..i.."|"
        end
    end
    print(str)
end

--------------------------------------自定义文本----------------------------------------
--注释：cat.Text(x轴位置，y轴位置,文本颜色，背景颜色，文本)

function cat.Text(x,y,Textcolor,Backgroundcolor,str)
    term.setCursorPos(x,y)
    term.setTextColor(Textcolor)
    term.setBackgroundColor(Backgroundcolor)
    print(str)
    return
    {x,y,#str}
end
--=============================================文件处理=============================================--
----------------------------------------遍历打印文件名称------------------------------------------
--注释：cat.Flie.List(x轴位置，y轴位置，行数，页数，文件目录路径)
--使用时尽量使页数为可变变量，否则其输出的文件列表会被定死。

function cat.File.List(x,y,line_num,page_num,flie_path)
    local flie_list = fs.list(flie_path)
    local m = math(#flie_list/line_num)
    term.setCursorPos(x,y)
    if #flie_list >= line_num and page_num <= m
    then
        for i = page_num+line_num*(page_num-1),line_num,1 do
            print(flie_list[i])
        end
    elseif #flie_list< line_num or page_num > m
    then
        for i = page_num+line_num*(page_num-1),#flie_list,1 do
            print(flie_list[i])
        end
    end
    --输出页数
    return
    page_num
end

----------------------------------连续播放一个目录下的nfp图-------------------------------------------
--注释：cat.Play(x轴位置，y轴位置，文件路径，速率)

function cat.Play(x,y,flie_path,rate)
    local flie_list = fs.list(flie_path)
    local flie_num = #flie_list
    for i = 1,flie_num do
        local image = paintutils.loadImage(flie_list[i])
        paintutils.drawImage(image,x,y)
        sleep(rate)
    end
end

--=============================================交互处理=============================================--
---------------------------------------图标按钮-----------------------------------
--注释：cat.BUtton.Icon(图标变量名(需要已经定义过的)，点击图标后需要触发的函数，监听鼠标的x轴变量名，监听鼠标的y轴变量名，监听鼠标的点击变量名)
--该函数需要和 os.pullEvent("mouse_click") 一同使用，click_x,click_y,click必须为被 os.pullEvent("mouse_click") 定义的变量

function cat.Button.Icon(Icon,func,click_x,click_y,click)
    local x = Icon[1]
    local y = Icon[2]
    if click_x >= x and click_x <= x+10 and click_y >= y and click_y <= y+6 and click == 1
    then
        return
        func()
    end
end

--------------------------------------------自定义按钮----------------------------------
--注释：cat.BUtton.Set(x轴位置，y轴位置，长，高，点击图标后需要触发的函数，监听鼠标的x轴变量名，监听鼠标的y轴变量名，监听鼠标的点击变量名)
--该函数需要和 os.pullEvent("mouse_click") 一同使用，click_x,click_y,click必须为被 os.pullEvent("mouse_click") 定义的变量

function cat.Button.Set(x,y,long,high,func,click_x,click_y,click)
    if click_x >= x and click_x <= x+long-1 and click_y >= y and click_y <= y+high-1 and click == 1
    then
        return
        func()
    end
end

--------------------------------------文本按钮----------------------------------------
--注释：cat.Button.Text(文本变量，点击文本后需要触发的函数，监听鼠标的x轴变量名，监听鼠标的y轴变量名，监听鼠标的点击变量名)
--该函数需要和 os.pullEvent("mouse_click") 一同使用，click_x,click_y,click必须为被 os.pullEvent("mouse_click") 定义的变量

function cat.Button.Text(text,func,click_x,click_y,click)
    local x = text[1]
    local y = text[2]
    local long = text[3]
    if click_x >= x and click_x <= x+long-1 and click_y == y and click == 1
    then
        return
        func()
    end
end

--=============================================Basalt处理=============================================--
--注释：本页函数需要调用外部库“Basalt”，如果没有调用该库，该页函数报错
local basalt = require(".../DOS.script.basalt")
------------------------------------------全屏程序窗口---------------------------------------------
--注释：cat.Basalt.Window_Over(重要框架变量，程序标题，背景颜色)
--调用该函数时请将basalt.createFrame变量填入重要框架变量中，否则报错

function cat.Basalt.Window_Over(mainFrame,title,Backgroundcolor)
    mainFrame:setBackground(Backgroundcolor):setForeground(colors.white)
    local upline = mainFrame:addPane()
    :setBackground(colors.black)
    :setSize(51,1)
    local menuline = mainFrame:addPane()
    :setPosition(1,2)
    :setBackground(colors.white)
    :setSize(51,1)
    local title = mainFrame:addLabel()
    :setText(title)
    local close = mainFrame:addButton()
    :setPosition(51,1)
    :setSize(1,1)
    :setText("X")
    :setBackground(colors.black)
    :setForeground(colors.red)
    :onClick(function (self,event,click,x,y)
        if(event == "mouse_click") and (click == 1) then
            basalt.stop()
        end
    end)
    basalt.update()
end

------------------------------------------自定义程序窗口---------------------------------------------
--注释：cat.Basalt.Window_Mini(重要框架变量，程序标题，背景颜色)
--调用该函数时请将Frame变量填入重要框架变量中，否则报错

function cat.Basalt.Window_Set(Frame,title,Backgroundcolor,x,y,long,high)
    Frame:setBackground(Backgroundcolor):setForeground(colors.white)
    :setPosition(x or math.random(2,18),y or math.random(2,8))
    :setSize(long or 40,high or 14)
    local long,high = Frame:getSize()
    local upline = Frame:addPane()
    :setBackground(colors.black)
    :setSize(long,1)
    local title = Frame:addLabel()
    :setText(title)
    local close = Frame:addButton()
    :setPosition(long,1)
    :setSize(1,1)
    :setText("X")
    :setBackground(colors.black)
    :setForeground(colors.red)
    :onClick(function (self,event,click,x,y)
        if(event == "mouse_click") and (click == 1) then
            Frame:remove()
        end
    end)
    basalt.update()
end

------------------------添加文本按钮----------------------------------
function cat.Basalt.Button_Text(Frame,x,y,str,Backgroundcolor,Textcolor,func)
    local w = #str
    Frame:addButton()
    :setPosition(x,y)
    :setText(str)
    :setSize(w,1)
    :setBackground(Backgroundcolor)
    :setForeground(Textcolor)
    :onClick(func)
end

------------------------添加滚动条---------------------------

function cat.Basalt.Scrollbar(Frame,SubFrame,x,y,high)
    local Scrollbar = Frame:addScrollbar()
    :setPosition(x or 51,y or 3)
    :setSize(1,high or 17)
    :setScrollAmount(10)
    :onChange(function (self,_,value)
        SubFrame:setOffset(0,value-1)
    end)
end

------------------------添加可选择列表----------------------------------

function cat.Basalt.List(Frame,Backgroundcolor,Textcolor,x,y,long,high)
    local w,h = Frame:getSize()
    local List = Frame:addList()
    :setPosition(x or 1,y or 1)
    :setSize(long or 51,high or 17)
    :setBackground(Backgroundcolor)
    :setForeground(Textcolor)
    return
    List
end

------------------------添加文本输入框----------------------------------
function cat.Basalt.Textfield(Frame,Backgroundcolor,Textcolor,str_table,x,y,long,high)
    local Textfield = Frame:addTextfield()
    :setPosition(x or 1,y or 2)
    :setSize(long or 40,high or 1)
    :setBackground(Backgroundcolor or colors.white)
    :setForeground(Textcolor or colors.black)
    for i = 1,#str_table do
        Textfield:addLine(str_table[1])
    end
    local str_table = Textfield:getLines()
    return
    Textfield
end

-------------------------------------运行程序---------------------------------------
--注释:若调用有关原版图形绘画的lua，退出程序后会导致所有父级程序丢失贴图[目前无解](覆盖绘画)！
local id = 1
local processes = {}
function cat.Basalt.OpenProgram(Frame,path, title, x, y, w, h)
    local pId = id
    id = id + 1
    local MovableScreen = Frame:addMovableFrame()
        :setSize(w or 40, h or 14)
        :setPosition(x or math.random(2, 12), y or math.random(2, 8))

        MovableScreen:addLabel()
        :setSize(w or 40, 1)
        :setBackground(colors.black)
        :setForeground(colors.lightGray)
        :setText(title or "New Program")

        local program = MovableScreen:addProgram()
        :setSize(w or 40, h or 14)
        :setPosition(1, 2)
        :execute(path or "rom/programs/shell.lua")

        MovableScreen:addButton()
        :setSize(1, 1)
        :setText("X")
        :setBackground(colors.black)
        :setForeground(colors.red)
        :setPosition(w or 40, 1)
        :onClick(function()
            program:stop()
            MovableScreen:remove()
            processes[pId] = nil
        end)
    processes[pId] = MovableScreen
    basalt.update()
    return MovableScreen
end

--------------------------------------返回调用表cat----------------------------------------------------
--注释：返回表cat，以便后续自定义变量调用cat模块

return
cat