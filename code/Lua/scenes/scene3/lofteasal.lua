local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local FloatTip = require("Lua/module/floatTip")
local AudioPlayer = require("Lua/module/audio")
local EasalImage = require("Lua/resource").Lofteasal
local InterActive = require("Lua/module/interactive")

local easal = {}

--- @param _parent Scene
function easal.Get(_parent)
    local Easal =
        InterActive:new("Easal", EasalImage.Cloth, EasalImage.Cloth, _parent, Vector2(360, 650), Vector2(850, -80))
    local Easal1 =
        InterActive:new(
        "Easal1",
        EasalImage.Lofteasalstand,
        EasalImage.Lofteasalstand,
        _parent,
        Vector2(670, 770),
        Vector2(765, -45)
    )
    local Easal2 = UIObject:new("Easal2", EasalImage.Lofteasalstand, _parent.obj, Vector2(570, 810), Vector2(815, -15))

    local animation = Animation:new(Easal.obj, EasalImage.ClothshakeAni, 0.2)
    Easal:SetAnimation(animation)
    local animation1 = Animation:new(Easal1.obj, EasalImage.ClothdownAni, 0.2, true)
    local animation2 = Animation:new(Easal2.obj, EasalImage.LofteasaldownAni, 0.2, true)

    Easal1:SetVisible(false)
    Easal2:SetVisible(false)

    Easal:SetFunc(
        function()
            _parent:RemoveInteractive(Easal)
            _parent:AddInteractive(Easal1)
            Easal:SetVisible(false)
            _parent:Tip("你又没有天赋，成天搞这些不正经的事做什么，\n就不能听爸爸的话好好学习吗？", 5)
            animation1:Play()
        end
    )

    Easal1:SetClickFunc(
        function()
            _parent:RemoveInteractive(Easal1)
            Easal1:SetVisible(false)
            Easal2:SetVisible(true)
            animation2:Play()
        end
    )
    return Easal
end

return easal
