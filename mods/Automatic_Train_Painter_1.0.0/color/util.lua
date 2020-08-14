function filter_name(item)
    -- remove sub-strings from item names
    for _,v in pairs(removals) do
        if (string.find(item,v[1]) and not string.find(item,"empty%-barrel")) then
            item=string.gsub(item,v[1],"")
        end
    end

    -- divert duplicated item-names to correct color as applicable
    for mod, filterlist in pairs(mod_list) do
        if game.active_mods[mod] and filterlist[3] ~=nil then
            for _,x in pairs(filterlist[3]) do
                if(item==x) and filterlist[2] ~=nil then
                    item=item .. filterlist[2]
                end
            end
        end
    end

    return item
end

function rgb_to_hsv(color)
    local cmax=math.max(color.r,color.g,color.b)/255
    local cmin=math.min(color.r,color.g,color.b)/255
    local diff=cmax-cmin

    -- hue
    local h
    if cmax==cmin then
        h=0
    elseif cmax==color.r/255 then
        h=math.fmod(60*((color.g/255-color.b/255)/diff)+360,360)
    elseif cmax==color.g/255 then
        h=math.fmod(60*((color.b/255-color.r/255)/diff)+120,360)
    elseif cmax==color.b/255 then
        h=math.fmod(60*((color.r/255-color.g/255)/diff)+240,360)
    end

    -- saturation
    local s
    if cmax==0 then
        s=0
    else
        s=(diff/cmax)*100
    end

    -- value
    local v=cmax*100

    return {h=h,s=s,v=v,a=color.a}
end

function hsv_to_rgb(color)
    local c=(color.v*color.s)/10000
    local h0=color.h/60
    local x=c*(1-math.abs(math.fmod(h0,2)-1))
    local m=round(color.v/100-c,14)

    -- red
    local r
    if (0<=h0 and h0<1) or (5<=h0 and h0<6) then
        r=c
    elseif (1<=h0 and h0<2) or (4<=h0 and h0<5) then
        r=x
    else
        r=0
    end
    r=(r+m)*255

    -- green
    local g
    if (1<=h0 and h0<2) or (2<=h0 and h0<3) then
        g=c
    elseif (0<=h0 and h0<1) or (3<=h0 and h0<4) then
        g=x
    else
        g=0
    end
    g=(g+m)*255

    -- blue
    local b
    if (3<=h0 and h0<4) or (4<=h0 and h0<5) then
        b=c
    elseif (2<=h0 and h0<3) or (5<=h0 and h0<6) then
        b=x
    else
        b=0
    end
    b=(b+m)*255

    return {r=r,g=g,b=b,a=color.a}
end