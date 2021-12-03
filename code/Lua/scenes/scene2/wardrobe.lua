local UIObject = require("Lua/module/uiObject")
local Interactive = require("Lua/module/interactive")
local Animation = require("Lua/module/animation")
local AudioPlayer = require("Lua/module/audio")
local Resource = require("Lua/resource").Wardrobe
local GameManager = require("Lua/game")

local Wardrobe = {}

--- @param _parent Scene
function Wardrobe.Get(_parent)
    --- @type Interactive
    local wardrobe =
        Interactive:new("Wardrobe", Resource.Wardrobe, Resource.Wardrobe, _parent, Vector2(380, 720), Vector2(895, -40))
    local animation = Animation:new(wardrobe.obj, Resource.WardrobeAni, 0.3)
    wardrobe:SetAnimation(animation)

    local wardrobeUI =
        UIObject:new("WardrobeUI", Resource.WardrobeUI, _parent.obj.Parent, Vector2(1600, 900), Vector2(0, 0))

    local unlockSound = AudioPlayer:new("UnlockSound", Resource.UnlockSound, false)
    local rotateSound = AudioPlayer:new("RotateSound", Resource.RotateSound, false)

    local hour, min = 0, 0

    local shortHand =
        UIObject:new("shortHand", Resource.ShortClockHand, wardrobeUI.obj, Vector2(30, 70), Vector2(-445, 15))
    shortHand.obj.Pivot = Vector2(0.5, 1 / 14)
    shortHand:SetVisible(true)

    local shortHandArrowLeft =
        UIObject:new("shortHandArrowLeft", Resource.ArrowLeft, wardrobeUI.obj, Vector2(160, 130), Vector2(-610, -245))
    shortHandArrowLeft:SetVisible(true)

    shortHandArrowLeft:SetClickFunc(
        function()
            rotateSound:Play()
            shortHand.obj.Angle = shortHand.obj.Angle + 30
            hour = (hour - 1) % 12
        end
    )

    local shortHandArrowRight =
        UIObject:new("shortHandArrowRight", Resource.ArrowRight, wardrobeUI.obj, Vector2(160, 130), Vector2(-280, -235))
    shortHandArrowRight:SetVisible(true)

    shortHandArrowRight:SetClickFunc(
        function()
            rotateSound:Play()
            shortHand.obj.Angle = shortHand.obj.Angle - 30
            hour = (hour + 1) % 12
        end
    )

    local longHand =
        UIObject:new("longHand", Resource.LongClockHand, wardrobeUI.obj, Vector2(30, 130), Vector2(445, 15))
    longHand.obj.Pivot = Vector2(0.5, 1 / 26)
    longHand:SetVisible(true)

    local longHandArrowLeft =
        UIObject:new("longHandArrowLeft", Resource.ArrowLeft, wardrobeUI.obj, Vector2(160, 130), Vector2(300, -245))
    longHandArrowLeft:SetVisible(true)

    longHandArrowLeft:SetClickFunc(
        function()
            rotateSound:Play()
            longHand.obj.Angle = longHand.obj.Angle + 30
            min = (min - 5) % 60
        end
    )

    local longHandArrowRight =
        UIObject:new("longHandArrowRight", Resource.ArrowRight, wardrobeUI.obj, Vector2(160, 130), Vector2(630, -235))
    longHandArrowRight:SetVisible(true)

    longHandArrowRight:SetClickFunc(
        function()
            rotateSound:Play()
            longHand.obj.Angle = longHand.obj.Angle - 30
            min = (min + 5) % 60
        end
    )

    local unlocked = false

    local confirm = UIObject:new("confirm", Resource.Confirm, wardrobeUI.obj, Vector2(176, 116), Vector2(0, -340))
    confirm:SetVisible(true)

    local back = UIObject:new("back", Resource.Back, wardrobeUI.obj, Vector2(100, 100), Vector2(650, -350))
    back:SetVisible(true)

    confirm:SetClickFunc(
        function()
            print(hour, min)
            if hour == 3 and min == 15 and GameManager.CallFunc("GetStage") == 2 then
                unlockSound:Play()
                GameManager.CallFunc(
                    "FadeOut",
                    1,
                    function()
                        wardrobeUI:SetVisible(false)
                        GameManager.CallFunc("EnterLoft", Vector2(-1900, -135))
                        unlocked = true
                        wardrobe:SetAnimation(nil)
                        animation:Stop()
                        wardrobe.ref = Resource.WardrobeOpen
                        wardrobe.ref_active = Resource.WardrobeOpen
                        wardrobe:UpdateTexture(Resource.WardrobeOpen)
                        GameManager.CallFunc("FadeIn", 1)
                    end
                )
            else
                GameManager.ShowTip("没反应，可能还不是正确的位置。", 5)
            end
        end
    )

    back:SetClickFunc(
        function()
            wardrobeUI:SetVisible(false)
            _parent:SetVisible(true)
        end
    )

    wardrobe:SetFunc(
        function()
            if unlocked == false then
                _parent:SetVisible(false)
                wardrobeUI:SetVisible(true)
                GameManager.ShowTip("……？这个把手可以旋转？", 5)
            elseif GameManager.CallFunc("GetStage") == 2 and GameManager.CheckMemory(1) then
                GameManager.ShowTip("我需要先把画完成。", 5)
            else
                GameManager.CallFunc(
                    "FadeOut",
                    1,
                    function()
                        GameManager.CallFunc("EnterLoft", Vector2(-1900, -135))
                        GameManager.CallFunc("FadeIn", 1)
                    end
                )
            end
        end
    )

    return wardrobe
end

return Wardrobe
