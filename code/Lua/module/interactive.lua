--- @type UIObject
local UIObject = require("Lua/module/uiObject")

--- @class Interactive:UIObject
local Interactive = class('Interactive', UIObject)

--- @param _name string
--- @param _ref string
--- @param _ref_active string
--- @param _parent UIObject
--- @param _size Vector2
--- @param _offset Vector2
--- @param _func function
function Interactive:initialize(_name, _ref, _ref_active, _parent, _size, _offset, _func)
    UIObject.initialize(self, _name, "", _parent.obj, Vector2.Zero, _offset)
    self.normal = UIObject:new(_name.."_normal", _ref, self.obj, _size, Vector2.Zero)
    self.active = UIObject:new(_name.."_active", _ref_active, self.obj, _size, Vector2.Zero)
    self.active:SetClickFunc(_func)
    self.interactive = false
    self.pos = _offset
    self.func = _func
    self:SetVisible(true)
    self:SetActive(false)
end

--- @param _active boolean
function Interactive:SetActive(_active)
    self.active:SetVisible(_active)
    self.normal:SetVisible(not _active)
    self.interactive = _active
end

function Interactive:CallFunc()
    self.func()
end

return Interactive