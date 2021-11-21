local UIObject = require("Lua/module/uiObject")
local FloatTip = require("Lua/module/floatTip")

--- @class Scene:UIObject
local Scene = class("Scene", UIObject)

--- @param _name string
--- @param _ref string
--- @param _parent Canvas
--- @param _size Vector2
--- @param _enterPos Vector2
function Scene:initialize(_name, _ref, _parent, _size, _enterPos)
    UIObject.initialize(self, _name, _ref, _parent.obj, _size, Vector2.Zero)
    print("new scene: " .. self.name)
    self.interactives = {}
    self.enterPos = _enterPos
    --- @type FloatTip
    self.tip = nil
    --- @type Player
    self.player = nil

    --- Update Interactive
    world.OnRenderStepped:Connect(
        function()
            if self.player == nil then
                return
            end
            for k, v in ipairs(self.interactives) do
                if math.abs(self.player.obj.Offset.X - v.obj.Offset.X) <= 400 then
                    v:SetActive(true)
                else
                    v:SetActive(false)
                end
            end
        end
    )

    --- Update FloatTip
    world.OnRenderStepped:Connect(
        function()
            if self.tip ~= nil then
                self.tip.obj.Offset = Vector2(-self.obj.Offset.X, -325)
            end
        end
    )
end

--- 设置是否可见
--- @param _visible boolean
function Scene:SetVisible(_visible)
    print("-------Scene--------")
    if self.player ~= nil then
        self.player:EnableControl(_visible)
    end
    self.obj:SetActive(_visible)
end

--- @param _interactive Interactive
function Scene:AddInteractive(_interactive)
    table.insert(self.interactives, _interactive)
end

--- @param _interactive Interactive
function Scene:RemoveInteractive(_interactive)
    for k, v in ipairs(self.interactives) do
        if v == _interactive then
            table.remove(self.interactives, k)
        end
    end
end

--- @param _text string
--- @param _time number
function Scene:Tip(_text, _time)
    if self.tip ~= nil then
        self.tip:Destroy()
        self.tip = nil
    end
    self.tip = FloatTip:new(_text, self.obj, Vector2(-self.obj.Offset.X, -325))
    local tip = self.tip
    tip:SetClickFunc(
        function()
            if tip == nil then return end
            tip:Destroy()
            tip = nil
            self.tip = nil
        end
    )
    tip.obj:ToTop()
    if _time > 0 then
        wait(_time)
        if tip == nil or self.tip == nil then
            return
        end
        self.tip = nil
        tip:Destroy()
    end
end

function Scene:ClearTip()
    if self.tip ~= nil then
        self.tip:Destroy()
        self.tip = nil
    end
end

return Scene
