--list of items to stack
local List=
{    
  {"motor"         , 2, true, "single-cylinder-engine"},
	{"electric-motor", 2, true, "small-electric-motor"},
	{"stone-tablet"  , 1, true, "stone-tablet"},
	{"glass"         , 1, true, "glass"},
	{"sand"          , 1, true, "sand"},
	{"processed-fuel", 1, true, "processed-fuel"}
}




for _, item in pairs (List) do
  if data.raw.item[item[1]] then
    --BELTBOXES
    if deadlock_stacking then
	  if not data.raw.item["deadlock-stack-"..item[1]] then
		local icon = item[3] and "__aai-industry__/graphics/icons/"..item[4].."-stacked.png" or false
	    deadlock.add_stack(item[1],icon , "deadlock-stacking-"..item[2])
	  end
	end
	--CRATES
	if deadlock_crating then
	  if not data.raw.item["deadlock-crate-"..item[1]] then
	    deadlock_crating.add_crate(item[1], "deadlock-crating-"..item[2])
	  end
	end
  end   
end


