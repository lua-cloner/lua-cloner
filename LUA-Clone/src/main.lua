require'lfs'
local class = require 'middleclass'

screen = {function clear() end, function setPos(x, y) end, function getPos() end, function read() end}

local function main()
  init()

  result, i = Menu:showMain()
  
  if i==1 then
    Menu:showCreateImage(disks)  --todo
  else if i==2 then
    Menu:showCreateMultiImage()  --todo create
  else if i==3 then
    Menu:showIncrementImage()  --todo create
  else if i==4 then
    Menu:showRestoreImage()  --todo create
  end
  
end

init()
ok, err = pcall(main)
if not ok then
  print("ERROR: "..err)
  --TODO shutdown hook
end


--Fuctions
function init() 
  Menu = class("Menu")
end

function Menu:initialize() 
  --unused
end

function Menu:showMain()

  screen.clear();
  screen.setPos(0,0)
  print("lua-clone V0.0.1-a") --major.minor.patch-letter  major = Breaks saves/images   minor = Adds feature/stable  patch = bugfix  letter= a=alpha, b=beta, r=release, t=testing, s=stable 
  print("---------------")
  print()
  
  print("1- Create Image")
  print("2- Create MultiImage")
  print("3- Increment Image")
  print("4- Restore Image")
  while true do
    i = tonumber(io.read())
    if i>0 an i<5 then
      return true, i
    end
  end
end
function Menu:showCreateImage(disks)
  local useDisk
  
  local disks={}
  for file in lfs.dir('/dev/') do 
    if lfs.attributes(file).mode=='block device' then 
      if not file:find'loop' or file:find'dvd' or file:find'cdrom' then
        table.insert(disks,file)
      end 
    end 
  end
  
  screen.clear();
  screen.setPos(0,0)
  print("Choose a option")
  for i=1, #disks do
    print("  "..i.."- "+disks[i])
  end
  while true do
    i = tonumber(io.read())
    if i>0 and i=<#disks then
      useDisk = disks[i]
      break
    end
  end
  return true
end

