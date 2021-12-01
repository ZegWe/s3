local Scene = require("Lua/module/scene")
local Interactive = require("Lua/module/interactive")
local Resource = require("Lua/resource").End

local module = {}

--- @param _name string
--- @param _parent Canvas
function module:Get(_name, _parent)
    local scene = Scene:new(_name, Resource.Background, _parent, Vector2(6230, 900), Vector2(-2500, -115), Resource.BGM)
    local sofa = Interactive:new("sofa", Resource.Sofa, Resource.Sofa, scene, Vector2(300, 300), Vector2(2500, 0))
    scene:AddInteractive(sofa)

    sofa:SetFunc(
        function()
            print("---------------end")
        end
    )

    return scene
end

return module
