local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local FloatTip = require("Lua/module/floatTip")
local Resource = require("Lua/resource").Paint

local Paint = {}

--- @param _parent Scene
function Paint.Get(_parent)
    local paint = UIObject:new("Paint", Resource.Paint, _parent.obj.Parent, Vector2(1600, 900), Vector2(0, 0))
    local pallete = UIObject:new("Pallete", Resource.Pallete, paint.obj, Vector2(400, 250), Vector2(-550, -330))
    pallete:SetVisible(true)
    local door = UIObject:new("Door", Resource.Door, paint.obj, Vector2(150, 200), Vector2(380, 320))
    local tip = FloatTip:new("", paint.obj, Vector2(0, -325))
    tip:SetClickFunc(
        function()
            tip:SetVisible(false)
        end
    )
    tip:SetVisible(false)

    local paintAnis = {}
    for i = 1, 9 do
        paintAnis[i] = Animation:new(paint.obj, Resource.Stages[i].PaintAni, 0.4, true)
    end

    local doorOpenAni = Animation:new(paint.obj, Resource.DoorOpenAni, 0.4, true)
    local doorAni = Animation:new(paint.obj, Resource.DoorAni, 0.3)

    local stage, count = 1, 0
    local palleteEnabled = true

    local squares, animations, aniPerStage, clicked = {}, {}, {}, {}
    for i = 1, 3 do
        squares[i] = UIObject:new("Square" .. i, Resource.SquareAni[1], paint.obj, Vector2(120, 120), Vector2(0, 0))
        animations[i] = Animation:new(squares[i].obj, Resource.SquareAni, 0.3)
        aniPerStage[i] = {}
        for j = 1, 9 do
            aniPerStage[i][j] = Animation:new(squares[i].obj, Resource.Squares[j], 0.3, true)
        end
        squares[i]:SetClickFunc(
            function()
                if clicked[i] then
                    return
                end
                clicked[i] = true
                wait(0.3)
                animations[i]:Stop()
                aniPerStage[i][stage]:Play()
                count = count + 1
                if count == 3 then
                    wait(1)
                    for i = 1, 3 do
                        squares[i]:SetVisible(false)
                        clicked[i] = false
                    end
                    paintAnis[stage]:Play()
                    tip:SetText(Resource.Tips[stage])
                    tip:SetVisible(true)
                    stage = stage + 1
                    count = 0
                    palleteEnabled = true
                    if stage == 4 then
                        pallete:SetVisible(false)
                        wait(1)
                        paint:SetClickFunc(
                            function()
                                paint:UpdateTexture(Resource.Paints[1])
                                pallete:SetVisible(true)
                                paint:SetClickFunc(nil)
                                tip:SetText(Resource.Tips[10])
                                tip:SetVisible(true)
                            end
                        )
                    elseif stage == 7 then
                        pallete:SetVisible(false)
                        wait(1)
                        paint:SetClickFunc(
                            function()
                                paint:UpdateTexture(Resource.Paints[2])
                                pallete:SetVisible(true)
                                paint:SetClickFunc()
                                tip:SetText(Resource.Tips[11])
                                tip:SetVisible(true)
                            end
                        )
                    elseif stage == 10 then
                        pallete:SetVisible(false)
                        wait(1)
                        paint:SetClickFunc(
                            function()
                                doorOpenAni:Play()
                                tip:SetText(Resource.Tips[12])
                                tip:SetVisible(true)
                                wait(1)
                                doorAni:Play()
                                door:SetVisible(true)
                                door:SetClickFunc(
                                    function()
                                        paint:SetVisible(false)
                                        print("进入阁楼")
                                    end
                                )
                            end
                        )
                    end
                end
            end
        )
    end

    squares[1].obj.Offset = Vector2(-300, 300)
    squares[2].obj.Offset = Vector2(300, 300)
    squares[3].obj.Offset = Vector2(0, 0)

    pallete:SetClickFunc(
        function()
            if palleteEnabled then
                paint:UpdateTexture(Resource.Stages[stage].Paint)
                print("stage " .. stage)
                palleteEnabled = false
                for i = 1, 3 do
                    squares[i]:SetVisible(true)
                    animations[i]:Play()
                end
            end
        end
    )

    return paint
end

return Paint
