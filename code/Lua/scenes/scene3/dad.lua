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

    local door = UIObject:new("door", Resource.Door, _parent.obj, Vector2(350, 60), Vector2(2250, -380))
    door:SetVisible(true)

    local doorOpen =
        Interactive:new(
        "doorOpen",
        Resource.DoorOpen,
        Resource.DoorOpen,
        _parent,
        Vector2(450, 260),
        Vector2(2300, -280)
    )
    doorOpen:SetVisible(false)

    local dad3 =
        Interactive:new("Dad3", Resource.DadFell, Resource.DadFell, _parent, Vector2(930, 840), Vector2(1900, 0))
    dad3:SetVisible(false)
    local animation3 = Animation:new(dad3.obj, Resource.DadFellAni, 0.3, true)

    local function dadRun(_dt)
        if _parent.player ~= nil then
            dad2.obj.Offset = dad2.obj.Offset + Vector2(_dt * -500, 0)
            if dad2.obj.Offset.X - _parent.player.obj.Offset.X < 100 then
                print("caught!")
                animation2:Stop()
                world.OnRenderStepped:Disconnect(dadRun)
                local player = _parent.player
                GameManager.CallFunc("EnterBedRoom")
                player.scene:SetVisible(false)
                wait(1)
                player.scene:SetVisible(true)
                player.scene:Tip("刚刚好像做了什么噩梦……", 5)
                _parent:AddInteractive(dad)
                dad1:SetVisible(false)
                dad2:SetVisible(false)
                dad2.obj.Offset = Vector2(2070, -10)
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

    doorOpen:SetFunc(
        function()
            local player = _parent.player
            GameManager.CallFunc("EnterLivingRoom", Vector2(-750, -115))
            GameManager.PickMemory(2)
            GameManager.CallFunc("ladder")
            player.scene:Tip("父亲，我自由了。", 5)
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
                animation3:Play()
                wait(2)
                dad3:SetVisible(false)
                door:SetVisible(false)
                _parent:AddInteractive(doorOpen)
                doorOpen:SetVisible(true)
            end
        end
    )

    return dad
end

return Dad
