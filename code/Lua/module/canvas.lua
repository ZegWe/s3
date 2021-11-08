--- @class Canvas
local Canvas = class("Canvas")

--- @type UiScreenUiObject
BaseGui = world:CreateObject("UiScreenUiObject", "BaseGui", world.Local)
print("BaseGui Created")

--- @param _obj UiFigureObject
--- @param _cam Camera
function Canvas:BindCamera(_cam)
    _cam.OnLateUpdate:Connect(
        function()
            self.obj.Size = Vector2(_cam.ViewPortWidth * 2, _cam.ViewPortHeight * 2)
        end
    )
end

function Canvas:initialize()
    --- @type UiFigureObject
    self.obj = world:CreateObject("UiFigureObject", "Canvas", BaseGui)
    self:BindCamera(world.CurrentCamera)
    print("Canvas Initialized!")
end

return Canvas
