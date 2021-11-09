local UIObject = require('Lua/module/uiObject')

local playerWidth = 200
local playerHeight = 400
local PlayerImage = 'Local/player'

--- @class Player:UIObject
local Player = class('Player', UIObject)

--- @param _parent UIObject
function Player:initialize(_parent)
    UIObject.initialize(self, 'Player', PlayerImage, _parent.obj, Vector2(playerWidth, playerHeight), Vector2.Zero)
end

--- @param _scene Scene
function Player:EnterScene(_scene)
    self.obj.Parent = _scene.obj
    self.obj.Offset = Vector2.Zero
    self:SetVisible(true)
end

return Player