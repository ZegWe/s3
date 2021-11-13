--- @class Animation
local Animation = class("Animation")

--- @param _obj UiImageObject
--- @param _t table
--- @param _dt number
function Animation:initialize(_obj, _t, _dt)
    self.obj = _obj
    self.t = {}
    for k, v in pairs(_t) do
        table.insert(self.t, ResourceManager.GetTexture(v))
    end
    self.dt = _dt
    self.tickNow = 1
    self.playing = false
end

function Animation:tickNext()
    if #(self.t) == self.tickNow then
        self.tickNow = 1
    else
        self.tickNow = self.tickNow + 1
    end
    self.obj.Texture = self.t[self.tickNow]
end

function Animation:Play()
    self.playing = true
    invoke(
        function()
            while wait(self.dt) do
                if self.playing == false then
                    break
                end
                self:tickNext()
            end
        end
    )
end

function Animation:Stop()
    self.playing = false
end

return Animation
