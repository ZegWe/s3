local UIObject = require("Lua/module/uiObject")
local Interactive = require("Lua/module/interactive")
local Animation = require("Lua/module/animation")
local GameManager = require("Lua/game")
local Resource = require("Lua/resource").Easel
local Paint = require("Lua/scenes/scene2/paint")

local Easel = {}

--- @param _parent Scene
function Easel.Get(_parent)
    local easel =
        Interactive:new("Easel", Resource.Easel, Resource.Easel, _parent, Vector2(330, 620), Vector2(1390, -100))
    local animation = Animation:new(easel.obj, Resource.EaselAni, 0.3)
    easel:SetAnimation(animation)

    local bucket = UIObject:new("bucket", Resource.Bucket, easel.obj, Vector2(150, 120), Vector2(-150, -250))
    bucket.obj.RaycastTarget = false
    local canvas = UIObject:new("canvas", Resource.Canvas, easel.obj, Vector2(520, 570), Vector2(-5, 165))
    canvas.obj.RaycastTarget = false
    local pigment = UIObject:new("pigment", Resource.Pigment, easel.obj, Vector2(110, 60), Vector2(150, -300))
    pigment.obj.RaycastTarget = false

    local paint = Paint.Get(_parent)

    world.OnRenderStepped:Connect(
        function()
            if easel.interactive == true and GameManager.ItemGot("Bucket") and GameManager.ItemPlaced("Bucket") == false then
                GameManager.CallFunc("SetItemVisible", "Bucket", true)
            else
                GameManager.CallFunc("SetItemVisible", "Bucket", false)
            end
            if easel.interactive == true and GameManager.ItemGot("Canvas") and GameManager.ItemPlaced("Canvas") == false then
                GameManager.CallFunc("SetItemVisible", "Canvas", true)
            else
                GameManager.CallFunc("SetItemVisible", "Canvas", false)
            end
            if
                easel.interactive == true and GameManager.ItemGot("Pigment") and
                    GameManager.ItemPlaced("Pigment") == false
             then
                GameManager.CallFunc("SetItemVisible", "Pigment", true)
            else
                GameManager.CallFunc("SetItemVisible", "Pigment", false)
            end
        end
    )

    GameManager.RegisterFunc(
        "UpdateEasel",
        function()
            if GameManager.ItemPlaced("Bucket") then
                bucket:SetVisible(true)
            end
            if GameManager.ItemPlaced("Canvas") then
                canvas:SetVisible(true)
            end
            if GameManager.ItemPlaced("Pigment") then
                pigment:SetVisible(true)
            end
        end
    )

    local stage = 1

    GameManager.RegisterFunc(
        "NextStage",
        function()
            stage = stage + 1
        end
    )

    GameManager.RegisterFunc(
        "GetStage",
        function()
            return stage
        end
    )

    easel:SetFunc(
        function()
            if stage == 1 then
                if GameManager.CheckEasel() then
                    _parent:SetVisible(false)
                    _parent.bgm:Stop()
                    paint:SetVisible(true)
                    paint.bgm1:Play()
                else
                    _parent:Tip("好像还缺一些工具才能开始作画。", 5)
                end
            elseif stage == 2 then
                if GameManager.CheckMemory(1) then
                    _parent:SetVisible(false)
                    _parent.bgm:Stop()
                    paint:SetVisible(true)
                    paint.bgm2:Play()
                else
                    _parent:Tip("画作还没有完成，我还没有想起来。", 5)
                end
            elseif stage == 3 then
                if GameManager.CheckMemory(2) then
                    _parent:SetVisible(false)
                    _parent.bgm:Stop()
                    paint:SetVisible(true)
                    paint.bgm3:Play()
                else
                    _parent:Tip("画作还没有完成，我还没有想起来。", 5)
                end
            end
        end
    )

    return easel
end

return Easel
