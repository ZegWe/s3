local Interactive = require("Lua/module/interactive")
local Animation = require("Lua/module/animation")
local Resource = require("Lua/resource").Ladder
local GameManager = require("Lua/game")

local Ladder = {}

function Ladder.Get(_parent)
    local ladder =
        Interactive:new("ladder", Resource.Ladder, Resource.Ladder, _parent, Vector2(210, 870), Vector2(-600, 15))
    local dad = Interactive:new("dad", Resource.Dad, Resource.Dad, _parent, Vector2(960, 220), Vector2(-600, -370)) 
    local animation = Animation:new(dad.obj, Resource.DadAni, 0.4)
    dad:SetAnimation(animation)
    ladder:SetVisible(false)
    dad:SetVisible(false)

    GameManager.RegisterFunc(
        "ladder",
        function()
            _parent:AddInteractive(ladder)
            _parent:AddInteractive(dad)
        end
    )

    ladder:SetFunc(function()
        _parent:Tip("这是一条无法回头的道路。", 5)
    end)

    dad:SetFunc(function()
        _parent:Tip("是成为了《英雄》的父亲。", 5)
    end)


    return ladder
end

return Ladder
