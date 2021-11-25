--- @class Camera
local Camera = class("Camera")

--- @param _player Player
function Camera:initialize(_player)
    self.player = _player
    world.OnRenderStepped:Connect(
        function()
            self:Update()
        end
    )
end

function Camera:Update()
    if self.player and self.player.scene then
        local width = self.player.scene.obj.Parent.Size.X / 2 - 500
        local playerOffset = self.player.obj.Offset.X
        local sceneOffset = self.player.scene.obj.Offset.X
        self.player.scene.obj.Offset = Vector2(math.clamp(sceneOffset, -playerOffset - width, -playerOffset + width), 0)
    end
end

return Camera
