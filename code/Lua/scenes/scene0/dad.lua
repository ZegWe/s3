local UIObject = require("Lua/module/uiObject")
local Resource = require("Lua/resource").DadBeginning
local GameManager = require("Lua/game")

local Dad = {}

--- @param _parent Scene
function Dad.Get(_parent)
    local dad = UIObject:new("dad", Resource.Dad, _parent.obj, Vector2(880, 840), Vector2(2500, -30))
    local fog = UIObject:new("fog", Resource.Fog, dad.obj, Vector2(2560, 1920), Vector2(0, 0))
    local start = UIObject:new("start", Resource.Start, _parent.obj.Parent, Vector2(1600, 900), Vector2(0, 0))
    dad:SetVisible(true)
    fog:SetVisible(true)
    local dis = {-1000, -200, 600, 1400}
    local vis = {0, 0, 0, 0}
    local txt = {
        "每一个英雄故事中，最重要的人物是谁？是英雄吗？",
        "成为英雄，就要为了自己的信念而牺牲。",
        "而父亲……是每个孩子的英雄吗？",
        "成为英雄的代价啊..."
    }
    local function Sync()
        if _parent.player ~= nil then
            for i = 1, 4 do
                if _parent.player.obj.Offset.X > dis[i] and vis[i] == 0 then
                    vis[i] = 1
                    GameManager.ShowTip(txt[i], 5)
                end
            end
            if dad.obj.Offset.X - _parent.player.obj.Offset.X < 0 then
                world.OnRenderStepped:Disconnect(Sync)
                _parent.bgm:Stop()
                GameManager.CallFunc(
                    "FadeOut",
                    2,
                    function()
                        _parent:SetVisible(false)
                        start:SetVisible(true)
                        GameManager.CallFunc(
                            "FadeIn",
                            2,
                            function()
                                start:SetClickFunc(
                                    function()
                                        GameManager.CallFunc(
                                            "FadeOut",
                                            1,
                                            function()
                                                start:SetVisible(false)
                                                _parent.player:ChangeModel("Normal")
                                                GameManager.CallFunc("EnterLivingRoom")
                                                GameManager.CallFunc("FadeIn", 1)
                                            end
                                        )
                                    end
                                )
                            end
                        )
                    end
                )
            end
        end
    end

    world.OnRenderStepped:Connect(Sync)

    return dad
end

return Dad
