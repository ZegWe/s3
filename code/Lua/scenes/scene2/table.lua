local Interactive = require("Lua/module/interactive")
local UIObject = require("Lua/module/uiObject")
local FloatTip = require("Lua/module/floatTip")
local Resource = require("Lua/resource").RoomTable

local Table = {}

--- @param _parent Scene
function Table.Get(_parent)
    local table = Interactive:new("Table", Resource.Table, Resource.Table, _parent, Vector2(420, 720), Vector2.Zero)

    local tableInfo =
        UIObject:new("tableInfo", Resource.TableInfo, _parent.obj.Parent, Vector2(1600, 900), Vector2.Zero)

    local tip = FloatTip:new("", tableInfo.obj, Vector2(0, -325))

    local newspaper1 =
        UIObject:new("newspaper1", Resource.Newspaper1, tableInfo.obj, Vector2(300, 300), Vector2(-300, 200))

    local newspaper2 =
        UIObject:new("newspaper2", Resource.Newspaper2, tableInfo.obj, Vector2(300, 300), Vector2(300, 200))

    local newspaper3 =
        UIObject:new("newspaper3", Resource.Newspaper3, tableInfo.obj, Vector2(300, 300), Vector2(0, -200))

    local phone = UIObject:new("phone", Resource.Phone, tableInfo.obj, Vector2(300, 300), Vector2(-300, -200))

    local drawPaper =
        UIObject:new("drawPaper", Resource.DrawPaper, tableInfo.obj, Vector2(300, 300), Vector2(300, -200))

    tip:SetClickFunc(
        function()
            tip:SetVisible(false)
        end
    )

    newspaper1:SetClickFunc(
        function()
            tip:SetText("x市英雄主题艺术画展将在明日举行，据悉此次画展将有一位年轻画家的作品初次参展，业内议论纷纷，年轻艺术家备受期待。")
            tip:SetVisible(true)
        end
    )

    newspaper2:SetClickFunc(
        function()
            tip:SetText("x市实验小学优秀作文展示《我的爸爸》我的爸爸是我的英雄，他总是能在我的危难时刻出现，保护我………")
            tip:SetVisible(true)
        end
    )

    newspaper3:SetClickFunc(
        function()
            tip:SetText("《悬案！无人的命案，相依为命的父女一夜间双双失踪》当警察发现时，案发现场空无一人，只有血迹代表着发生的一切。")
            tip:SetVisible(true)
        end
    )

    phone:SetClickFunc(
        function()
            tip:SetText("您好：您的作品已经入选参展，请务必本人携带作品在十二点之前送来参展地进行签约和展出。")
            tip:SetVisible(true)
        end
    )

    drawPaper:SetClickFunc(
        function()
            tip:SetText("这是……拿去参展的画作？")
            tip:SetVisible(true)
        end
    )

    table:SetFunc(
        function()
            _parent:SetVisible(false)
            tableInfo:SetVisible(true)
            tip:SetText("当日的报纸……和一部小灵通？")
            tip:SetVisible(true)
        end
    )

    tableInfo:SetClickFunc(
        function()
            tableInfo:SetVisible(false)
            _parent:SetVisible(true)
        end
    )

    return table
end

return Table
