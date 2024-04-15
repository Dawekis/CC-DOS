local basalt = require(".../DOS.script.basalt")
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
        basalt.stop()
    end
end)

--新建文件夹
local menu_file = mainFrame:addButton()
:setText("NewFile")
:setPosition(1,2)
:setSize(9,1)
:setBackground(colors.white)
:setForeground(colors.black)
:onClick(function (self,event,click,x,y)
    if(event == "mouse_click") and (click == 1) then
        local pId = id
        id = id + 1
        local NewFile = mainFrame:addMovableFrame()
        :setSize(40,14)
        :setPosition(math.random(2, 12),math.random(2, 8))

        local w,h = NewFile.getSize()

        NewFile:addLabel()
        :setSize(w, 1)
        :setBackground(colors.black)
        :setForeground(colors.white)
        :setText("NewFile")

        local str = NewFile:addTextfield()
        :setPosition(1,2)
        :setSize(40,1)
        :setForeground(colors.black)
        :setBackground(colors.white)
        :addLine("Please input new file name in here.")

        NewFile:addButton()
        :setPosition(19,8)
        :setSize(2,1)
        :setForeground(colors.black)
        :setBackground(colors.red)
        :setText("OK")
        :onClick(function ()
            local str = str:getLines()
            shell.run("mkdir",str[1])
            NewFile:close()
        end)

        NewFile:addButton()
        :setSize(1, 1)
        :setText("X")
        :setBackground(colors.black)
        :setForeground(colors.red)
        :setPosition(w, 1)
        :onClick(function()
            NewFile:remove()
            processes[pId] = nil
        end)
    processes[pId] = NewFile
    return NewFile
    end
end)

 --新建lua&nfp&txt
 local menu_run = mainFrame:addButton()
 :setText("NewLua&Nfp&Txt")
 :setPosition(13,2)
 :setSize(14,1)
 :setBackground(colors.white)
 :setForeground(colors.black)
 :onClick(function (self,event,click,x,y)
     if(event == "mouse_click") and (click == 1) then
         local pId = id
         id = id + 1
         local Newrun = mainFrame:addMovableFrame()
         :setSize(40,14)
         :setPosition(math.random(2, 12),math.random(2, 8))
 
         local w,h = Newrun.getSize()
 
         Newrun:addLabel()
         :setSize(w, 1)
         :setBackground(colors.black)
         :setForeground(colors.white)
         :setText("NewLua&Nfp")
 
         local str = Newrun:addTextfield()
         :setPosition(1,2)
         :setSize(40,1)
         :setForeground(colors.black)
         :setBackground(colors.white)
         :addLine("Please input new file name in here.")
 
         Newrun:addButton()
         :setPosition(19,8)
         :setSize(2,1)
         :setForeground(colors.black)
         :setBackground(colors.red)
         :setText("OK")
         :onClick(function ()
             local str = str:getLines()
             if string.find(str[1],"lua") ~= nil or string.find(str[1],"txt") ~= nil
             then
                shell.run("edit",str[1])
                Newrun:close()
             elseif string.find(str,"nfp") ~= nil
             then
                shell.run("paint",str[1])
                Newrun:close()
             end
         end)
 
         Newrun:addButton()
         :setSize(1, 1)
         :setText("X")
         :setBackground(colors.black)
         :setForeground(colors.red)
         :setPosition(w, 1)
         :onClick(function()
             Newrun:remove()
             processes[pId] = nil
         end)
     processes[pId] = Newrun
     return Newrun
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

--删除文件
local menu_del = mainFrame:addButton()
:setText("Del")
:setPosition(32,2)
:setSize(3,1)
:setBackground(colors.white)
:setForeground(colors.black)
:onClick(function (self,event,click,x,y)
    if(event == "mouse_click") and (click == 1) then
        local pId = id
        id = id + 1
        local del = mainFrame:addMovableFrame()
        :setSize(40,14)
        :setPosition(math.random(2, 12),math.random(2, 8))

        local w,h = del.getSize()

        del:addLabel()
        :setSize(w, 1)
        :setBackground(colors.black)
        :setForeground(colors.white)
        :setText("Del")

        local str = del:addTextfield()
        :setPosition(1,2)
        :setSize(40,1)
        :setForeground(colors.black)
        :setBackground(colors.white)
        :addLine("Please input you want del file name.")

        del:addButton()
        :setPosition(19,8)
        :setSize(2,1)
        :setForeground(colors.black)
        :setBackground(colors.red)
        :setText("OK")
        :onClick(function ()
            local str = str:getLines()
            if string.find(str[1],"DOS") == nil and string.find(str[1],"rom") == nil
            then
               shell.run("rm",str[1])
               del:close()
            end
            del:close()
        end)

        del:addButton()
        :setSize(1, 1)
        :setText("X")
        :setBackground(colors.black)
        :setForeground(colors.red)
        :setPosition(w, 1)
        :onClick(function()
            del:remove()
            processes[pId] = nil
        end)
    processes[pId] = del
    return del
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
    :setBackground(colors.lightBlue)
    :setSize(51,19)
    :setPosition(1,1)
    
    local w,h = miniscreen.getSize()

    local minifilelist = miniscreen:addList()
    :setBackground(colors.lightBlue)
    :setForeground(colors.black)
    :setPosition(1,3)
    :setSize(w*50/51,h*18/19)

    local miniscrollbar = miniscreen:addScrollbar()
    :setPosition(w,3)
    :setSize(1,h*18/19)
    :onChange(function (self,_,value)
    minifilelist:setOffset(0,value-1)
    end)

    miniscreen:addPane()
    :setSize(w,1)
    :setBackground(colors.black)
    miniscreen:addPane()
    :setSize(w,2)
    :setBackground(colors.white)

    miniscreen:addLabel()
    :setPosition(1,1)
    :setSize(w, 1)
    :setBackground(colors.black)
    :setForeground(colors.white)
    :setText(title)

     --新建lua&nfp&txt
 local menu_run = miniscreen:addButton()
 :setText("NewLua&Nfp&Txt")
 :setPosition(13,2)
 :setSize(14,1)
 :setBackground(colors.white)
 :setForeground(colors.black)
 :onClick(function (self,event,click,x,y)
     if(event == "mouse_click") and (click == 1) then
         local pId = id
         id = id + 1
         local Newrun = miniscreen:addMovableFrame()
         :setSize(40,14)
         :setPosition(math.random(2, 12),math.random(2, 8))
 
         local w,h = Newrun.getSize()
 
         Newrun:addLabel()
         :setSize(w, 1)
         :setBackground(colors.black)
         :setForeground(colors.white)
         :setText("NewLua&Nfp")
 
         local str = Newrun:addTextfield()
         :setPosition(1,2)
         :setSize(40,1)
         :setForeground(colors.black)
         :setBackground(colors.white)
         :addLine("Please input new file name in here.")
 
         Newrun:addButton()
         :setPosition(19,8)
         :setSize(2,1)
         :setForeground(colors.black)
         :setBackground(colors.red)
         :setText("OK")
         :onClick(function ()
             local str = str:getLines()
             if string.find(str[1],"lua") ~= nil or string.find(str[1],"txt") ~= nil
             then
                shell.run("edit",usepath.."/"..str[1])
                Newrun:close()
             elseif string.find(str,"nfp") ~= nil
             then
                shell.run("paint",usepath.."/"..str[1])
                Newrun:close()
             end
         end)
 
         Newrun:addButton()
         :setSize(1, 1)
         :setText("X")
         :setBackground(colors.black)
         :setForeground(colors.red)
         :setPosition(w, 1)
         :onClick(function()
             Newrun:remove()
             processes[pId] = nil
         end)
     processes[pId] = Newrun
     return Newrun
     end
 end)
    
    --新建文件夹
local menu_file = miniscreen:addButton()
:setText("NewFile")
:setPosition(1,2)
:setSize(9,1)
:setBackground(colors.white)
:setForeground(colors.black)
:onClick(function (self,event,click,x,y)
    if(event == "mouse_click") and (click == 1) then
        local pId = id
        id = id + 1
        local NewFile = miniscreen:addMovableFrame()
        :setSize(40,14)
        :setPosition(math.random(2, 12),math.random(2, 8))

        local w,h = NewFile.getSize()

        NewFile:addLabel()
        :setSize(w, 1)
        :setBackground(colors.black)
        :setForeground(colors.white)
        :setText("NewFile")

        local str = NewFile:addTextfield()
        :setPosition(1,2)
        :setSize(40,1)
        :setForeground(colors.black)
        :setBackground(colors.white)
        :addLine("Please input new file name in here.")

        NewFile:addButton()
        :setPosition(19,8)
        :setSize(2,1)
        :setForeground(colors.black)
        :setBackground(colors.red)
        :setText("OK")
        :onClick(function ()
            local str = str:getLines()
            shell.run("mkdir",usepath.."/"..str[1])
            NewFile:close()
        end)

        NewFile:addButton()
        :setSize(1, 1)
        :setText("X")
        :setBackground(colors.black)
        :setForeground(colors.red)
        :setPosition(w, 1)
        :onClick(function()
            NewFile:remove()
            processes[pId] = nil
        end)
    processes[pId] = NewFile
    return NewFile
    end
end)

--删除文件
local menu_del = miniscreen:addButton()
:setText("Del")
:setPosition(32,2)
:setSize(3,1)
:setBackground(colors.white)
:setForeground(colors.black)
:onClick(function (self,event,click,x,y)
    if(event == "mouse_click") and (click == 1) then
        local pId = id
        id = id + 1
        local del = miniscreen:addMovableFrame()
        :setSize(40,14)
        :setPosition(math.random(2, 12),math.random(2, 8))

        local w,h = del.getSize()

        del:addLabel()
        :setSize(w, 1)
        :setBackground(colors.black)
        :setForeground(colors.white)
        :setText("Del")

        local str = del:addTextfield()
        :setPosition(1,2)
        :setSize(40,1)
        :setForeground(colors.black)
        :setBackground(colors.white)
        :addLine("Please input you want del file name.")

        del:addButton()
        :setPosition(19,8)
        :setSize(2,1)
        :setForeground(colors.black)
        :setBackground(colors.red)
        :setText("OK")
        :onClick(function ()
            local str = str:getLines()
            if string.find(str[1],"DOS") == nil and string.find(str[1],"rom") == nil
            then
               shell.run("rm",usepath.."/"..str[1])
               del:close()
            end
            del:close()
        end)

        del:addButton()
        :setSize(1, 1)
        :setText("X")
        :setBackground(colors.black)
        :setForeground(colors.red)
        :setPosition(w, 1)
        :onClick(function()
            del:remove()
            processes[pId] = nil
        end)
    processes[pId] = del
    return del
    end
end)

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
            minifilelist:addItem(j,colors.lightBlue,colors.black)
        end
    end
    minifilelist:onSelect(function (self,event,item)
        if string.find(item.text,"%.") == nil
        then
            openfile(item.text)
        elseif string.find(item.text,"lua") ~= nil
        then
            shell.run("edit",usepath.."/"..item.text)
        elseif string.find(item.text,"nfp") ~= nil
        then
            shell.run('paint',usepath.."/"..item.text)
        elseif string.find(item.text,"txt") ~= nil
        then
            shell.run('edit',usepath.."/"..item.text)
        end
    end)
    processes[pId] = miniscreen
end

filelistname:onSelect(function (self,event,item)
    if string.find(item.text,"%.") == nil
        then
            openfile(item.text)
        elseif string.find(item.text,"lua") ~= nil
        then
            shell.run("edit",item.text)
        elseif string.find(item.text,"nfp") ~= nil
        then
            shell.run('paint',item.text)
        elseif string.find(item.text,"txt") ~= nil
        then
            shell.run('edit',item.text)
        end
end)

basalt.autoUpdate()

