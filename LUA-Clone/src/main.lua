require'lfs'
local class = require 'middleclass'

screen = {
  ["clear"] = function() 
  
  end, 
  ["setPos"] = function(x, y)
  
  end, 
  ["getPos"] = function() 
  
  end, 
  ["read"] = function() 
  
  end
}

local function main()
  init()

  result, i = Menu:showMain()
  
  if i==1 then
    Menu:showCreateImage()
  elseif i==2 then
    Menu:showCreateMultiImage()  --todo
  elseif i==3 then
    Menu:showRestoreImage()  --todo
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
  print("lua-clone V0.0.1-a") --major.minor.patch-letter  semver  letter= a=alpha, b=beta, r=release, t=testing, s=stable 
  print("---------------")
  print()
  
  print("1- Create Image")
  print("2- Create MultiImage")
  print("3- Restore Image")
  while true do
    i = tonumber(io.read())
    if i>0 and i<4 then
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
    if i>0 and i<=#disks then
      useDisk = disks[i]
      break
    end
  end
  createImage(useDisk)
end

function Menu:showCreateMultiImage() 
  --show files detected as .raw
  
end

function Menu:showRestoreImage()
  --show multi images detected and select disk to restore to
end

function createImage (useDisk)
  print(io.popen("zip image.raw "..useDisk, "w"))
end

function createMultiImage(...)
  local images = {...}
  local str = ""
  for i=1, images do
    str = images[i].." "
  end
  print(io.popen("zip image.lcl "..str,mode))
end

function restore(imageName, diskName)
  print(io.popen("unzip "..imageName.." -d /dev/"..diskName ,mode))
end
