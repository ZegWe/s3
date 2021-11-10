local Resource = {}

--- Player Image Resource
--- @type table
Resource.PlayerImage = {
    --- Player Idle Left
    --- @type table
    Idle_Left = {"Local/Player"},
    --- Player Idle Right
    --- @type table
    Idle_Right = {"Local/Player"},
    --- Player Walk Left
    Walk_left = {
        "Local/Walk_Left_01",
        "Local/Walk_Left_02",
        "Local/Walk_Left_03",
        "Local/Walk_Left_04"
    },
    --- Player Walk Right
    Walk_Right = {
        "Local/Walk_Right_01",
        "Local/Walk_Right_02",
        "Local/Walk_Right_03",
        "Local/Walk_Right_04"
    }
}

return Resource
