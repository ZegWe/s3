local Animation = require("Lua/module/animation")
local Interactive = require("Lua/module/interactive")
local MirrorImage = require("Lua/resource").Mirror

local Mirror = {}

--- @param _parent Scene
function Mirror.Get(_parent)
    local mirror = Interactive:new("Mirror", "", MirrorImage.Mirror, _parent, Vector2(190, 640), Vector2(930, -90))

    local animation = Animation:new(mirror.obj, MirrorImage.MirrorAni, 0.5)

    mirror:SetAnimation(animation)

    local function syncMirror()
        if math.abs(mirror.obj.Offset.X - _parent.player.obj.Offset.X) > 200 then
            world.OnRenderStepped:Disconnect(syncMirror)
            animation.t = MirrorImage.MirrorAni
            return
        end
        if _parent.player.faceLeft == true then
            animation.t = MirrorImage.MirrorPlayerAniRight
        else
            animation.t = MirrorImage.MirrorPlayerAniLeft
        end
    end

    mirror:SetFunc(
        function()
            world.OnRenderStepped:Connect(syncMirror)
        end
    )

    return mirror
end

return Mirror
