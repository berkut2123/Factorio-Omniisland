--list of items to stack
local List=
{    
    {"motor",          2},
	{"electric-motor", 2},
	{"stone-tablet",   1},
	{"glass", 1},
	{"sand" , 1,}
}




for _, item in pairs (List) do
  if data.raw.item[item[1]] then
    --BELTBOXES
    if deadlock_stacking then
	  if not data.raw.item["deadlock-stack-"..item[1]] then
	    deadlock.add_stack(item[1],"__aai-industry__/graphics/icons/"..item[1].."-stacked.png" , "deadlock-stacking-"..item[2])
	  end
	end
	--CRATES
	if deadlock_crating then
	  if not data.raw.item["deadlock-crate-"..item[1]]then
	    deadlock_crating.add_crate(item[1], "deadlock-crating-"..item[2])
	  end
	end
  end   
end


