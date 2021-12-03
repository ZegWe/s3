local UIObject = require("Lua/module/uiObject")
local AudioPlayer = require("Lua/module/audio")

--- @class Scene:UIObject
local Scene = class("Scene", UIObject)

--- @param _name string
--- @param _ref string
--- @param _parent Canvas
--- @param _size Vector2
--- @param _enterPos Vector2
--- @param _bgm string
function Scene:initialize(_name, _ref, _parent, _size, _enterPos, _bgm)
    UIObject.initialize(self, _name, _ref, _parent.obj, _size, Vector2.Zero)
    print("new scene: " .. self.name)
    self.interactives = {}
    self.enterPos = _enterPos
    --- @type number
    self.tipTime = 0
    --- @type Player
    self.player = nil
    --- @type AudioPlayer
    self.bgm = AudioPlayer:new(_name .. "_bgm", _bgm, true, true)

    --- Update Interactive
    world.OnRenderStepped:Connect(
        function()
            for k, v in ipairs(self.interactives) do
                if
                    self.player ~= nil and
                        math.abs(self.player.obj.Offset.X - v.obj.Offset.X) <= math.max(200, v.obj.Size.X / 2 + 100)
                 then
                    v:SetActive(true)
                else
                    v:SetActive(false)
                end
            end
        end
    )
end

--- 设置是否可见
--- @param _visible boolean
function Scene:SetVisible(_visible)
    if self.player ~= nil then
        self.player:EnableControl(_visible)
    end
    self.obj:SetActive(_visible)
    if _visible == true then
        -- self.bgm:UnPause()
    else
        -- self.bgm:Pause()
    end
    if self.foreground ~= nil then
        self.foreground.obj:ToTop()
    end
    if self.filter ~= nil then
        self.filter.obj:ToTop()
    end
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

return Scene
