--- @type UIObject
local UIObject = require("Lua/module/uiObject")

--- @class Interactive:UIObject
local Interactive = class("Interactive", UIObject)

--- @param _name string
--- @param _ref string
--- @param _ref_active string
--- @param _parent UIObject
--- @param _size Vector2
--- @param _offset Vector2
--- @param _func function
function Interactive:initialize(_name, _ref, _ref_active, _parent, _size, _offset, _func)
    UIObject.initialize(self, _name, _ref, _parent.obj, _size, _offset)
    self.ref = _ref
    self.ref_active = _ref_active
    self:SetFunc(_func)
    self.interactive = false
    self.pos = _offset
    self:SetVisible(true)
    self:SetActive(false)
end

function Interactive:SetFunc(_func)
    print("set interactive func ")
    local func = function()
        if self.interactive == true then
            _func()
        end
    end
    UIObject.SetClickFunc(self, func)
end

--- @param _active boolean
function Interactive:SetActive(_active)
    if _active == true then
        self.obj.Texture = ResourceManager.GetTexture(self.ref_active)
    else
        self.obj.Texture = ResourceManager.GetTexture(self.ref)
    end
    self.interactive = _active
end

function Interactive:CallFunc()
    self.func()
end

return Interactive
