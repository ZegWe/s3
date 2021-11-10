local UIObject = require("Lua/module/uiObject")
local PlayerImage = require("Lua/resource").PlayerImage

local playerWidth = 200
local playerHeight = 400
local KeyMoveLeft = Enum.KeyCode.A
local KeyMoveRight = Enum.KeyCode.D
local dt = 0.2

local tableNum = {}
--- return next element of given table
--- @param _t table
local function tableNext(_t)
    if tableNum[_t] == nil or tableNum[_t] == table.nums(_t) then
        tableNum[_t] = 1
    else
        tableNum[_t] = tableNum[_t] + 1
    end
    return tableNum[_t]
end

--- @class Player:UIObject
local Player = class("Player", UIObject)

--- @param _parent UIObject
function Player:initialize(_parent)
    UIObject.initialize(
        self,
        "Player",
        tableNext(PlayerImage.Idle_Left),
        _parent.obj,
        Vector2(playerWidth, playerHeight),
        Vector2.Zero
    )
end

--- @param _scene Scene
function Player:EnterScene(_scene)
    self.obj.Parent = _scene.obj
    self.obj.Offset = Vector2.Zero
    self:SetVisible(true)
end

function Player:Move()
    local face = ""
    if self.faceLeft == true then
        face = "Left"
    else
        face = "Right"
    end
    local dir = ""
    if self.controlEnabled == false or self.moveSpeed == 0 then
        dir = "Idle" .. "_" .. face
    elseif self.moveSpeed == 1 then
        dir = "Walk" .. "_" .. face
    else
        dir = "Idle" .. "_" .. face
    end
    self.obj.Texture = ResourceManager.GetTexture(tableNext(PlayerImage[dir]))
end

function Player:InitControl()
    self.controlEnabled = false
    self.faceLeft = false
    self.moveSpeed = 0
    invoke(
        function()
            while wait(dt) do
                Player.Move(self)
            end
        end
    )
    Input.OnKeyDown:Connect(
        function()
            if self.controlEnabled == false then
                return
            end
            if Input.GetPressKeyData(KeyMoveLeft) == Enum.KeyState.Press then
                self.faceLeft = true
                self.moveSpeed = 1
            elseif Input.GetPressKeyData(KeyMoveRight) == Enum.KeyState.Press then
                self.faceLeft = false
                self.moveSpeed = 1
            end
        end
    )
    Input.OnKeyUp:Connect(
        function()
            if
                Input.GetPressKeyData(KeyMoveLeft) == Enum.KeyState.Release and self.faceLeft == true and
                    self.moveSpeed == 1
             then
                self.moveSpeed = 0
            elseif
                Input.GetPressKeyData(KeyMoveRight) == Enum.KeyState.Release and self.faceLeft == false and
                    self.moveSpeed == 1
             then
                self.moveSpeed = 0
            end
        end
    )
end

--- @param _enable boolean
function Player:EnableControl(_enable)
    self.controlEnabled = _enable
end

return Player
