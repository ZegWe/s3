--- @class AudioPlayer
local AudioPlayer = class("AudioPlayer")

function AudioPlayer:initialize(_name, _ref, _loop)
    --- @type AudioSource
    self.obj = world:CreateObject("AudioSource", _name, world.Local)
    self.obj.SoundClip = ResourceManager.GetSoundClip(_ref)
    self.obj.Loop = _loop
end

function AudioPlayer:Play()
    self.obj:Play()
end

function AudioPlayer:Pause()
    self.obj:Pause()
end

function AudioPlayer:Stop()
    self.obj:Stop()
end

function AudioPlayer:UnPause()
    self.obj:UnPause()
end

return AudioPlayer
