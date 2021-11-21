local Interactive = require("Lua/module/interactive")
local Animation = require("Lua/module/animation")
local GameManager = require("Lua/game")
local UIObject = require("Lua/module/uiObject")
local DoorImage = require("Lua/resource").MainDoor

--- 正门
local MainDoor = {}

--- @param _parent Scene
function MainDoor.Get(_parent)
    --- @type Interactive
    local door =
        Interactive:new("MainDoor", DoorImage.Door, DoorImage.Door, _parent, Vector2(420, 730), Vector2(1305, -25), nil)
    local animation = Animation:new(door.obj, DoorImage.DoorShake, 0.1, true)
    local Maoyan = UIObject:new("Maoyan", DoorImage.Maoyan, _parent.obj.Parent, Vector2(1600, 900), Vector2.Zero)
    local maoyanAni = Animation:new(Maoyan.obj, DoorImage.MaoyanAni, 0.4, true)
    local aniPlayed = false
    Maoyan:SetClickFunc(
        function()
            Maoyan:SetVisible(false)
            _parent:SetVisible(true)
        end
    )
    door:SetFunc(
        function()
            if GameManager.MirrorChecked() then
                _parent:SetVisible(false)
                if not aniPlayed then
                    maoyanAni:Play()
                    aniPlayed = true
                end
                Maoyan:SetVisible(true)
            else
                print("door shake")
                animation:Play()
                _parent:Tip("门打不开……", 5)
            end
        end
    )
    return door
end

return MainDoor
