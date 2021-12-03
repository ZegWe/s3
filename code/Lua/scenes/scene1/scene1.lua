local Scene = require("Lua/module/scene")
local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local Resource = require("Lua/resource").Scene1
local MainDoor = require("Lua/scenes/scene1/mainDoor")
local Mirror = require("Lua/scenes/scene1/mirror")
local Bucket = require("Lua/scenes/scene1/bucket")
local Canvas = require("Lua/scenes/scene1/canvas")
local Lock = require("Lua/scenes/scene1/lock")
local Photo = require("Lua/scenes/scene1/photo")
local Calendar = require("Lua/scenes/scene1/calendar")
local Draw = require("Lua/scenes/scene1/draw")
local Ladder = require("Lua/scenes/scene1/ladder")
local GameManager = require("Lua/game")

local module = {}

--- @param _name string
--- @param _parent Canvas
function module:Get(_name, _parent)
    --- @type Scene
    local scene = Scene:new(_name, Resource.All, _parent, Vector2(3290, 900), Vector2(0, -135), Resource.BGM)

    Draw.Get(scene)
    scene:AddInteractive(MainDoor.Get(scene))
    scene:AddInteractive(Mirror.Get(scene))
    scene:AddInteractive(Bucket.Get(scene))
    scene:AddInteractive(Canvas.Get(scene))
    scene:AddInteractive(Lock.Get(scene))
    scene:AddInteractive(Photo.Get(scene))
    scene:AddInteractive(Calendar.Get(scene))
    Ladder.Get(scene)
    local player = UIObject:new("player", Resource.Player, scene.obj, Vector2(510, 600), Vector2(-10, -150))
    player:SetVisible(true)
    local animation = Animation:new(player.obj, Resource.PlayerAni, 0.5, true)
    GameManager.RegisterFunc(
        "PlayerStand",
        function()
            scene.player:SetVisible(false)
            scene.player.facing = "Right"
            scene.player:EnableControl(false)
            animation:Play(
                function()
                    player:SetVisible(false)
                    scene.player:SetVisible(true)
                    scene.player:EnableControl(true)
                end
            )
        end
    )
    return scene
end

return module
