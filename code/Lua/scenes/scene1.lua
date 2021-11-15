local Scene = require("Lua/module/scene")
local Interactive = require("Lua/module/interactive")

local module = {}

--- @param _name string
--- @param _parent Canvas
function module:Get(_name, _parent)
    --- @type Scene
    local scene = Scene:new(_name, "Local/scene", _parent, Vector2(3000, 1000))
    table.insert(
        scene.interactives,
        Interactive:new(
            "interactive",
            "Local/水桶",
            "Local/水桶",
            scene,
            Vector2(150, 120),
            Vector2(200, 100),
            function()
                print("interactive")
            end
        )
    )
    return scene
end

return module
