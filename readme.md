# Examples
```lua
-- include
local permissions = include("perm.lua")
local user = {
    name = "Aiko",
    perm = 0,
}
-- create new permission
local PermsManager = permissions.new("test")
PermsManager:createPermission("ADMIN_GIVE")

-- add permisions
user.perm = PermsManager:addPermission(user.perm,PermsManager.ADMIN_GIVE)
PrintTable(user)

-- check permisions
PermsManager:hasPermission(user.perm,PermsManager.ADMIN_GIVE)
print(PermsManager:hasPermission(user.perm,PermsManager.ADMIN_GIVE))

-- remove permisions
user.perm = PermsManager:removePermission(user.perm,PermsManager.ADMIN_GIVE)
print(PermsManager:hasPermission(user.perm,PermsManager.ADMIN_GIVE))

-- convert permisions to table
PrintTable(PermsManager:convertToTable(user.perm))
```
