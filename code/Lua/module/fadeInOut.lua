local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local Resource = require("Lua/resource").FadeInOut

--- @class FadeInOut:UIObject
local FadeInOut = class("FadeInOut", UIObject)

--- @param _parent UIObject
function FadeInOut:initialize(_parent)
    UIObject.initialize(self, "FadeInOut", Resource.Image, _parent.obj, Vector2(1600, 900), Vector2(0, 0))
    self.obj.AnchorsX = Vector2(0, 1)
    self.obj.AnchorsY = Vector2(0, 1)
end

--- @param _time number
--- @param _callback function
function FadeInOut:FadeOut(_time, _callback)
    self:SetVisible(true)
    self.obj.Alpha = 0
    if _time == nil then
        _time = 1
    end
    print(0)
    local function func(_dt)
        if self.obj.Alpha >= 1 then
            world.OnRenderStepped:Disconnect(func)
            self:SetVisible(false)
            print("FadeInOut:FadeOut")
            if _callback ~= nil then
                _callback()
            end
        else
            self.obj.Alpha = self.obj.Alpha + _dt / _time
        end
    end
    world.OnRenderStepped:Connect(func)
end

--- @param _time number
--- @param _callback function
function FadeInOut:FadeIn(_time, _callback)
    self:SetVisible(true)
    self.obj.Alpha = 1
    if _time == nil then
        _time = 1
    end
    print(1)
    local function func(_dt)
        if self.obj.Alpha <= 0 then
            world.OnRenderStepped:Disconnect(func)
            self:SetVisible(false)
            print("FadeInOut:FadeIn")
            if _callback ~= nil then
                _callback()
            end
        else
            self.obj.Alpha = self.obj.Alpha - _dt / _time
        end
    end
    world.OnRenderStepped:Connect(func)
end

return FadeInOut
