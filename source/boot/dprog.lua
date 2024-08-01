-- dprog.lua 
-- Testing program to interface with the core driver


local addr, invoke = computer.getBootAddress(), component.invoke
local function loadfile(file)
    local handle = assert(invoke(addr, "open", file))
    local buffer = ""
    repeat
      local data = invoke(addr, "read", handle, math.maxinteger or math.huge)
      buffer = buffer .. (data or "")
    until not data
    invoke(addr, "close", handle)
    return load(buffer, "=" .. file, "bt", _G)
end
loadfile(/dlib/dgfs.lua)

io.write("Sample DFGS Driver Interface")
io.write("Ensure that intended sector already exists as /tmp/<sector_number")
io.write("Choose option")
io.write("(1) Read Sector, (2) Write Sector, (3) Cancel")

local choice = io.read
local read_sec = {}
local write_sec = {}

if choice == 1 then
  io.write("Enter sector")
  read_sec = io.read
  dgfs.read(read_sec)
elseif choice == 2 then
  io.write("Enter sector")
  write_sec = io.read
  dgfs.write(write_sec)
elseif choice == 3 then
  break
else
    io.write("Invalid option")
    break 
end
