local Interactive = require("Lua/module/interactive")
local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local Resource = require("Lua/resource").Dad
local GameManager = require("Lua/game")

local Dad = {}

--- @param _parent Scene
function Dad.Get(_parent)
    local dad = Interactive:new("Dad", Resource.Dad, Resource.Dad, _parent, Vector2(730, 480), Vector2(2000, -200))
    local animation = Animation:new(dad.obj, Resource.DadAni, 0.3)
    dad:SetAnimation(animation)

    local dad1 = UIObject:new("Dad1", Resource.DadStand, _parent.obj, Vector2(880, 840), Vector2(2045, -20))
    local animation1 = Animation:new(dad1.obj, Resource.DadStandAni, 0.3, true)

    local dad2 = UIObject:new("Dad2", Resource.DadRun, _parent.obj, Vector2(1150, 900), Vector2(2070, -10))
    local animation2 = Animation:new(dad2.obj, Resource.DadRunAni, 0.2)

    local dad3 =
        Interactive:new("Dad3", Resource.DadRun, Resource.DadRun, _parent, Vector2(730, 480), Vector2(2000, -200))
    dad3:SetVisible(false)

    local door = Interactive:new("door", Resource.Door, Resource.Door, _parent, Vector2(730, 480), Vector2(2200, -200))
    _parent:AddInteractive(door)

    local function dadRun(_dt)
        if _parent.player ~= nil then
            dad2.obj.Offset = dad2.obj.Offset + Vector2(_dt * -500, 0)
            if dad2.obj.Offset.X - _parent.player.obj.Offset.X < 100 then
                print("caught!")
                animation2:Stop()
                world.OnRenderStepped:Disconnect(dadRun)
                _parent:Tip("被抓住了！", 1)
                wait(1)
                GameManager.CallFunc("EnterBedRoom")
                _parent:AddInteractive(dad)
                dad1:SetVisible(false)
                dad2:SetVisible(false)
                dad2.obj.Offset = Vector2(2070, -10)
                _parent.enterPos = Vector2(-1900, -115)
            end
        end
    end

    dad:SetFunc(
        function()
            _parent:RemoveInteractive(dad)
            dad:SetVisible(false)
            dad1:SetVisible(true)
            animation1:Play()
            wait(2)
            dad2:SetVisible(true)
            _parent:Tip("获得了记忆碎片，快逃！", 1)
            GameManager.CallFunc("cabinet")
            wait(1)
            animation2:Play()
            world.OnRenderStepped:Connect(dadRun)
        end
    )

    GameManager.RegisterFunc(
        "escape",
        function()
            world.OnRenderStepped:Disconnect(dadRun)
            animation2:Stop()
            dad2:SetVisible(false)
            _parent:AddInteractive(dad3)
        end
    )

    local doorOpen = false

    door:SetFunc(
        function()
            if doorOpen then
                GameManager.CallFunc("EnterLivingRoom")
            end
        end
    )

    local cnt = 0
    dad3:SetFunc(
        function()
            if cnt == 0 then
                _parent:Tip("他看起来像一尊雕塑……为什么不动了？", 5)
                cnt = cnt + 1
            elseif cnt == 1 then
                _parent:Tip("只要把他推下去……这一切就可以结束了。", 5)
                cnt = cnt + 1
            elseif cnt == 2 then
                _parent:Tip("成为英雄，就要为了自己的信念而牺牲。", 5)
                cnt = cnt + 1
                doorOpen = true
                door:UpdateTexture(Resource.DoorOpen)
            end
        end
    )

    return dad
end

return Dad
