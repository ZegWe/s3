local Interactive = require("Lua/module/interactive")
local Animation = require("Lua/module/animation")
local Resource = require("Lua/resource").Ladder
local GameManager = require("Lua/game")

local Ladder = {}

function Ladder.Get(_parent)
    local ladder =
        Interactive:new("ladder", Resource.Ladder, Resource.Ladder, _parent, Vector2(210, 870), Vector2(1300, 15))
    local dad = Interactive:new("dad", Resource.Dad, Resource.Dad, _parent, Vector2(960, 220), Vector2(1300, -370))
    local animation = Animation:new(dad.obj, Resource.DadAni, 0.4, true)
    ladder:SetVisible(false)
    dad:SetVisible(false)

    GameManager.RegisterFunc(
        "ladder",
        function()
            _parent:AddInteractive(ladder)
            _parent:AddInteractive(dad)
        end
    )

    ladder:SetFunc(
        function()
            GameManager.ShowTip("这是一条无法回头的道路。", 5)
        end
    )

    local clicked = false
    dad:SetFunc(
        function()
            if clicked == false then
                clicked = true
                animation:Play(
                    function()
                        dad.ref = Resource.DadAni[4]
                        dad.ref_active = Resource.DadAni[4]
                    end
                )
            end
            GameManager.ShowTip("是成为了《英雄》的父亲。", 5)
        end
    )

    return ladder
end

return Ladder
