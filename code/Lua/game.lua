local GameManager = {}

local gameStage = 1

function GameManager.Start()

end

local mirrorChecked = true

function GameManager.CheckMirror()
    mirrorChecked = true
end

function GameManager.MirrorChecked()
    return mirrorChecked
end

return GameManager