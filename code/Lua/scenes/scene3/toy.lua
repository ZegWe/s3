local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local FloatTip = require("Lua/module/floatTip")
local AudioPlayer = require("Lua/module/audio")
local ToyImage = require("Lua/resource").Toy
local InterActive = require("Lua/module/interactive")

local toy = {}

--- @param _parent Scene
function toy.Get(_parent)
    local Toy = InterActive:new("toy", ToyImage.Cloth, ToyImage.Cloth, _parent, Vector2(640, 340), Vector2(-1000, -260))
    local animation = Animation:new(Toy.obj, ToyImage.ClothshakeAni, 0.3)
    Toy:SetAnimation(animation)

    local Toy1 =
        InterActive:new("toy1", ToyImage.Cloth, ToyImage.Cloth, _parent, Vector2(640, 640), Vector2(-1000, -140))
    local animation1 = Animation:new(Toy1.obj, ToyImage.ClothdownAni, 0.2, true)
	Toy1:SetVisible(false)

    local Toy2 =
        InterActive:new("toy2", ToyImage.Toystand, ToyImage.Toystand, _parent, Vector2(870, 390), Vector2(-1095, -225))
    local animation2 = Animation:new(Toy2.obj, ToyImage.ToyrunAni, 0.2, true)
	Toy2:SetVisible(false)

    Toy1:SetVisible(false)
    Toy2:SetVisible(false)

    Toy:SetFunc(
        function()
            _parent:RemoveInteractive(Toy)
            _parent:AddInteractive(Toy1)
            Toy:SetVisible(false)
            _parent:Tip("你都这么大了还玩这种小孩子的玩具，\n应该像所有懂事的女孩一样多做做家务", 5)
            Toy1:SetVisible(true)
            animation1:Play()
        end
    )

    Toy1:SetFunc(
        function()
            _parent:RemoveInteractive(Toy1)
            Toy1:SetVisible(false)
            Toy2:SetVisible(true)
            animation2:Play()
			wait(1)
			Toy2:SetVisible(false)
        end
    )

    return Toy
end

return toy
