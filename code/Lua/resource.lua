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
    BGM = "Sound/场景一bgm",
    All = "Local/客厅场景/整体1",
    NoBucket = "Local/客厅场景/去掉水桶",
    NoCanvas = "Local/客厅场景/去掉画板",
    Empty = "Local/客厅场景/去掉画板和水桶"
}

Resource.BedRoom = {
    BGM = "",
    Background = "Local/卧室场景/卧室整体"
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
        "Local/打不开的大门/大门1"
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
    },
    MaoyanBGM = "Sound/猫眼动画"
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
    },
    DoorRing = "Sound/门铃声"
}

Resource.Bucket = {
    Bucket = "Local/Bucket/水桶4",
    BucketAni = {
        "Local/Bucket/水桶1",
        "Local/Bucket/水桶2",
        "Local/Bucket/水桶3",
        "Local/Bucket/水桶4",
        "Local/Bucket/水桶4",
        "Local/Bucket/水桶4"
    }
}

Resource.Canvas = {
    Canvas = "Local/画布/画布1",
    CanvasAni = {
        "Local/画布/画布1",
        "Local/画布/画布2",
        "Local/画布/画布3"
    }
}

Resource.RoomDoor = {
    ButtonPressSound = "Sound/电子锁按键音",
    Door = "Local/打开卧室门/卧室门1",
    Lock = "Local/RoomDoor/电子锁界面",
    Text = "Local/文本框",
    ButtonConfirm = "Local/RoomDoor/确认",
    ButtonClear = "Local/RoomDoor/清空",
    Back = "Local/RoomDoor/返回",
    Answer = "Local/RoomDoor/密码锁小框",
    DoorOpen = {
        "Local/打开卧室门/卧室门1",
        "Local/打开卧室门/卧室门2",
        "Local/打开卧室门/卧室门3",
        "Local/打开卧室门/卧室门4",
    },
    LockNumbers = {
        "Local/RoomDoor/1",
        "Local/RoomDoor/2",
        "Local/RoomDoor/3",
        "Local/RoomDoor/4",
        "Local/RoomDoor/5",
        "Local/RoomDoor/6",
        "Local/RoomDoor/7",
        "Local/RoomDoor/8",
        "Local/RoomDoor/9"
    }
}

Resource.Photo = {
    Photo = "Local/相框/相框",
    PhotoInfo = "Local/相框/相框界面",
    Text = "Local/文本框",
    PhotoAni = {
        "Local/相框/相框1",
        "Local/相框/相框2",
        "Local/相框/相框3"
    }
}

Resource.Calendar = {
    Calendar = "Local/日历/日历",
    CalendarInfo = "Local/日历/日历界面",
    Text = "Local/文本框",
    CalendarAni = {
        "Local/日历/日历1",
        "Local/日历/日历2",
        "Local/日历/日历3"
    }
}

Resource.Draw = {
    Draw = "Local/涂鸦/涂鸦4",
    DrawInfo = "Local/涂鸦/涂鸦界面",
    Text = "Local/文本框",
    DrawAni = {
        "Local/涂鸦/涂鸦1",
        "Local/涂鸦/涂鸦2",
        "Local/涂鸦/涂鸦3"
    }
}

Resource.FloatTip = {
    Background = "Local/文本框"
}

Resource.RoomDoorInside = {
    Door = "",
}

Resource.RoomTable = {
    Table = "",
    TableInfo = "",
    NewsPaper1 = "",
    NewsPaper2 = "",
    NewsPaper3 = "",
    Phone = "",
    DrawPaper = "",
}

return Resource
