local UIObject = require("Lua/module/uiObject")
local Background = require("Lua/resource").FloatTip.Background

--- @class FloatTip:UIObject
local FloatTip = class("FloatTip", UIObject)

--- @param _text string
--- @param _parent Object
--- @param _pos Vector2
function FloatTip:initialize(_text, _parent, _pos)
    UIObject.initialize(self, "float tip", Background, _parent, Vector2(1030, 250), _pos)
    self.obj:SetActive(true)
    self.text = world:CreateObject("UiTextObject", "text", self.obj)
    self.text.FontSize = 36
    self.text.Color = Color(255, 255, 255)
    self.text.Text = _text
end

--- @param _text string
function FloatTip:SetText(_text)
    self.text.Text = _text
end

--- @param _color Color
function FloatTip:SetColor(_color)
    self.text.Color = _color
end

function FloatTip:Destroy()
    self.obj:Destroy()
end

return FloatTip
