local UIObject = require("Lua/module/uiObject")
local Resource = require("Lua/resource").Paint

local Paint = {}

--- @param _parent Scene
function Paint.Get(_parent)
    local paint = UIObject:new("Paint", Resource.Paint, _parent.obj.Parent, Vector2(0, 0), Vector2(0, 0))
    local stages = {}
    stages[1] = UIObject:new("Stage1", Resource.Paint, paint.obj, Vector2(1600, 900), Vector2(0, 0))
    stages[2] = UIObject:new("Stage2", Resource.Paint, paint.obj, Vector2(1600, 900), Vector2(0, 0))
    stages[3] = UIObject:new("Stage3", Resource.Paint, paint.obj, Vector2(1600, 900), Vector2(0, 0))

    for k, v in pairs(stages) do
        
    end

    return paint
end

return Paint