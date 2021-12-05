local Interactive = require("Lua/module/interactive")
local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local AudioPlayer = require("Lua/module/audio")
local Resource = require("Lua/resource").Dad
local GameManager = require("Lua/game")

local Dad = {}

--- @param _parent Scene
function Dad.Get(_parent)
    local door = UIObject:new("door", Resource.Door, _parent.obj, Vector2(350, 60), Vector2(2250, -380))
    door:SetVisible(true)

    local dad = Interactive:new("Dad", Resource.Dad, Resource.Dad, _parent, Vector2(730, 480), Vector2(2000, -200))
    local animation = Animation:new(dad.obj, Resource.DadAni, 0.3)
    dad:SetAnimation(animation)

    local dad1 = UIObject:new("Dad1", Resource.DadStand, _parent.obj, Vector2(880, 840), Vector2(2045, -20))
    local animation1 = Animation:new(dad1.obj, Resource.DadStandAni, 0.3, true)

    local dad2 = UIObject:new("Dad2", Resource.DadRun, _parent.obj, Vector2(1150, 900), Vector2(2070, -10))
    local animation2 = Animation:new(dad2.obj, Resource.DadRunAni, 0.2)

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

    local tip = UIObject:new("tip", Resource.Tip, dad3.obj, Vector2(130, 270), Vector2(-450, 0))
    local tipAnimation = Animation:new(tip.obj, Resource.TipAni, 0.1)

    local progress = UIObject:new("progress", Resource.Progress[1], tip.obj, Vector2(160, 50), Vector2(100, 350))
    progress:SetVisible(true)
    local function update(_cnt)
        progress:UpdateTexture(Resource.Progress[math.floor(_cnt / 2) + 1])
    end

    local lock = Interactive:new("lock", Resource.Lock, Resource.Lock, _parent, Vector2(170, 60), Vector2(-1975, -100))
    local ticket =
        Interactive:new("ticket", Resource.Ticket, Resource.Ticket, _parent, Vector2(70, 40), Vector2(-1500, -110))
    local blood =
        Interactive:new("blood", Resource.Blood, Resource.Blood, _parent, Vector2(120, 380), Vector2(300, -60))
    local guizi = UIObject:new("guizi", Resource.Guizi, _parent.obj, Vector2(430, 280), Vector2(-1500, -270))
    lock:SetVisible(false)
    blood:SetVisible(false)
    ticket:SetVisible(false)

    local function show_interactive()
        _parent:AddInteractive(lock)
        _parent:AddInteractive(ticket)
        _parent:AddInteractive(blood)
        guizi:SetVisible(true)
        lock:SetVisible(true)
        blood:SetVisible(true)
        ticket:SetVisible(true)
    end
    lock:SetFunc(
        function()
            GameManager.ShowTip("爸爸看到了我手里的门票，然后把我关在了这里。\n马上就是画展开幕的时候了……", 5)
        end
    )
    blood:SetFunc(
        function()
            GameManager.ShowTip("在黑暗的阁楼里我只能感受到爸爸抓着我，\n有什么液体从我的头上流下来……", 5)
        end
    )
    ticket:SetFunc(
        function()
            GameManager.ShowTip("要去画展了要去画展了——我已经\n准备好门票和画作了！", 5)
        end
    )

    local fallSound = AudioPlayer:new("fallSound", Resource.FallSound, false)
    local bgm = AudioPlayer:new("bgm", Resource.bgm, true)

    local tt = 0
    local times = {1, 2, 3, 4, 5, 6}
    local vis = {false, false, false, false, false, false}
    local txt = {
        "爸爸都是为了你好！！为什么？为什么不听爸爸的话？",
        "爸爸，你的爱让我窒息……",
        "爸爸只是想保护你，你必须得乖乖地待在家里才行……",
        "可是我已经长大了，爸爸。",
        "不许出去！什么乱七八糟的画展！有什么用！？",
        "爸爸，那是我的梦想啊。"
    }

    local function dadRun(_dt)
        tt = tt + _dt
        for i = 1, 6 do
            if tt > times[i] and not vis[i] then
                vis[i] = true
                GameManager.ShowTip(txt[i], 2)
            end
        end

        if _parent.player ~= nil then
            dad2.obj.Offset = dad2.obj.Offset + Vector2(_dt * -550, 0)
            if dad2.obj.Offset.X - _parent.player.obj.Offset.X < 100 then
                print("caught!")
                animation2:Stop()
                world.OnRenderStepped:Disconnect(dadRun)
                GameManager.CallFunc(
                    "FadeOut",
                    1,
                    function()
                        GameManager.CallFunc("EnterBedRoom")
                        GameManager.ShowTip("刚刚好像做了什么噩梦，要再回去看看吗？", 5)
                        GameManager.CallFunc("cabinet", false)
                        _parent:AddInteractive(dad)
                        dad:SetVisible(true)
                        dad1:SetVisible(false)
                        dad2:SetVisible(false)
                        dad2.obj.Offset = Vector2(2070, -10)
                        bgm:Stop()
                        GameManager.CallFunc("FadeIn", 1)
                    end
                )
            end
        end
    end

    local function sync()
        if _parent.player.obj.Offset.X > 1500 then
            world.OnRenderStepped:Disconnect(sync)
            _parent.player:EnableControl(false)
            _parent:RemoveInteractive(dad)
            dad:SetVisible(false)
            dad1:SetVisible(true)
            GameManager.ShowTip("父亲……！？", 5)
            animation1:Play()
            wait(2)
            dad2:SetVisible(true)
            GameManager.ShowTip("获得了记忆碎片，快逃！", 1)
            _parent.bgm:Stop()
            bgm:Play()
            GameManager.CallFunc("cabinet", true)
            wait(1)
            animation2:Play()
            tt = 0
            vis = {false, false, false, false, false, false}
            world.OnRenderStepped:Connect(dadRun)
            _parent.player:EnableControl(true)
        end
    end

    local function click()
        local cnt = 0
        dad3:SetClickFunc(
            function()
                cnt = cnt + 1
                update(cnt)
            end
        )
        tip:SetVisible(true)
        tipAnimation:Play()
        while wait(0.5) do
            if cnt > 10 then
                break
            end
            cnt = math.max(0, cnt - 1)
            update(cnt)
        end
        dad3:SetFunc(nil)
        tip:SetVisible(false)
        tipAnimation:Stop()
    end

    local function sync2()
        if _parent.player.obj.Offset.X > 1300 then
            world.OnRenderStepped:Disconnect(sync2)
            _parent.player:EnableControl(false)
            GameManager.ShowTip("他看起来像一尊雕塑……为什么不动了？", 5)
            wait(2)
            GameManager.ShowTip("我要……摆脱这一切。", 5)
            wait(2)
            GameManager.ShowTip("父亲你不能再阻止我了", 5)
            click()
            animation3:Play(
                function()
                    _parent:RemoveInteractive(dad3)
                    dad3:SetVisible(false)
                    door:SetVisible(false)
                    _parent:AddInteractive(doorOpen)
                    doorOpen:SetVisible(true)
                    fallSound:Play()
                    GameManager.ShowTip("……他掉下去了，爸爸……", 5)
                    _parent.player:EnableControl(true)
                end
            )
        end
    end

    GameManager.RegisterFunc(
        "dad_interactive",
        function()
            print("dad_interactive", GameManager.CallFunc("GetStage"))
            if GameManager.CallFunc("GetStage") == 2 then
                world.OnRenderStepped:Connect(sync)
            elseif GameManager.CallFunc("GetStage") == 3 and GameManager.CheckMemory(2) == false then
                show_interactive()
                world.OnRenderStepped:Connect(sync2)
            end
        end
    )

    GameManager.RegisterFunc(
        "escape",
        function()
            if GameManager.CallFunc("GetStage") == 3 then
                return
            end
            if world.OnRenderStepped:HasConnected(dadRun) then
                world.OnRenderStepped:Disconnect(dadRun)
            end
            animation2:Stop()
            invoke(
                function()
                    wait(1)
                    dad2:SetVisible(false)
                    _parent:AddInteractive(dad3)
                    dad3:SetVisible(true)
                    bgm:Stop()
                    GameManager.PickMemory(1)
                    GameManager.CallFunc("ChangeLoft", 2)
                end
            )
        end
    )

    doorOpen:SetFunc(
        function()
            local player = _parent.player
            GameManager.CallFunc(
                "FadeOut",
                1,
                function()
                    GameManager.CallFunc("EnterLivingRoom", Vector2(1300, -135))
                    GameManager.PickMemory(2)
                    GameManager.CallFunc("ladder")
                    GameManager.ShowTip("父亲，我自由了。", 5)
                    GameManager.CallFunc("ChangeLoft", 3)
                    GameManager.CallFunc("FadeIn", 1)
                end
            )
        end
    )

    return dad
end

return Dad
