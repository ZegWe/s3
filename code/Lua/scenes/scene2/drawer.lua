local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local AudioPlayer = require("Lua/module/audio")
local InterActive = require("Lua/module/interactive")
local GameManager = require("Lua/game")
local Resource = require("Lua/resource").Drawer

--书柜抽屉

local drawer = {}

--- @param _parent Scene
function drawer.Get(_parent)
    local bookdrawer =
        InterActive:new(
        "bookdrawer",
        Resource.Bookshelf,
        Resource.Bookshelf,
        _parent,
        Vector2(370, 220),
        Vector2(420, -270)
    )
    local animation = Animation:new(bookdrawer.obj, Resource.BookshelfAni, 0.3)
    bookdrawer:SetAnimation(animation)

    local lock = UIObject:new("lock", Resource.Lock, _parent.obj.Parent, Vector2(1600, 900), Vector2.Zero)

    local drawer = UIObject:new("drawer", Resource.Drawer, _parent.obj.Parent, Vector2(1600, 900), Vector2.Zero)
    local drawerAni = Animation:new(drawer.obj, Resource.DrawerAni, 0.2)

    local back = UIObject:new("back", Resource.Back, lock.obj, Vector2(100, 100), Vector2(650, -350))
    back:SetVisible(true)

    local back1 = UIObject:new("back1", Resource.Back, drawer.obj, Vector2(100, 100), Vector2(650, -350))
    back1:SetVisible(true)

    local buttonPressSound = AudioPlayer:new("buttonPress", Resource.ButtonPressSound, false)
    local unlockSound = AudioPlayer:new("unlock", Resource.UnlockSound, false)

    local blocks = {}
    blocks[1] = UIObject:new("b1", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(-285, 260))
    blocks[2] = UIObject:new("b2", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(5, 260))
    blocks[3] = UIObject:new("b3", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(295, 260))
    blocks[4] = UIObject:new("b4", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(-280, 0))
    blocks[5] = UIObject:new("b5", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(5, 0))
    blocks[6] = UIObject:new("b6", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(295, 0))
    blocks[7] = UIObject:new("b7", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(-280, -260))
    blocks[8] = UIObject:new("b8", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(5, -260))
    blocks[9] = UIObject:new("b9", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(295, -260))

    local confirm = UIObject:new("confirm", Resource.ButtonConfirm, lock.obj, Vector2(190, 150), Vector2(635, 0))

    confirm:SetVisible(true)
    local sum = 0
    local pressed = {0, 0, 0, 0, 0, 0, 0, 0, 0}
    local pow = {1, 2, 4, 8, 16, 32, 64, 128, 256}
    local unlocked = false

    for i, v in ipairs(blocks) do
        v:SetVisible(true)
        v:SetClickFunc(
            function()
                buttonPressSound:Play()
                if pressed[i] == 0 then
                    blocks[i]:UpdateTexture(Resource.BlackBlock)
                    pressed[i] = 1
                    sum = sum + pow[i]
                elseif pressed[i] == 1 then
                    blocks[i]:UpdateTexture(Resource.WhiteBlock)
                    pressed[i] = 0
                    sum = sum - pow[i]
                end
            end
        )
    end

    local picked = false
    drawer:SetClickFunc(
        function()
            if picked == false then
                picked = true
                GameManager.GetPigment()
                GameManager.ShowTip("拿到了【颜料】", 5)
                drawerAni:Stop()
                wait(0.1)
                drawer:UpdateTexture(Resource.EmptyDrawer)
            else
                GameManager.ShowTip("抽屉已经空了", 5)
            end
        end
    )

    back:SetClickFunc(
        function()
            lock:SetVisible(false)
            _parent:SetVisible(true)
        end
    )

    back1:SetClickFunc(
        function()
            GameManager.ShowTip("", 0)
            drawer:SetVisible(false)
            _parent:SetVisible(true)
        end
    )

    confirm:SetClickFunc(
        function()
            if sum == 439 then
                GameManager.ShowTip("抽屉开了", 5)
                unlocked = true
                lock:SetVisible(false)
                drawer:SetVisible(true)
                unlockSound:Play()
                drawerAni:Play()
            else
                GameManager.ShowTip("好像不太对……", 5)
            end
        end
    )

    bookdrawer:SetFunc(
        function()
            _parent:SetVisible(false)
            if unlocked == false then
                lock:SetVisible(true)
                GameManager.ShowTip("黑白格子……？好像可以根据见过的黑白印象来填色？", 5)
            else
                drawer:SetVisible(true)
            end
        end
    )
    return bookdrawer
end
return drawer
