local basalt = require("basalt")
local main = basalt.createFrame()
local aButton = main:addButton():setText("Click")

aButton:onClick(function(self,event,button,x,y)
  if(event=="mouse_click")and(button==1)then
    shell.run("DOS/Start/startup")
  end
end)
basalt.autoUpdate()