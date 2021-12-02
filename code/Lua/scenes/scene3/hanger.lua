local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local AudioPlayer = require("Lua/module/audio")
local HangerImage = require("Lua/resource").Hanger
local InterActive = require("Lua/module/interactive")
local GameManager = require("Lua/game")

local hanger = {}

--- @param _parent Scene
function hanger.Get(_parent)
    local Hanger =
        InterActive:new("hanger", HangerImage.Cloth, HangerImage.Cloth, _parent, Vector2(700, 660), Vector2(-100, -80))
    local Hanger1 =
        InterActive:new(
        "hanger1",
        HangerImage.Hangerstand,
        HangerImage.Hangerstand,
        _parent,
        Vector2(1010, 730),
        Vector2(-145, -85)
    )
    local Hanger2 = UIObject:new("Hanger2", HangerImage.Hangerstand, _parent.obj, Vector2(920, 670), Vector2(-150, -85))

    local animation = Animation:new(Hanger.obj, HangerImage.ClothshakeAni, 0.2)
    Hanger:SetAnimation(animation)
    local animation1 = Animation:new(Hanger1.obj, HangerImage.ClothdownAni, 0.2, true)
    local animation2 = Animation:new(Hanger2.obj, HangerImage.HangerAni, 0.2, true)

    Hanger1:SetVisible(false)
    Hanger2:SetVisible(false)

    Hanger:SetFunc(
        function()
            _parent:RemoveInteractive(Hanger)
            _parent:AddInteractive(Hanger1)
            Hanger:SetVisible(false)
            GameManager.ShowTip("才多大就这么爱臭美？穿得再漂亮也没用，\n看看你长那样吧，再打扮也没用。", 5)
            animation1:Play()
        end
    )

    Hanger1:SetFunc(
        function()
            _parent:RemoveInteractive(Hanger1)
            Hanger1:SetVisible(false)
            Hanger2:SetVisible(true)
            animation2:Play()
        end
    )

    return Hanger
end
return hanger
