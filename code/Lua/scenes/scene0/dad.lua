local UIObject = require("Lua/module/uiObject")
local Resource = require("Lua/resource").DadBeginning
local GameManager = require("Lua/game")

local Dad = {}

--- @param _parent Scene
function Dad.Get(_parent)
    local dad = UIObject:new("dad", Resource.Dad, _parent.obj, Vector2(880, 840), Vector2(2500, -30))
    local fog = UIObject:new("fog", Resource.Fog, dad.obj, Vector2(2560, 1920), Vector2(0, 0))
    local start = UIObject:new("start", Resource.Start, _parent.obj.Parent, Vector2(1600, 900), Vector2(0, 0))
    dad:SetVisible(true)
    fog:SetVisible(true)
    local function Sync()
        if _parent.player ~= nil then
            if dad.obj.Offset.X - _parent.player.obj.Offset.X < 0 then
                world.OnRenderStepped:Disconnect(Sync)
                _parent:SetVisible(false)
                _parent.bgm:Stop()
                start:SetVisible(true)
            end
        end
    end

    world.OnRenderStepped:Connect(Sync)

    start:SetClickFunc(
        function()
            start:SetVisible(false)
            GameManager.CallFunc("EnterLivingRoom")
        end
    )

    return dad
end

return Dad
