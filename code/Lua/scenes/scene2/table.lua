local Interactive = require("Lua/module/interactive")
local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local Resource = require("Lua/resource").RoomTable
local GameManager = require("Lua/game")

local Table = {}

--- @param _parent Scene
function Table.Get(_parent)
    local table =
        Interactive:new("Table", Resource.Table, Resource.Table, _parent, Vector2(650, 190), Vector2(-160, -35))
    local tableAni = Animation:new(table.obj, Resource.TableAni, 0.3)
    table:SetAnimation(tableAni)

    local tableInfo =
        UIObject:new("tableInfo", Resource.TableInfo, _parent.obj.Parent, Vector2(1600, 900), Vector2.Zero)
    local newspaperAni = Animation:new(tableInfo.obj, Resource.NewspaperAni, 0.3)
    newspaperAni:Play()

    local back = UIObject:new("back", Resource.Back, tableInfo.obj, Vector2(100, 100), Vector2(650, -350))
    back:SetVisible(true)

    local newspaper = UIObject:new("newspaper", Resource.Newspaper, tableInfo.obj, Vector2(700, 800), Vector2(-250, 0))
    newspaper:SetVisible(true)

    local phone = UIObject:new("phone", Resource.Phone, tableInfo.obj, Vector2(330, 370), Vector2(-455, -125))
    phone:SetVisible(true)
    local phoneAni = Animation:new(phone.obj, Resource.PhoneAni, 0.3)
    phoneAni:Play()

    local drawPaper =
        UIObject:new("drawPaper", Resource.DrawPaper, tableInfo.obj, Vector2(490, 400), Vector2(315, -150))
    drawPaper:SetVisible(true)
    local drawPaperAni = Animation:new(drawPaper.obj, Resource.DrawPaperAni, 0.3)
    drawPaperAni:Play()

    local drawPaperBig =
        UIObject:new("drawPaperBig", Resource.DrawPaperBig, tableInfo.obj, Vector2(1600, 900), Vector2.Zero)

    local count = 0
    newspaper:SetClickFunc(
        function()
            if count == 0 then
                GameManager.ShowTip("x市英雄主题艺术画展在昨日成功举行，据悉此次\n画展本应有一位年轻画家初次亮相，却不知为何被\n警方通报失踪，至今下落不明。其作品究竟如何？", 5)
            elseif count == 1 then
                GameManager.ShowTip("x市实验小学优秀作文展示《我的爸爸》\n我的爸爸是我的英雄，他总是能在我的危难时刻出现，\n保护我………", 5)
            elseif count == 2 and GameManager.CallFunc("GetStage") == 1 then
                GameManager.ShowTip(
                    "《悬案！无人的命案！》当警察发现时，案发现场空无一人，\n只有血迹代表着发生的一切。当警察再次调查时发现了\n藏在阁楼里的尸体死于当日■点■■分，正是画展的开幕时间。",
                    5
                )
            else
                GameManager.ShowTip(
                    "《悬案！无人的命案！》当警察发现时，案发现场空无一人，\n只有血迹代表着发生的一切。当警察再次调查时发现了\n藏在阁楼里的尸体死于当日3点15分，正是画展的开幕时间。",
                    5
                )
            end

            count = (count + 1) % 3
        end
    )

    phone:SetClickFunc(
        function()
            GameManager.ShowTip("您好：\n您的作品已经入选参展，请务必本人携带作品\n在十二点之前送来参展地进行签约和展出。", 5)
        end
    )

    drawPaper:SetClickFunc(
        function()
            GameManager.ShowTip("这是……拿去参展的画作？", 5)
            drawPaperBig:SetVisible(true)
        end
    )

    local clicked = false
    drawPaperBig:SetClickFunc(
        function()
            if clicked == true then
                drawPaperBig:SetVisible(false)

                clicked = false
            else
                GameManager.ShowTip("感觉画面被分成了九个格子……", 5)

                clicked = true
            end
        end
    )

    table:SetFunc(
        function()
            _parent:SetVisible(false)
            tableInfo:SetVisible(true)
            GameManager.ShowTip("当日的报纸……和一部小灵通？", 5)
        end
    )

    back:SetClickFunc(
        function()
            tableInfo:SetVisible(false)
            _parent:SetVisible(true)
        end
    )

    return table
end

return Table
