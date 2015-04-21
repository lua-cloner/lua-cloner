require'lfs'

disks={}
useDisk = ""

local function main()
  for file in lfs.dir('/dev/') do 
    if lfs.attributes(file).mode=='block device' then 
      if not file:find'loop' or file:find'dvd' or file:find'cdrom' then
        table.insert(disks,file)
      end 
    end 
  end
  
  for i=1, #disks do
    print(i.."- "+disks[i])
  end
  
  i = read();
  useDisk = disks[i]
  disks = null --Free memory
end

main()
