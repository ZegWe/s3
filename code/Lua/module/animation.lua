--- @class Animation
local Animation = class("Animation")

--- @param _obj UiImageObject
--- @param _t table
--- @param _dt number
--- @param _once boolean
function Animation:initialize(_obj, _t, _dt, _once)
    self.obj = _obj
    self.t = {}
    self.once = _once
    for k, v in pairs(_t) do
        table.insert(self.t, ResourceManager.GetTexture(v))
    end
    self.dt = _dt
    self.tickNow = 0
    self.playing = false
end

function Animation:tickNext()
    if #(self.t) == self.tickNow then
        if self.once == true then
            self:Stop()
            return
        end
        self.tickNow = 1
    else
        self.tickNow = self.tickNow + 1
    end
    self.obj.Texture = self.t[self.tickNow]
end

function Animation:Play()
    if self.playing == true then
        return
    end
    self.playing = true
    invoke(
        function()
            while self.playing == true do
                self:tickNext()
                wait(self.dt)
            end
        end
    )
end

function Animation:Stop()
    self.playing = false
end

return Animation
