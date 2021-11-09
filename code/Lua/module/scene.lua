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
end

return Scene
