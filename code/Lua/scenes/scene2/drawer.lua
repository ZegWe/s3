local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local FloatTip = require("Lua/module/floatTip")
local AudioPlayer = require("Lua/module/audio")
local drawerImage = require("Lua/resource").Drawer
local InterActive = require("Lua/module/interactive")

local drawer = {}

--- @param _parent Scene
function drawer.Get(_parent)
    local bookdrawer =
        InterActive:new("bookdrawer", drawerImage.Book, drawerImage.Book, _parent, Vector2(360, 220), Vector2(420, -260))
    local bigdrawer =
        UIObject:new("bigdrawer", drawerImage.Drawer, _parent.obj.Parent, Vector2(1600, 900), Vector2.Zero)
	bigdrawer:SetVisible(false)
	local bigcolor =
        UIObject:new("bigcolor", drawerImage.Color, _parent.obj.Parent, Vector2(1600, 900), Vector2.Zero)
	
    local animation = Animation:new(bookdrawer.obj, drawerImage.BookdrawerAni, 0.2)
    bookdrawer:SetAnimation(animation)
	local animations = Animation:new(bigcolor.obj, drawerImage.ColorAni, 0.2)
	bigcolor:SetVisible(false)
    local blanks = {}

    local buttonPressSound = AudioPlayer:new("buttonPress", drawerImage.ButtonPressSound, false)

    blanks[1] = UIObject:new("b1", drawerImage.white, bigdrawer.obj, Vector2(270, 240), Vector2(-280, 255))
    blanks[2] = UIObject:new("b2", drawerImage.white, bigdrawer.obj, Vector2(270, 240), Vector2(5, 255))
    blanks[3] = UIObject:new("b3", drawerImage.white, bigdrawer.obj, Vector2(270, 240), Vector2(290, 255))
    blanks[4] = UIObject:new("b4", drawerImage.white, bigdrawer.obj, Vector2(270, 240), Vector2(-280, 0))
    blanks[5] = UIObject:new("b5", drawerImage.white, bigdrawer.obj, Vector2(270, 240), Vector2(5, 0))
    blanks[6] = UIObject:new("b6", drawerImage.white, bigdrawer.obj, Vector2(270, 240), Vector2(290, 0))
    blanks[7] = UIObject:new("b7", drawerImage.white, bigdrawer.obj, Vector2(270, 240), Vector2(-280, -255))
    blanks[8] = UIObject:new("b8", drawerImage.white, bigdrawer.obj, Vector2(270, 240), Vector2(5, -255))
    blanks[9] = UIObject:new("b9", drawerImage.white, bigdrawer.obj, Vector2(270, 240), Vector2(290, -255))
    

    
	local confirm = UIObject:new("confirm", drawerImage.ButtonConfirm, bigdrawer.obj, Vector2(190, 150), Vector2(245, 5))
    local clear = UIObject:new("clear", drawerImage.ButtonClear, bigdrawer.obj, Vector2(190, 150), Vector2(245, -145))
    local back = UIObject:new("back", drawerImage.Back, bigdrawer.obj, Vector2(390, 140), Vector2(-25, -380))
	
    local tip1 = FloatTip:new("", bigdrawer.obj, Vector2(0, 325))
    local tip2 = FloatTip:new("", bigcolor.obj, Vector2(0, 325))
    
	clear:SetVisible(true)
    back:SetVisible(true)
    confirm:SetVisible(true)
	
	tip1:SetClickFunc(
        function()
            tip1:SetVisible(false)
        end
    )

	tip2:SetClickFunc(
        function()
            tip2:SetVisible(false)
        end
    )
	
    local couts = {0,0,0,0,0,0,0,0,0}
    local unlocked = false
   
   for i, v in ipairs(blanks) do
        v:SetVisible(true)
        v:SetClickFunc(
            function()
                buttonPressSound:Play()
                if couts[i] == 0 then
				    blanks[i]:UpdateTexture(drawerImage.black)
					couts[i] =1
				elseif couts[i] == 1 then
				    blanks[i]:UpdateTexture(drawerImage.white)
					couts[i]=0
				end
            end
			
        )
    end
   
    confirm:SetClickFunc(
        function()

            if(couts[1] == 1 and couts[2] == 1 and couts[3] == 1 and couts[4] == 0 and couts[5] == 1 and 
			  couts[6] == 1 and couts[7] == 0 and couts[8] == 1 and couts[9] == 1) then
                tip1:SetText("抽屉开了")
				tip1:SetVisible(true)
                unlocked = true
                wait(0.2)	
                bigdrawer:SetVisible(false)
                bigcolor:SetVisible(true)
				
				bigcolor:SetClickFunc(function()
				    animations:Play()
					
					tip2:SetText("拿到了颜料")
				    tip2:SetVisible(true)
					bigcolor:UpdateTexture(drawerImage.nocolor)
				   
				   ---GameManager.GetPigment()
                    ---tip2("拿到了【颜料】", 5)
					wait(0.3)
					bigcolor:SetVisible(false)
					_parent:SetVisible(true)
                end)
			else
                for i, v in ipairs(blanks) do
				   	blanks[i]:UpdateTexture(drawerImage.white)
				end
				
				for i, v in ipairs(couts) do
				    couts[i] = 0
				end	
                tip1:SetText("好像不太对……")
				tip1:SetVisible(true)
            end
        end
    )
    clear:SetClickFunc(
        function()
            tip1:SetText( "黑白格子……？好像可以根据见过的黑白印象来填色？")
			tip1:SetVisible(true)
			    for i, v in ipairs(blanks) do
				    blanks[i]:UpdateTexture(drawerImage.white)
				end
				
				for i, v in ipairs(couts) do
				    couts[i] = 0
				end	
        end
    )
    back:SetClickFunc(
        function()
            bigdrawer:SetVisible(false)
            _parent:SetVisible(true)
        end
    )
    bookdrawer:SetFunc(
        function()
            if unlocked == false then
                bigdrawer:SetVisible(true)
            end
            tip1:SetText("黑白格子……？好像可以根据见过的黑白印象来填色？")
			tip1:SetVisible(true)
            
            _parent:SetVisible(false)
        end
    )
    return bookdrawer
end
return drawer
