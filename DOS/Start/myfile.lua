local basalt = require("basalt")
local processes = {}
local id = 1
local mainFrame = basalt.createFrame()
:setForeground(colors.white)

local Titleline = mainFrame:addPane()
:setSize(51,1)
:setBackground(colors.black)

local Menuline = mainFrame:addPane()
:setSize(51,1)
:setPosition(1,2)
:setBackground(colors.white)

local Title = mainFrame:addLabel()
:setText("My File")

local close = mainFrame:addButton()
:setPosition(51,1)
:setSize(1,1)
:setText("X")
:setBackground(colors.black)
:setForeground(colors.red)
:onClick(function (self,event,click,x,y)
    if(event == "mouse_click") and (click == 1) then
        mainFrame:require()
    end
end)

local mainscreen = mainFrame:addFrame()
:setPosition(1,3)
:setSize(50,17)
:setBackground(colors.lightBlue)

local scrollbar = mainFrame:addScrollbar()
:setPosition(51,3)
:setSize(1,17)
:onChange(function (self,_,value)
    mainscreen:setOffset(0,value-1)
end)

local filelistname = mainscreen:addList()
:setPosition(1,1)
:setSize(50,17)
:setBackground(colors.lightBlue)

local filelist = fs.list(".../")

for i,j in pairs(filelist) do
    if fs.isDir(j) then
        filelistname:addItem(j,colors.lightBlue,colors.black)
    end
end

--建立程序启动
local function openProgram(path, title, x, y, w, h)
    local pId = id
    id = id + 1
    local f = mainFrame:addMovableFrame()
        :setSize(w or 40, h or 14)
        :setPosition(x or math.random(2, 12), y or math.random(2, 8))

        local w,h = f.getSize()

        f:addPane()
    :setSize(w,1)
    :setBackground(colors.black)

    f:addLabel()
        :setSize(w, 1)
        :setBackground(colors.black)
        :setForeground(colors.white)
        :setText(title)

    f:addProgram()
        :setSize(w, h)
        :setPosition(1, 2)
        :execute(path)

    f:addButton()
        :setSize(1, 1)
        :setText("X")
        :setBackground(colors.black)
        :setForeground(colors.red)
        :setPosition(w, 1)
        :onClick(function()
            f:remove()
            processes[pId] = nil
        end)
    processes[pId] = f
    return f
end


--建立打开文件夹函数
path = {}
path[0] = "..."
num = 0
local function openfile(title)
    usepath = path[0]
    num = num+1
    path[num] = title
    for i = 1,num do
        usepath = usepath.."/"..path[i]
    end
    local pId = id
    id = id + 1
    local miniscreen = mainFrame:addFrame()
    :setBackground(colors.white)
    :setSize(51,19)
    :setPosition(1,1)
    
    local w,h = miniscreen.getSize()

    local minifilelist = miniscreen:addList()
    :setBackground(colors.white)
    :setForeground(colors.black)
    :setPosition(1,2)
    :setSize(w*50/51,h*18/19)

    local miniscrollbar = miniscreen:addScrollbar()
    :setPosition(w,2)
    :setSize(1,h*18/19)
    :onChange(function (self,_,value)
    minifilelist:setOffset(0,value-1)
    end)

    miniscreen:addPane()
    :setSize(w,1)
    :setBackground(colors.black)

    miniscreen:addLabel()
    :setPosition(2,1)
    :setSize(w, 1)
    :setBackground(colors.black)
    :setForeground(colors.white)
    :setText(title or "New Program")
    

    miniscreen:addButton()
        :setSize(1, 1)
        :setText("X")
        :setBackground(colors.black)
        :setForeground(colors.red)
        :setPosition(w, 1)
        :onClick(function()
            miniscrDDeen:remove()
            num = num-1
        end)
    local filelist = fs.list(usepath)
    for i,j in pairs(filelist) do
        if fs.isDir(usepath) then
            minifilelist:addItem(j,colors.white,colors.black)
        end
    end
    minifilelist:onSelect(function (self,event,item)
        if string.find(item.text,"%.") == nil
        then
            openfile(item.text)
        elseif string.find(item.text,"lua") ~= nil
        then
            openProgram(usepath.."/"..item.text,item.text)
        elseif string.find(item.text,"nfp") ~= nil
        then
            shell.run('paint',usepath.."/"..item.text)
        end
    end)
    processes[pId] = miniscreen
end

filelistname:onSelect(function (self,event,item)
    openfile(item.text)
end)

basalt.autoUpdate()

