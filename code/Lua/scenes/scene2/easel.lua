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
    local animationWithBucket = Animation:new(easel.obj, Resource.EaselWithBucketAni, 0.3)
    local animationWithCanvas = Animation:new(easel.obj, Resource.EaselWithCanvasAni, 0.3)
    local animationWithPigment = Animation:new(easel.obj, Resource.EaselWithPigmentAni, 0.3)
    local animationWithBucketAndCanvas = Animation:new(easel.obj, Resource.EaselWithBucketAndCanvasAni, 0.3)
    local animationWithBucketAndPigment = Animation:new(easel.obj, Resource.EaselWithBucketAndPigmentAni, 0.3)
    local animationWithCanvasAndPigment = Animation:new(easel.obj, Resource.EaselWithCanvasAndPigmentAni, 0.3)
    local animationWithBucketCanvasAndPigment =
        Animation:new(easel.obj, Resource.EaselWithBucketCanvasAndPigmentAni, 0.3)
    easel:SetAnimation(animation)

    local paint = Paint.Get(_parent)

    world.OnRenderStepped:Connect(function()
        if easel.interactive == true and GameManager.ItemGot("Bucket") and GameManager.ItemPlaced("Bucket") == false then
            GameManager.CallFunc("SetItemVisible","Bucket", true)
        else
            GameManager.CallFunc("SetItemVisible","Bucket", false)
        end
        if easel.interactive == true and GameManager.ItemGot("Canvas") and GameManager.ItemPlaced("Canvas") == false then
            GameManager.CallFunc("SetItemVisible","Canvas", true)
        else
            GameManager.CallFunc("SetItemVisible","Canvas", false)
        end
        if easel.interactive == true and GameManager.ItemGot("Pigment") and GameManager.ItemPlaced("Pigment") == false then
            GameManager.CallFunc("SetItemVisible","Pigment", true)
        else
            GameManager.CallFunc("SetItemVisible","Pigment", false)
        end
    end)

    GameManager.RegisterFunc(
        "UpdateEasel",
        function()
            if
                GameManager.ItemPlaced("Bucket") and GameManager.ItemPlaced("Canvas") and
                    GameManager.ItemPlaced("Pigment")
             then
                easel:SetAnimation(animationWithBucketCanvasAndPigment)
            elseif GameManager.ItemPlaced("Bucket") and GameManager.ItemPlaced("Canvas") then
                easel:SetAnimation(animationWithBucketAndCanvas)
            elseif GameManager.ItemPlaced("Bucket") and GameManager.ItemPlaced("Pigment") then
                easel:SetAnimation(animationWithBucketAndPigment)
            elseif GameManager.ItemPlaced("Canvas") and GameManager.ItemPlaced("Pigment") then
                easel:SetAnimation(animationWithCanvasAndPigment)
            elseif GameManager.ItemPlaced("Bucket") then
                easel:SetAnimation(animationWithBucket)
            elseif GameManager.ItemPlaced("Canvas") then
                easel:SetAnimation(animationWithCanvas)
            elseif GameManager.ItemPlaced("Pigment") then
                easel:SetAnimation(animationWithPigment)
            else
                easel:SetAnimation(animation)
            end
        end
    )

    easel:SetFunc(
        function()
            if GameManager.CheckEasel() then
                _parent:SetVisible(false)
                paint:SetVisible(true)
            else
                _parent:Tip("好像还缺一些工具才能开始作画。", 5)
            end
        end
    )

    return easel
end

return Easel
