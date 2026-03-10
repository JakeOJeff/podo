Group = {}
Group.__index = Group
ActiveGroups = {}


function Group.new(x, y, children, orient, orientation)
    local self = setmetatable({}, Group)

    self.x = x or 10
    self.y = y or 10

    self.orient = orient or false
    self.orientation = orientation or "flex" -- "flex" horizontal "flex-v" vertical

    self.items = {}

    table.insert(ActiveGroups, self)

end

function Group:insert(item)
    table.insert(self.items, item)
end