local Scene = require("Lua/module/scene")
local UIObject = require("Lua/module/uiObject")
local Hanger = require("Lua/scenes/scene3/hanger")
local Loft = require("Lua/scenes/scene3/loft")
local Lofteasal = require("Lua/scenes/scene3/lofteasal")
local Resource = require("Lua/resource").Loft
local Toy = require("Lua/scenes/scene3/toy")
local Dad = require("Lua/scenes/scene3/dad")
local Cabinet = require("Lua/scenes/scene3/cabinet")
local GameManager = require("Lua/game")

local module = {}

--- @param _name string
--- @param _parent Canvas
function module:Get(_name, _parent)
    local scene = Scene:new(_name, Resource.Background, _parent, Vector2(5070, 900), Vector2(-1900, -135), Resource.BGM)

    scene:AddInteractive(Hanger.Get(scene))
    -- scene:AddInteractive(Loft.Get(scene))
    scene:AddInteractive(Lofteasal.Get(scene))
    scene:AddInteractive(Toy.Get(scene))
    scene:AddInteractive(Dad.Get(scene))
    scene:AddInteractive(Cabinet.Get(scene))

    scene.foreground =
        UIObject:new("foreground", Resource.Foreground, scene.obj, Vector2(3610, 260), Vector2(-730, -320))
    scene.foreground.obj.RaycastTarget = false
    scene.foreground:SetVisible(true)

    GameManager.RegisterFunc(
        "ChangeLoft",
        function(_stage)
            if _stage == 2 then
                scene:UpdateTexture(Resource.Background2)
                scene.foreground:UpdateTexture(Resource.Foreground2)
            elseif _stage == 3 then
                scene:UpdateTexture(Resource.Background3)
                scene.foreground:UpdateTexture(Resource.Foreground3)
            end
        end
    )

    return scene
end

return module
