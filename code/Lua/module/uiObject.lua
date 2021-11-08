--- 对UiImageObject的封装
--- @class UIObject
local UIObject = class('UIObject')


--- @param _name string 节点树上的名字
--- @param _ref string 图片资源路径
--- @param _parent Object 父节点
--- @param _size Vector2 
--- @param _offset Vector2 相对于父节点的偏移
function UIObject:initialize(_name, _ref, _parent, _size, _offset)
    --- @type UiImageObject
    self.obj = world:CreateObject('UiImageObject', _name, _parent)
    self.obj.Texture = ResourceManager.GetTexture(_ref)
    self.obj.Size = _size
    self.obj.Offset = _offset
end

--- 设置是否可见
--- @param _visible boolean
function UIObject:SetVisible(_visible)
    self.obj:SetActive(_visible)
end

return UIObject