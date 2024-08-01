-- dgfs.lua
-- API to read and write to the DGFS

-- Copyleft daysant, Prellit, Everytab - Jikkakukei
-- This file is licensed under the terms of the Affero GPL v3.0-or-later.

-------------------------------------------------------------------------------

local main = component.proxy(component.list("drive")())
local boot = component.proxy(component.list("filesystem")())
local sector_id = {}
local sector_dump = {}
local dump = {}
-------------------------------------------------------------------------------

initialized_fat = main.readByte(1)

if initialized_fat == 1 then
    goto load_fat -- FAT is initialized, skip
else
    main.writeByte(1,1)

:: load_fat ::
function read(sector_id)
    dump = component.drive.readSector(sector_id)
    sector_dump = io.open("/tmp/" .. sector_id, "w")
    sector_dump:write(dump)
    sector_dump:close()
end

function write(sector_id)
    sector_dump = io.open("/tmp/" .. sector_id, "r")
    dump = sector_dump:read("*a")
    sector_dump:close()
    component.drive.writeSector(sector_id, dump)
end
