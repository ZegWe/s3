local Resource = {}

--- Player Image Resource
--- @type table
Resource.Player = {
    --- Player Idle Left
    Idle_Left = {
        "Local/人物/主角待机左/主角待机1",
        "Local/人物/主角待机左/主角待机2",
        "Local/人物/主角待机左/主角待机3",
        "Local/人物/主角待机左/主角待机4"
    },
    --- Player Idle Right
    Idle_Right = {
        "Local/人物/主角待机右/主角待机1",
        "Local/人物/主角待机右/主角待机2",
        "Local/人物/主角待机右/主角待机3",
        "Local/人物/主角待机右/主角待机4"
    },
    --- Player Walk Left
    Walk_Left = {
        "Local/人物/主角走路左/主角走路1",
        "Local/人物/主角走路左/主角走路2",
        "Local/人物/主角走路左/主角走路3",
        "Local/人物/主角走路左/主角走路4",
        "Local/人物/主角走路左/主角走路5",
        "Local/人物/主角走路左/主角走路6",
        "Local/人物/主角走路左/主角走路7"
    },
    --- Player Walk Right
    Walk_Right = {
        "Local/人物/主角走路右/主角走路1",
        "Local/人物/主角走路右/主角走路2",
        "Local/人物/主角走路右/主角走路3",
        "Local/人物/主角走路右/主角走路4",
        "Local/人物/主角走路右/主角走路5",
        "Local/人物/主角走路右/主角走路6",
        "Local/人物/主角走路右/主角走路7"
    }
}

Resource.Scene1 = {
    All = "Local/客厅场景/整体1",
    NoBucket = "Local/客厅场景/去掉水桶",
    NoCanvas = "Local/客厅场景/去掉画板",
    Empty = "Local/客厅场景/去掉画板和水桶",
}

Resource.MainDoor = {
    Door = "Local/打不开的大门/大门1",
    DoorShake = {
        "Local/打不开的大门/大门1",
        "Local/打不开的大门/大门2",
        "Local/打不开的大门/大门1",
        "Local/打不开的大门/大门3",
        "Local/打不开的大门/大门1",
        "Local/打不开的大门/大门2",
        "Local/打不开的大门/大门1",
        "Local/打不开的大门/大门1",
        "Local/打不开的大门/大门1",
        "Local/打不开的大门/大门1",
        "Local/打不开的大门/大门2",
        "Local/打不开的大门/大门1",
        "Local/打不开的大门/大门3",
        "Local/打不开的大门/大门1",
        "Local/打不开的大门/大门2",
        "Local/打不开的大门/大门1",
    },
    Maoyan = "Local/猫眼/猫眼界面1",
    MaoyanAni = {
        "Local/猫眼/猫眼界面1",
        "Local/猫眼/猫眼界面1",
        "Local/猫眼/猫眼界面1",
        "Local/猫眼/猫眼界面2",
        "Local/猫眼/猫眼界面3",
        "Local/猫眼/猫眼界面4",
        "Local/猫眼/猫眼界面5"
    }
}

Resource.Mirror = {
    Mirror = "Local/镜子/镜子1",
    MirrorAni = {
        "Local/镜子/镜子1",
        "Local/镜子/镜子2",
        "Local/镜子/镜子3"
    },
    MirrorPlayerAniLeft = {
        "Local/镜子/镜子映射a",
        "Local/镜子/镜子映射b",
        "Local/镜子/镜子映射c"
    },
    MirrorPlayerAniRight = {
        "Local/镜子/镜子映射1",
        "Local/镜子/镜子映射2",
        "Local/镜子/镜子映射3"
    }
}

Resource.Bucket = {
    Bucket = "Local/其他动效/水桶4",
    BucketAni = {
        "Local/其他动效/水桶1",
        "Local/其他动效/水桶2",
        "Local/其他动效/水桶3",
        "Local/其他动效/水桶4",
        "Local/其他动效/水桶4",
        "Local/其他动效/水桶4",
    }
}

Resource.Canvas = {
    Canvas = "Local/其他动效/画布1",
    CanvasAni = {
        "Local/其他动效/画布1",
        "Local/其他动效/画布2",
        "Local/其他动效/画布3",
    }
}

return Resource
