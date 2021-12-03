local Interactive = require("Lua/module/interactive")
local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local Resource = require("Lua/resource").Ticket
local GameManager = require("Lua/game")

local Ticket = {}

--- @param _parent Scene
function Ticket.Get(_parent)
    local ticket =
        Interactive:new("ticket", Resource.Ticket, Resource.Ticket, _parent, Vector2(70, 40), Vector2(-1500, -380))
    local animation = Animation:new(ticket.obj, Resource.TicketAni, 0.3)
    ticket:SetAnimation(animation)

    local ticketUI = UIObject:new("ticketUI", Resource.TicketUI, _parent.obj.Parent, Vector2(1480, 900), Vector2(0, 0))

    local back = UIObject:new("back", Resource.Back, ticketUI.obj, Vector2(100, 100), Vector2(650, -350))
    back:SetVisible(true)

    back:SetClickFunc(
        function()
            ticketUI:SetVisible(false)
            _parent:SetVisible(true)
            GameManager.ShowTip("继续往前走", 5)
            _parent:RemoveInteractive(ticket)
            ticket:SetVisible(false)
        end
    )

    ticket:SetFunc(
        function()
            _parent:SetVisible(false)
            ticketUI:SetVisible(true)
        end
    )

    return ticket
end

return Ticket
