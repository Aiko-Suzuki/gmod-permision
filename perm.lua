local NNT = NNT or {}

NNT.Permisions = {
    permissions = {},
    addPermission = function(self, current, perm) return bit.bor(current, perm) end,
    -- bitwise OR
    removePermission = function(self, current, perm) return bit.band(current, bit.bnot(perm)) end,
    -- bitwise  bitwise AND NOT
    hasPermission = function(self, current, perm) return bit.band(current, perm) == perm end,
    -- bitwise AND
    createPermission = function(self, name)
        -- check if permission exists
        if self.permissions[name] then return self.permissions[name] end
        -- operation is a bitwise left shift by 1 bit 
        --1 << #self.permissions
        self.permissions[name] = bit.lshift(1, table.Count(self.permissions))
        self:save()

        return self.permissions[name]
    end,
    convertToTable = function(self, perm)
        local tbl = {}

        for k, v in pairs(self.permissions) do
            if self:hasPermission(perm, v) then
                tbl[k] = true
            else
                tbl[k] = false
            end
        end

        return tbl
    end,
    -- save to file or database
    save = function(self)
        if not self.name then return end
        file.CreateDir("nnt/permissions")
        file.Write("nnt/permissions/" .. self.name .. ".json", util.TableToJSON(self.permissions, true))

        return true
    end,
    new = function(name)
        local o = NNT.Permisions
        o.new = nil
        setmetatable(o, NNT.Permisions)
        o.name = name

        if file.Exists("nnt/permissions/" .. name .. ".json", "DATA") then
            local data = file.Read("nnt/permissions/" .. name .. ".json", "DATA")
            local tbl = util.JSONToTable(data)
            o.permissions = tbl
        end

        return o
    end,
    __index = function(self, key)
        if self.permissions[key] then
            return self.permissions[key]
        elseif self[key] then
            return self[key]
        end
    end,
}

return NNT.Permisions