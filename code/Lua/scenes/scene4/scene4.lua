local Scene = require("Lua/module/scene")
local Interactive = require("Lua/module/interactive")
local Animation = require("Lua/module/animation")
local Resource = require("Lua/resource").End
local GameManager = require("Lua/game")

local module = {}

--- @param _name string
--- @param _parent Canvas
function module:Get(_name, _parent)
    local scene = Scene:new(_name, Resource.Background, _parent, Vector2(6230, 900), Vector2(-2500, -135), Resource.BGM)
    local sofa = Interactive:new("sofa", Resource.Sofa, Resource.Sofa, scene, Vector2(1470, 820), Vector2(2510, -190))
    local sofaAni = Animation:new(sofa.obj, Resource.SofaAni, 0.3)
    sofa:SetAnimation(sofaAni)
    scene:AddInteractive(sofa)

    sofa:SetFunc(
        function()
            print("---------------end")
            GameManager.CallFunc(
                "FadeOut",
                2,
                function()
                    scene:SetVisible(false)
                    scene.bgm:Stop()
                end
            )
        end
    )

    return scene
end

return module
