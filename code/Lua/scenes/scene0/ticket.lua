local Interactive = require("Lua/module/interactive")
local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local Resource = require("Lua/resource").Ticket

local Ticket = {}

--- @param _parent Scene
function Ticket.Get(_parent)
    local ticket =
        Interactive:new("ticket", Resource.Ticket, Resource.Ticket, _parent, Vector2(70, 40), Vector2(-1700, -380))
    local animation = Animation:new(ticket.obj, Resource.TicketAni, 0.3)
    ticket:SetAnimation(animation)

    local ticketUI = UIObject:new("ticketUI", Resource.TicketUI, _parent.obj.Parent, Vector2(1480, 900), Vector2(0, 0))

    ticketUI:SetClickFunc(
        function()
            ticketUI:SetVisible(false)
            _parent:SetVisible(true)
            _parent:Tip("继续往前走", 5)
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
