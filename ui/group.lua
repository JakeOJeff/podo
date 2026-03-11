Group = {}
Group.__index = Group
ActiveGroups = {}


function Group.new(x, y, margin, children, orientation)
    local self = setmetatable({}, Group)

    self.x = x or 10
    self.y = y or 10

    self.w = 0
    self.h = 0

    self.margin = margin or 10
    self.orientation = orientation or "flex" -- "flex" horizontal "flex-v" vertical

    self.items = children or {}

    for _, v in ipairs(self.items) do
        if self.orientation == "flex" then
            v.x = self.x + self.w
        elseif self.orientation == "flex-v" then
             v.y = self.y + self.margin + self.h
        end
        
        self.w = self.w + self.marging + v.w 
        self.h = self.h + self.marging + v.h


    end


    table.insert(ActiveGroups, self)

end

function Group:draw()
    for _, v in ipairs(self.items) do
        v:draw()
    end
end

function Group:insert(item)
    table.insert(self.items, item)
end


return Group