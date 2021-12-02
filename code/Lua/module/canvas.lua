--- @class Canvas
local Canvas = class("Canvas")

--- @type UiScreenUiObject
BaseGui = world:CreateObject("UiScreenUiObject", "BaseGui", world.Local)
print("BaseGui Created")

function Canvas:initialize()
    --- @type UiFigureObject
    self.obj = world:CreateObject("UiFigureObject", "Canvas", BaseGui)
    self.obj.Color = Color(0, 0, 0, 255)
    self.obj.Size = Vector2(1600, 900)
    self.obj.AnchorsX = Vector2(0, 1)
    self.obj.AnchorsY = Vector2(0, 1)
    print("Canvas Initialized!")
end

return Canvas
