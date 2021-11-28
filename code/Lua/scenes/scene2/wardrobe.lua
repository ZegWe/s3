local UIObject = require("Lua/module/uiObject")
local Interactive = require("Lua/module/interactive")
local Animation = require("Lua/module/animation")
local Resource = require("Lua/resource").Wardrobe

local Wardrobe = {}

--- @param _parent Scene
function Wardrobe.Get(_parent)
    --- @type Interactive
    local wardrobe = Interactive:new("Wardrobe", Resource.Wardrobe, Resource.Wardrobe, _parent, Vector2(200,200), Vector2(0,0))
    local animation = Animation:new(wardrobe.obj, Resource.WardrobeAni, 0.3)
    wardrobe:SetAnimation(animation)
    
    local wardrobeUI = UIObject:new("WardrobeUI", Resource.WardrobeUI, _parent.obj.Parent, Vector2(1600,900), Vector2(0,0))

    local shortHand = UIObject:new("shortHand", Resource.ShortClockHand, wardrobeUI.obj, Vector2(30,70), Vector2(-400,0))
    local longHand = UIObject:new("longHand", Resource.LongClockHand, wardrobeUI.obj, Vector2(30,130), Vector2(400,0))


    wardrobeUI:SetClickFunc(function()
        wardrobeUI:SetVisible(false)
        _parent:SetVisible(true)
    end)

    wardrobe:SetFunc(function()
        _parent:SetVisible(false)
        wardrobeUI:SetVisible(true)
    end)

    return wardrobe
end


return Wardrobe