--- @class Camera
local Camera = class("Camera")

--- @param _player Player
function Camera:initialize(_player)
    self.player = _player
    self.focus = nil
    world.OnRenderStepped:Connect(
        function(_dt)
            self:Update(_dt)
        end
    )
end

function Camera:Update(_dt)
    if self.player and self.player.scene then
        if self.focus then
            self.player.scene.obj.Offset = Vector2(-self.focus, 0)
            return
        end
        local min = 60 * _dt
        local playerOffset = self.player.obj.Offset.X
        local sceneOffset = self.player.scene.obj.Offset.X
        local diff = playerOffset + sceneOffset
        if math.abs(diff) < min then
            self.player.scene.obj.Offset = Vector2(sceneOffset - diff, 0)
        else
            self.player.scene.obj.Offset = Vector2(sceneOffset - diff * _dt * 3, 0)
        end
    -- self.player.scene.obj.Offset = Vector2(math.clamp(sceneOffset, -playerOffset - width, -playerOffset + width), 0)
    end
end

return Camera
