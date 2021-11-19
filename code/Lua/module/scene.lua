local UIObject = require("Lua/module/uiObject")

--- @class Scene:UIObject
local Scene = class("Scene", UIObject)

--- @param _name string
--- @param _ref string
--- @param _parent Canvas
--- @param _size Vector2
function Scene:initialize(_name, _ref, _parent, _size)
    UIObject.initialize(self, _name, _ref, _parent.obj, _size, Vector2.Zero)
    print("new scene: " .. self.name)
    self.interactives = {}
    --- @type Player
    self.player = nil
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
end

--- @param _interactive Interactive
function Scene:AddInteractive(_interactive)
    table.insert(self.interactives, _interactive)
end

return Scene
