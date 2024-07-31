-- dgfs.lua
-- API to read and write to the DGFS

-- Copyleft daysant, Prellit, Everytab - Jikkakukei
-- This file is licensed under the terms of the Affero GPL v3.0-or-later.

-------------------------------------------------------------------------------

local main = component.proxy(component.list("drive")())
local boot = component.proxy(component.list("filesystem")())

-------------------------------------------------------------------------------

initialized_fat = main.readByte(1)

if initialized_fat == 1 then
    goto load_fat -- FAT is initialized, skip
else
    main.writeByte(1,1)

:: load_fat ::