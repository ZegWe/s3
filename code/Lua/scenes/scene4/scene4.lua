local Scene = require("Lua/module/scene")
local Interactive = require("Lua/module/interactive")
local Animation = require("Lua/module/animation")
local UIObject = require("Lua/module/uiObject")
local Resource = require("Lua/resource").End
local GameManager = require("Lua/game")

local module = {}

--- @param _name string
--- @param _parent Canvas
function module:Get(_name, _parent)
    local scene = Scene:new(_name, Resource.Background, _parent, Vector2(6230, 900), Vector2(-2500, -115), Resource.BGM)
    local sofa = Interactive:new("sofa", Resource.Sofa, Resource.Sofa, scene, Vector2(1470, 820), Vector2(2510, -190))
    local sofaAni = Animation:new(sofa.obj, Resource.SofaAni, 0.3)
    sofa:SetAnimation(sofaAni)
    scene:AddInteractive(sofa)
    local player = UIObject:new("player", Resource.Player, scene.obj, Vector2(510, 600), Vector2(2510, -130))
    local animation = Animation:new(player.obj, Resource.PlayerAni, 0.5, true)

    local ending = UIObject:new("ending", Resource.EndingAni[1], _parent.obj, Vector2(1600, 800), Vector2(0, 0))
    local endingAni = Animation:new(ending.obj, Resource.EndingAni, 0.25)

    local clickable = true
    sofa:SetFunc(
        function()
            if clickable then
                clickable = false
                print("---------------end")
                GameManager.ShowTip("爸爸……你还能做我的英雄吗？", 5)
                scene.player:EnableControl(false)
                -- scene.player.camera.focus = sofa.obj.Offset.X
                scene.player:ForceMove(2525)
                wait(1.5)
                scene.player:SetVisible(false)
                player:SetVisible(true)
                animation:Play(
                    function()
                        GameManager.CallFunc(
                            "FadeOut",
                            2,
                            function()
                                scene:SetVisible(false)
                                ending:SetVisible(true)
                                endingAni:Play()
                                GameManager.CallFunc("FadeIn", 1)
                            end
                        )
                    end
                )
            end
        end
    )

    scene.filter = UIObject:new("filter", Resource.Filter, scene.obj, Vector2(6230, 900), Vector2(0, 0))
    scene.filter:SetVisible(true)
    scene.filter.obj.RaycastTarget = false

    return scene
end

return module
