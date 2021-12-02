local UIObject = require("Lua/module/uiObject")
local Interactive = require("Lua/module/interactive")
local PhotoImage = require("Lua/resource").Photo
local GameManager = require("Lua/game")
local Animation = require("Lua/module/animation")

local Photo = {}

--- @param _parent Scene
function Photo.Get(_parent)
    local photo =
        Interactive:new("photo", PhotoImage.Photo, PhotoImage.Photo, _parent, Vector2(90, 100), Vector2(-1350, 40))
    local bigPhoto =
        UIObject:new("bigphoto", PhotoImage.PhotoInfo, _parent.obj.Parent, Vector2(1600, 900), Vector2.Zero)

    bigPhoto:SetVisible(false)
    local animation = Animation:new(photo.obj, PhotoImage.PhotoAni, 0.2)
    photo:SetAnimation(animation)

    local count = 0
    bigPhoto:SetClickFunc(
        function()
            if count == 0 then
                GameManager.ShowTip("428。这有什么意义吗？", 5)
                count = 1
            else
                bigPhoto:SetVisible(false)
                _parent:SetVisible(true)
            end
        end
    )

    photo:SetFunc(
        function()
            _parent:SetVisible(false)
            bigPhoto:SetVisible(true)
            GameManager.ShowTip("这个男人总给我一种很熟悉的感觉……\n嗯？背面好像有字。", 5)
            count = 0
        end
    )

    return photo
end
return Photo
