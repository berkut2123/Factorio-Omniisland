require "mod-gui"

--[[  
  ** RPG SYSTEM **
by MFerrari  
]]

local XP_Mult = settings.startup["charxpmod_xp_multiplier_bonus"].value


-- CUSTOM EVENT HANDLING --
--(remote interface is lower in the file, there I describe how to subscribe to my events)
-- if your mod alters the character bonus settings, then you should get_on_player_updated_status to make required adjusts to your mod, if necessary
local on_player_updated_status = script.generate_event_name() --uint
local on_player_level_up = script.generate_event_name() --uint




function printXP(player,XP)
if settings.get_player_settings(player)["charxpmod_print_xp_user"].value then
	player.print('+XP: ' .. XP)
	end
end


function ResetXPTables()
local xp = settings.startup["charxpmod_xpinilevel"].value
global.xp_table = {[1] = xp}
local m
for k=2,100 do
    m = settings.startup["charxpmod_xpmult"].value - k*0.005
	xp = math.ceil(xp * m)
	global.xp_table[k] = xp
	end
global.max_xp = xp	
end


function SetForceValues(name)
	global.kills_spawner[name] = 0
	global.kills_units[name] = 0
	global.kills_worms[name] = 0
	global.XP[name] = 0
	global.XP_GANHO[name] = 0
	global.XP_TECH[name] = 0
	global.XP_LEVEL[name] = 1
	global.XP_LEVEL_MIN[name] = 0
	global.XP_KILL_HP[name] = 0
	global.XP_MAX_PLAYTIME[name] = 0
	global.XP_AVG_PLAYTIME[name] = 0
end




function VersionChange()

if global.personalxp.opt_Pick_Extender == nil then
	global.personalxp.opt_Pick_Extender = {}
	for _, player in pairs(game.players) do
		global.personalxp.opt_Pick_Extender[player.name] = false
	end
end

if global.XP_MAX_PLAYTIME == nil then 
	global.XP_MAX_PLAYTIME={} 
		for name, force in pairs (game.forces) do
			if name~='neutral' and name~='enemy' then
			global.XP_MAX_PLAYTIME[name] = 0
			end
		end
	end
	
if global.XP_AVG_PLAYTIME == nil then 
	global.XP_AVG_PLAYTIME={} 
		for name, force in pairs (game.forces) do
			if name~='neutral' and name~='enemy' then
			global.XP_AVG_PLAYTIME[name] = 0
			end
		end
	end	


if global.personalxp.rocketsXP_count == nil then
	global.personalxp.rocketsXP_count = {}
	for _, player in pairs(game.players) do
		global.personalxp.rocketsXP_count[player.name] = 0
	end
end
	
end


function SetupPlayer(player,ResetXP)
name= player.name
	
	if ResetXP then
		global.personalxp.XP[name] = 0
		global.personalxp.Death[name] = 0
		end
	global.personalxp.Level[name] = 1
    global.personalxp.LV_Craft_Speed[name]  = 0
    global.personalxp.LV_Mining_Speed[name] = 0
    global.personalxp.LV_Run_Speed[name]    = 0
    global.personalxp.LV_Build_Dist[name]   = 0
    global.personalxp.LV_Reach_Dist[name]   = 0
    global.personalxp.LV_Inv_Bonus[name]    = 0
--    global.personalxp.LV_InvQB_Bonus[name]  = 0
    global.personalxp.LV_InvLog_Bonus[name] = 0
    global.personalxp.LV_InvTrash_Bonus[name] = 0
    global.personalxp.LV_Robot_Bonus[name]  = 0
    global.personalxp.LV_Health_Bonus[name] = 0
	
	global.personalxp.opt_Pick_Extender[name] = false
	
UpdatePlayerLvStats(player)	
end

function CheckPlayers()
	for _, player in pairs(game.players) do
		if not (global.personalxp.Level[player.name]) then
			SetupPlayer(player,true)
			end 
		InitPlayerGui(player)
		end
end		

function CheckPlayer(player)
	if not (global.personalxp.Level[player.name]) then
		SetupPlayer(player,true)
	end 
end	

	
function XPModSetup()

if global.CharXPMOD == nil then 
	global.CharXPMOD = 1
	global.kills_spawner={}
	global.kills_units={}
	global.kills_worms={}
	global.XP={}
	global.XP_GANHO={}
	global.XP_KILL_HP={}
	global.XP_TECH={}
	global.XP_LEVEL={}
	global.XP_LEVEL_MIN={}
	global.XP_MAX_PLAYTIME={}
	global.XP_AVG_PLAYTIME={}	
	
	global.personalxp = {}
	global.personalxp.Level = {}
	global.personalxp.XP = {}
	global.personalxp.Death = {}
	
    global.personalxp.LV_Craft_Speed = {}
    global.personalxp.LV_Mining_Speed = {}
    global.personalxp.LV_Run_Speed = {}
    global.personalxp.LV_Build_Dist = {}
    global.personalxp.LV_Reach_Dist = {}
    global.personalxp.LV_Inv_Bonus = {}
    --global.personalxp.LV_InvQB_Bonus = {}
    global.personalxp.LV_InvLog_Bonus = {}
    global.personalxp.LV_InvTrash_Bonus = {}
    global.personalxp.LV_Robot_Bonus = {}
    global.personalxp.LV_Health_Bonus = {}
    global.personalxp.LV_Health_Bonus = {}
	global.personalxp.opt_Pick_Extender = {}

	for name, force in pairs (game.forces) do
		if name~='neutral' and name~='enemy' then
			SetForceValues(name)
			end
		end
	end
	
VersionChange()
ResetXPTables()
CheckPlayers()
end


function ResetAll()
ResetXPTables()
	for name, force in pairs (game.forces) do
		if name~='neutral' and name~='enemy' then
			SetForceValues(name)
			end
		end
	for _, player in pairs(game.players) do
		SetupPlayer(player,true)
		UpdatePanel(player)
		end
end


function ResetPointSpent()
ResetXPTables()

	for _, player in pairs(game.players) do
		SetupPlayer(player,false)
		--UpdatePanel(player)
		end
end



function InitPlayerGui(player)

local nome = player.name

-- close main panel
if player.gui.center["char-panel"] then
   player.gui.center["char-panel"].destroy() end

-- remove previous versions
if (mod_gui.get_button_flow(player).chartopframe) then
	mod_gui.get_button_flow(player).chartopframe.destroy() end
if (mod_gui.get_button_flow(player).btcharxp) then
	mod_gui.get_button_flow(player).btcharxp.destroy() end
if player.gui.top.chartopframe then  player.gui.top.chartopframe.destroy() end	
if player.gui.top.btcharxp then  player.gui.top.btcharxp.destroy() end
	
-- create new ones	
local Topframe = player.gui.top.add{name="chartopframe", direction = "horizontal", type="frame", style=mod_gui.frame_style}
 	Topframe.style.minimal_height = 30
-- 	Topframe.style.maximal_height = 37
	Topframe.style.minimal_width = 200
--	Topframe.style.maximal_width  = 250

Topframe.add{name="btcharxp", type="sprite-button", sprite = "entity/character", tooltip = {"panel-title"}, style = mod_gui.top_button_style} -- "mod_gui_button"}

local tabFrame = Topframe.add{type = "table", name = "tabtopframexp", column_count = 1}
Level = global.personalxp.Level[nome]
local pnivel = tabFrame.add{type="label", name='chartoplvtxt', caption={'actual_lv',Level}}
    pnivel.style.font="charxpmod_font_17b"
local TopXPbar = tabFrame.add{type = "progressbar", name = "TopXPbar",size=50}
UpdatePanel(player)
end


----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------


function RatioXP(player)
local ratioXP = 1
	if settings.global["charxpmod_time_ratio_xp"].value and global.XP_AVG_PLAYTIME[player.force.name]>0 then
		ratioXP = player.online_time/global.XP_AVG_PLAYTIME[player.force.name]
		if ratioXP >= 1.10 then ratioXP = 1.10
			elseif ratioXP < 0.05 then ratioXP = 0.05 end
		end	
return ratioXP
end


function XP_Player_upd()

 	for name, force in pairs (game.forces) do
	if name~='neutral' and name~='enemy' then

		local cp = #force.connected_players
		local afk = settings.global["charxpmod_afk"].value
		if cp>0 then
			local XP = global.XP[name]   --math.ceil(global.XP[name] / cp)
			
			if XP>0 then
			for p, PL in pairs (force.connected_players) do 
				if afk==0 or PL.afk_time<afk*3600 then
				local ratioXP = RatioXP(PL)
				XP = math.ceil(XP*ratioXP)	
				global.personalxp.XP[PL.name] = global.personalxp.XP[PL.name] + XP
				printXP(PL,XP)
				UpdatePanel(PL)
				end
				end
			end	
		global.XP[name]=0	
		end
	end
	end
end


function XP_PlayerLv_upd()

	for _, player in pairs(game.players) do
		if player.connected then
			local name = player.name
			local Lv = global.personalxp.Level[name]
			if global.personalxp.XP[name]>global.max_xp then 
			   global.personalxp.Level[name]=100
			   else
			
			for L=Lv, #global.xp_table do
				if global.personalxp.XP[name]< global.xp_table[L] then
					global.personalxp.Level[name]=L
					break
				end
			end end
			
			if global.personalxp.Level[name] > Lv then
				player.print({'player_lv_up',global.personalxp.Level[name]})
				player.play_sound{path = 'player_level_up'}
				UpdatePanel(player)
				script.raise_event(on_player_level_up, {player_index = player.index, player_level = global.personalxp.Level[name]})
				end
		end
	end
end


function XP_Time_upd()
 	for name, force in pairs (game.forces) do
	if name~='neutral' and name~='enemy' then
	local PT
	local TT=0
	local QP=0

		for p, PL in pairs (force.players) do 
			PT = PL.online_time
			if PT > global.XP_AVG_PLAYTIME[name]/20 then  -- a player time count for avg if he has at least 5% of the avg time
				TT = TT + PT
				QP = QP + 1
				end

			if global.XP_MAX_PLAYTIME[name] < PT then
				global.XP_MAX_PLAYTIME[name] = PT
				end
			end
	if QP>0 then global.XP_AVG_PLAYTIME[name] = TT/QP end
	end
	end
end


function XP_UPDATE_tick()

XP_Time_upd()
XP_Player_upd()
XP_PlayerLv_upd()

end







function FormulaSumLv(lv)
local pt = 0
if lv>0 then
for k=1,lv do pt=pt+ 1 + math.floor((k-1)/2)  end end
return pt
end

function SumPoitSpent_OLD(name)
local sum = (FormulaSumLv(global.personalxp.LV_Craft_Speed[name]) + 
    FormulaSumLv(global.personalxp.LV_Mining_Speed[name]) +
    FormulaSumLv(global.personalxp.LV_Run_Speed[name])    +
    --FormulaSumLv(global.personalxp.LV_Build_Dist[name])   +
    FormulaSumLv(global.personalxp.LV_Reach_Dist[name])   +
    FormulaSumLv(global.personalxp.LV_Inv_Bonus[name])    +
    --FormulaSumLv(global.personalxp.LV_InvQB_Bonus[name])  +
    FormulaSumLv(global.personalxp.LV_InvLog_Bonus[name]) +
    FormulaSumLv(global.personalxp.LV_InvTrash_Bonus[name]) +
    FormulaSumLv(global.personalxp.LV_Robot_Bonus[name])  +
    FormulaSumLv(global.personalxp.LV_Health_Bonus[name]))
	
return sum	
end



function SumPointSpent(name)
local sum = global.personalxp.LV_Craft_Speed[name] + 
    global.personalxp.LV_Mining_Speed[name] +
    global.personalxp.LV_Run_Speed[name]    +
    --global.personalxp.LV_Build_Dist[name]   +
    global.personalxp.LV_Reach_Dist[name]   +
    global.personalxp.LV_Inv_Bonus[name]    +
    global.personalxp.LV_InvLog_Bonus[name] +
    global.personalxp.LV_InvTrash_Bonus[name] +
    global.personalxp.LV_Robot_Bonus[name]  +
    global.personalxp.LV_Health_Bonus[name] 
	--global.personalxp.LV_InvQB_Bonus[name]*2
return sum	
end


function update_char_panel(player)
XP_Time_upd() 
 
  local force = player.force.name
  local painel = player.gui.center["char-panel"]
  local frame = painel.tabcharScroll
  local nome = player.name
  local Level = global.personalxp.Level[nome] 


local ptime = player.online_time
local txtPTime = {"time-played" ,string.format("%d:%02d:%02d", math.floor(ptime / 216000), math.floor(ptime / 3600) % 60, math.floor(ptime / 60) % 60)}

local PontosXP = Level - 1 - SumPointSpent(nome)
if PontosXP<0 then PontosXP=0 end

--	local img = frame.add{type = "sprite", sprite = "msi_win"}
--  local evo   = {"missions.evolution-factor", string.format("%.2f", math.floor(game.forces["enemy"].evolution_factor * 10000) / 100)}

  local tabChar = frame.add{type = "table", name = "tab_tbchar", column_count = 2}
  tabChar.add{type = "sprite", sprite = "charxpmod_space_suit"}

  local tabScroll = tabChar.add{type = "scroll-pane", name= "tabScroll2", vertical_scroll_policy="auto", horizontal_scroll_policy="auto"}
	tabScroll.style.minimal_height = 150
	tabScroll.style.minimal_width = 320
	tabScroll.style.maximal_width = 350		

 
  local tabPName = tabScroll.add{type = "table", name = "tab_pname", column_count = 3}
  local pname = tabPName.add{type="label", name='ocharname',  caption=nome}
  pname.style.font="charxpmod_font_30b"
  pname.style.font_color=player.color 
  tabPName.add{type="label", name='blanklab1', caption='        - '}
  local pnivel = tabPName.add{type="label", name='ocharlevel', caption={'actual_lv',Level}}
  pnivel.style.font="charxpmod_font_30"
  pnivel.style.font_color=player.color 


  local tabPStat = tabScroll.add{type = "table", name = "tab_PStat", column_count = 2}
  tabPStat.add{type="label", name='STT1', caption= txtPTime}.style.font="charxpmod_font_17"
  tabPStat.add{type="label", name='STT2', caption={'xp_deaths',global.personalxp.Death[nome]}}.style.font="charxpmod_font_17"
   
  tabScroll.add{type="label", name='blankL1', caption=' '}
  
  -- stats
  local tabStats = tabScroll.add{type = "table", name = "tabStats", column_count = 2}
  tabStats.add{type="label", name='STT3', caption={'xp_spawnk',global.kills_spawner[force]}}
  tabStats.add{type="label", name='STT4', caption={'xp_techs',global.XP_TECH[force]}}
  tabStats.add{type="label", name='STT5', caption={'xp_wormk',global.kills_worms[force]}}
  tabStats.add{type="label", name='STT6', caption={'xp_unitk',global.kills_units[force]}}

  
local pbvalue = CalculateXP_PB(player)
--local pbvalue = player.gui.top.chartopframe.TopXPbar.value
local XP = global.personalxp.XP[nome] 
local NextLevel = global.xp_table[Level]

  local NextLtxt = {'next_lv',NextLevel}
  if XP < global.max_xp then 
     else NextLtxt = 'MAX' end
  
  local tabXP = frame.add{type = "table", name = "tab_XP", column_count = 3}
  tabXP.add{type="label", name='lbxpatual', caption='XP: ' .. XP }.style.font="charxpmod_font_17"
  local bar = tabXP.add{type = "progressbar", size = 50, value = pbvalue, name = "tab_XPbar"}
  tabXP.add{type="label", name='lbxpnext', caption=NextLtxt}.style.font="charxpmod_font_17"

	
-- XP RATIO	
  local ratioXP = RatioXP(player)
  ratioXP = math.floor(ratioXP*100)
  frame.add{type="label", name='lbxratioxp', caption={'xp_ratio', ratioXP}}
  
  frame.add{type="label", name='blankL3', caption=' '}
  frame.add{type="label", name='lbxPAGastar', caption={'xp_points',PontosXP}}.style.font="charxpmod_font_20"   
  
-- LEVELS / UPGRADES
  local tabUpgrades = frame.add{type = "table", name = "tabUpgrades", column_count = 6}
  
  local Max = 20
  local vchar = 'global.personalxp.LV_Health_Bonus' 
  local atual = global.personalxp.LV_Health_Bonus[nome]
  --local custo = 1 + math.floor(atual/2)
  local custo = 1
  tabUpgrades.add{type="label", name='lmChar1'..vchar, caption={vchar}, tooltip={'xp_hint_'..vchar,50}}
  tabUpgrades.add{type="label", name='lmChar2'..vchar, caption=atual}.style.font="charxpmod_font_17b"
if PontosXP>=custo and atual<=Max  then tabUpgrades.add{type="sprite-button", sprite = "charxpmod_img_button_add", style = mod_gui.button_style, tooltip={'xp_costbt',custo},name='btLVU_'..vchar} else
     tabUpgrades.add{type="label", name='lmChar3'..vchar, caption='      ', tooltip={'xp_costbt',custo}} end

 	 
  local vchar = 'global.personalxp.LV_Run_Speed'
  atual = global.personalxp.LV_Run_Speed[nome]
  local custo = 1
  tabUpgrades.add{type="label", name='lmChar1'..vchar, caption={vchar}, tooltip={'xp_hint_'..vchar,20}}
  tabUpgrades.add{type="label", name='lmChar2'..vchar, caption=atual}.style.font="charxpmod_font_17b"
if PontosXP>=custo and atual<=Max  then tabUpgrades.add{type="sprite-button", sprite = "charxpmod_img_button_add", style = mod_gui.button_style, tooltip={'xp_costbt',custo},name='btLVU_'..vchar} else
     tabUpgrades.add{type="label", name='lmChar3'..vchar, caption='      ', tooltip={'xp_costbt',custo}} end

  local vchar = 'global.personalxp.LV_Craft_Speed'
  atual = global.personalxp.LV_Craft_Speed[nome]
  local custo = 1
  tabUpgrades.add{type="label", name='lmChar1'..vchar, caption={vchar}, tooltip={'xp_hint_'..vchar,20}}
  tabUpgrades.add{type="label", name='lmChar2'..vchar, caption=atual}.style.font="charxpmod_font_17b"
if PontosXP>=custo and atual<=Max  then tabUpgrades.add{type="sprite-button", sprite = "charxpmod_img_button_add", style = mod_gui.button_style, tooltip={'xp_costbt',custo},name='btLVU_'..vchar} else
     tabUpgrades.add{type="label", name='lmChar3'..vchar, caption='      ', tooltip={'xp_costbt',custo}} end
  
  local vchar = 'global.personalxp.LV_Mining_Speed'
  atual = global.personalxp.LV_Mining_Speed[nome]
  local custo = 1
  tabUpgrades.add{type="label", name='lmChar1'..vchar, caption={vchar}, tooltip={'xp_hint_'..vchar,20}}
  tabUpgrades.add{type="label", name='lmChar2'..vchar, caption=atual}.style.font="charxpmod_font_17b"
if PontosXP>=custo and atual<=Max  then tabUpgrades.add{type="sprite-button", sprite = "charxpmod_img_button_add", style = mod_gui.button_style, tooltip={'xp_costbt',custo},name='btLVU_'..vchar} else
     tabUpgrades.add{type="label", name='lmChar3'..vchar, caption='      ', tooltip={'xp_costbt',custo}} end

--[[
  local vchar = 'global.personalxp.LV_Build_Dist'
  atual = global.personalxp.LV_Build_Dist[nome]
  tabUpgrades.add{type="label", name='lmChar1'..vchar, caption={vchar}, tooltip={'xp_hint_'..vchar,20}}
  tabUpgrades.add{type="label", name='lmChar2'..vchar, caption=atual}.style.font="charxpmod_font_17b"
if PontosXP>=custo and atual<=Max  then tabUpgrades.add{type="sprite-button", sprite = "charxpmod_img_button_add", style = mod_gui.button_style, tooltip={'xp_costbt',custo},name='btLVU_'..vchar} else
     tabUpgrades.add{type="label", name='lmChar3'..vchar, caption='    '} end
]]
	 
  local vchar = 'global.personalxp.LV_Reach_Dist'
  atual = global.personalxp.LV_Reach_Dist[nome]
  local custo = 1
  tabUpgrades.add{type="label", name='lmChar1'..vchar, caption={vchar}, tooltip={'xp_hint_'..vchar,1}}
  tabUpgrades.add{type="label", name='lmChar2'..vchar, caption=atual}.style.font="charxpmod_font_17b"
  if PontosXP>=custo and atual<=Max  then tabUpgrades.add{type="sprite-button", sprite = "charxpmod_img_button_add", style = mod_gui.button_style, tooltip={'xp_costbt',custo},name='btLVU_'..vchar} else
     tabUpgrades.add{type="label", name='lmChar3'..vchar, caption='      ', tooltip={'xp_costbt',custo}} end

  local vchar = 'global.personalxp.LV_Inv_Bonus'
  atual = global.personalxp.LV_Inv_Bonus[nome]
  local custo = 1
  tabUpgrades.add{type="label", name='lmChar1'..vchar, caption={vchar}, tooltip={'xp_hint_'..vchar,5}}
  tabUpgrades.add{type="label", name='lmChar2'..vchar, caption=atual}.style.font="charxpmod_font_17b"
  if PontosXP>=custo and atual<=Max  then tabUpgrades.add{type="sprite-button", sprite = "charxpmod_img_button_add", style = mod_gui.button_style, tooltip={'xp_costbt',custo},name='btLVU_'..vchar} else
     tabUpgrades.add{type="label", name='lmChar3'..vchar, caption='      ', tooltip={'xp_costbt',custo}} end

--[[	 
  local vchar = 'global.personalxp.LV_InvQB_Bonus'
  atual = global.personalxp.LV_InvQB_Bonus[nome]
  local custo = 2
  Max = 5
  tabUpgrades.add{type="label", name='lmChar1'..vchar, caption={vchar}, tooltip={'xp_hint_'..vchar,10}}
  tabUpgrades.add{type="label", name='lmChar2'..vchar, caption=atual}.style.font="charxpmod_font_17b"
  if PontosXP>=custo and atual<=Max  then tabUpgrades.add{type="sprite-button", sprite = "charxpmod_img_button_add", style = mod_gui.button_style, tooltip={'xp_costbt',custo},name='btLVU_'..vchar} else
     tabUpgrades.add{type="label", name='lmChar3'..vchar, caption='      ', tooltip={'xp_costbt',custo}} end
]]	 
 
  Max = 20
  local vchar = 'global.personalxp.LV_InvLog_Bonus'
  atual = global.personalxp.LV_InvLog_Bonus[nome]
  local custo = 1
  tabUpgrades.add{type="label", name='lmChar1'..vchar, caption={vchar}, tooltip={'xp_hint_'..vchar,5}}
  tabUpgrades.add{type="label", name='lmChar2'..vchar, caption=atual}.style.font="charxpmod_font_17b"
  if PontosXP>=custo and atual<=Max  then tabUpgrades.add{type="sprite-button", sprite = "charxpmod_img_button_add", style = mod_gui.button_style, tooltip={'xp_costbt',custo},name='btLVU_'..vchar} else
     tabUpgrades.add{type="label", name='lmChar3'..vchar, caption='      ', tooltip={'xp_costbt',custo}} end

  local vchar = 'global.personalxp.LV_InvTrash_Bonus'
  atual = global.personalxp.LV_InvTrash_Bonus[nome]
  local custo = 1
  tabUpgrades.add{type="label", name='lmChar1'..vchar, caption={vchar}, tooltip={'xp_hint_'..vchar,5}}
  tabUpgrades.add{type="label", name='lmChar2'..vchar, caption=atual}.style.font="charxpmod_font_17b"
  if PontosXP>=custo and atual<=Max  then tabUpgrades.add{type="sprite-button", sprite = "charxpmod_img_button_add", style = mod_gui.button_style, tooltip={'xp_costbt',custo},name='btLVU_'..vchar} else
     tabUpgrades.add{type="label", name='lmChar3'..vchar, caption='      ', tooltip={'xp_costbt',custo}} end

  local vchar = 'global.personalxp.LV_Robot_Bonus'
  atual = global.personalxp.LV_Robot_Bonus[nome]
  local custo = 1
  tabUpgrades.add{type="label", name='lmChar1'..vchar, caption={vchar}, tooltip={'xp_hint_'..vchar,5}}
  tabUpgrades.add{type="label", name='lmChar2'..vchar, caption=atual}.style.font="charxpmod_font_17b"
  if PontosXP>=custo and atual<=Max  then tabUpgrades.add{type="sprite-button", sprite = "charxpmod_img_button_add", style = mod_gui.button_style, tooltip={'xp_costbt',custo},name='btLVU_'..vchar} else
     tabUpgrades.add{type="label", name='lmChar3'..vchar, caption='      ', tooltip={'xp_costbt',custo}} end
	 
local pickbutton = frame.add{type = "checkbox", name = "cb_pick_extender", caption={'xp_opt_Pick_Extender'}, state = global.personalxp.opt_Pick_Extender[nome]}

---
   frame.add{type="label", name='blankL4', caption=' '}
  
   
  --TAG 

  local frametag = frame.add{type="frame", name="char_frametag", direction = "horizontal", style=mod_gui.frame_style} 
		frametag.style.minimal_width = 455
		frametag.style.maximal_width = 455

  local tabtag = frametag.add{type = "table", name = "tabchartag", column_count = 3}	
  tabtag.add{type="label", name="lab_ctag", caption="Tag  "}
  tabtag.add{type="textfield", name="ctag_field", text=player.tag}
  local btTagOK= tabtag.add{name="btTagCharOK", type="button", style = mod_gui.button_style, caption='OK'}
  end


function ListAll(player)
expand_char_gui(player)
expand_char_gui(player)  
  
  local force = player.force
  local painel = player.gui.center["char-panel"]
  local frame = painel.tabcharScroll
  
  
  frame.add{type="label", name='lbxplayerlst', caption=Players}.style.font="charxpmod_font_20"
  local tabpllst = frame.add{type = "table", name = "tabpllst", column_count = 3}
  for p,PL in pairs (force.players) do

	local ptime = PL.online_time
	local txtPTime = string.format("%d:%02d", math.floor(ptime / 216000), math.floor(ptime / 3600) % 60)
	local ratioXP = math.floor(RatioXP(PL) * 100)
	tabpllst.add{type="label", name='pllstname'..p, caption=PL.name .. ' '..global.personalxp.Level[PL.name] .. ' (' ..txtPTime.. ' '..ratioXP..'%)'}
	end
end  
  

function ListXPTable(player)
player.print('XP Level Table:')
for k=1,20 do
	player.print('Level '.. k .. ' - ' .. global.xp_table[k] )
	end
end
  
  
  
  
function CalculateXP_PB(player)
local nome = player.name
local Level = global.personalxp.Level[nome] 
local XP = global.personalxp.XP[nome] 
if XP > global.max_xp then XP = global.max_xp end
local NextLevel = global.xp_table[Level]
local XP_ant
if Level==1 then XP_ant = 0 else XP_ant = global.xp_table[Level-1] end
local Interval_XP = NextLevel - XP_ant
local pbvalue = (XP-XP_ant)/Interval_XP
return pbvalue
end


  
function UpdatePanel(player)
-- BARRA DE XP  tabtopframexp
local TopXPbar = player.gui.top.chartopframe.tabtopframexp.TopXPbar
local txtlv    = player.gui.top.chartopframe.tabtopframexp.chartoplvtxt

local Level = global.personalxp.Level[player.name] 
local pbvalue = CalculateXP_PB(player)

txtlv.caption={'actual_lv',Level}
TopXPbar.value=pbvalue

local frame = player.gui.center["char-panel"]
    if frame then
	local textImput = player.gui.center["char-panel"].tabcharScroll.char_frametag.tabchartag.ctag_field.text
	if player.tag~=textImput then return end
	expand_char_gui(player)
	expand_char_gui(player)
	end

end

function expand_char_gui(player)
    local frame = player.gui.center["char-panel"]
    if frame then
        frame.destroy()
    else
	local  wid = 530
		frame = player.gui.center.add{type="frame", name="char-panel", direction = "vertical", style=mod_gui.frame_style, caption={"panel-title"}} 
		frame.style.minimal_height = 430
  		--frame.style.maximal_height = 430
		frame.style.minimal_width = wid
		frame.style.maximal_width = 485
		local tabcharScroll = frame.add{type = "scroll-pane", name= "tabcharScroll", vertical_scroll_policy="auto", horizontal_scroll_policy="auto"}
		tabcharScroll.style.minimal_height = 400
		--tabcharScroll.style.maximal_height = 1000
		tabcharScroll.style.minimal_width = wid - 15
		tabcharScroll.style.maximal_width = wid - 15
		update_char_panel(player) 
    end
end


function UpdatePlayerLvStats(player)
local name=player.name

if player.character ~= nil then
 	player.character.character_crafting_speed_modifier = global.personalxp.LV_Craft_Speed[name] / 5
	player.character.character_mining_speed_modifier =  global.personalxp.LV_Mining_Speed[name] /5
	player.character.character_running_speed_modifier  =  global.personalxp.LV_Run_Speed[name] / 5
	player.character.character_build_distance_bonus   =  global.personalxp.LV_Reach_Dist[name]	
	player.character.character_reach_distance_bonus   =  global.personalxp.LV_Reach_Dist[name]
	player.character.character_item_drop_distance_bonus = global.personalxp.LV_Reach_Dist[name]
	player.character.character_resource_reach_distance_bonus = global.personalxp.LV_Reach_Dist[name]
	player.character.character_inventory_slots_bonus    =  global.personalxp.LV_Inv_Bonus[name] * 5
--	player.character.quickbar_count_bonus    =  global.personalxp.LV_InvQB_Bonus[name]
	player.character.character_logistic_slot_count_bonus    =  global.personalxp.LV_InvLog_Bonus[name] * 5
	player.character.character_trash_slot_count_bonus =  global.personalxp.LV_InvTrash_Bonus[name] * 5
	player.character.character_maximum_following_robot_count_bonus =  global.personalxp.LV_Robot_Bonus[name] * 5
	player.character.character_health_bonus =  global.personalxp.LV_Health_Bonus[name] * 50

	if global.personalxp.opt_Pick_Extender[name] then 
		player.character.character_item_pickup_distance_bonus = global.personalxp.LV_Reach_Dist[name]
		player.character.character_loot_pickup_distance_bonus = global.personalxp.LV_Reach_Dist[name]
		else 
		player.character.character_item_pickup_distance_bonus = 0
		player.character.character_loot_pickup_distance_bonus = 0
		end
		
script.raise_event(on_player_updated_status, {player_index = player.index, player_level = global.personalxp.Level[name]})
end


end



-- this will calculate the stat using sum, instead of replacing the value
-- used for compatibility with other mods
function AdjustPlayerStat(player,stat)
local name=player.name

if player.character ~= nil then
if     stat=='character_crafting_speed_modifier' then 
   player.character[stat] = player.character[stat] + global.personalxp.LV_Craft_Speed[name] / 5
elseif stat=='character_running_speed_modifier' then
   player.character[stat] = player.character[stat] + global.personalxp.LV_Run_Speed[name] / 5
elseif stat=='character_build_distance_bonus' then
   player.character[stat] = player.character[stat] + global.personalxp.LV_Reach_Dist[name]
elseif stat=='character_reach_distance_bonus' then
   player.character[stat] = player.character[stat] + global.personalxp.LV_Reach_Dist[name]
elseif stat=='character_item_drop_distance_bonus' then
   player.character[stat] = player.character[stat] + global.personalxp.LV_Reach_Dist[name]
elseif stat=='character_resource_reach_distance_bonus' then
   player.character[stat] = player.character[stat] + global.personalxp.LV_Reach_Dist[name]
elseif stat=='character_inventory_slots_bonus' then
   player.character[stat] = player.character[stat] + global.personalxp.LV_Inv_Bonus[name]*5
--elseif stat=='quickbar_count_bonus' then
--   player.character[stat] = player.character[stat] + global.personalxp.LV_InvQB_Bonus[name]
elseif stat=='character_logistic_slot_count_bonus' then
   player.character[stat] = player.character[stat] + global.personalxp.LV_InvLog_Bonus[name]*5
elseif stat=='character_trash_slot_count_bonus' then
   player.character[stat] = player.character[stat] + global.personalxp.LV_InvTrash_Bonus[name]*5
elseif stat=='character_maximum_following_robot_count_bonus' then
   player.character[stat] = player.character[stat] + global.personalxp.LV_Robot_Bonus[name]*5
elseif stat=='character_health_bonus' then
   player.character[stat] = player.character[stat] + global.personalxp.LV_Health_Bonus[name]*50
elseif stat=='character_item_pickup_distance_bonus' then
	 if global.personalxp.opt_Pick_Extender[name] then 
        player.character[stat] = player.character[stat] + global.personalxp.LV_Reach_Dist[name] end
elseif stat=='character_loot_pickup_distance_bonus' then
	 if global.personalxp.opt_Pick_Extender[name] then 
        player.character[stat] = player.character[stat] + global.personalxp.LV_Reach_Dist[name] end
	end
   
end
 	
end



function LevelUPPlayer(player,btname)

local name=player.name
if btname=='btLVU_global.personalxp.LV_Craft_Speed' then
	global.personalxp.LV_Craft_Speed[name] = global.personalxp.LV_Craft_Speed[name] + 1

elseif btname=='btLVU_global.personalxp.LV_Mining_Speed' then
	global.personalxp.LV_Mining_Speed[name] =  global.personalxp.LV_Mining_Speed[name] + 1

elseif btname=='btLVU_global.personalxp.LV_Run_Speed' then
	global.personalxp.LV_Run_Speed[name] =  global.personalxp.LV_Run_Speed[name] + 1

elseif btname=='btLVU_global.personalxp.LV_Build_Dist' then
	global.personalxp.LV_Build_Dist[name] =  global.personalxp.LV_Build_Dist[name] + 1

elseif btname=='btLVU_global.personalxp.LV_Reach_Dist' then
	global.personalxp.LV_Reach_Dist[name] =  global.personalxp.LV_Reach_Dist[name] + 1
	
elseif btname=='btLVU_global.personalxp.LV_Inv_Bonus' then
	global.personalxp.LV_Inv_Bonus[name] =  global.personalxp.LV_Inv_Bonus[name] + 1

--elseif btname=='btLVU_global.personalxp.LV_InvQB_Bonus' then
--	global.personalxp.LV_InvQB_Bonus[name] =  global.personalxp.LV_InvQB_Bonus[name] + 1

elseif btname=='btLVU_global.personalxp.LV_InvLog_Bonus' then
	global.personalxp.LV_InvLog_Bonus[name] =  global.personalxp.LV_InvLog_Bonus[name] + 1

elseif btname=='btLVU_global.personalxp.LV_InvTrash_Bonus' then
	global.personalxp.LV_InvTrash_Bonus[name] =  global.personalxp.LV_InvTrash_Bonus[name] + 1
	
elseif btname=='btLVU_global.personalxp.LV_Robot_Bonus' then
	global.personalxp.LV_Robot_Bonus[name] =  global.personalxp.LV_Robot_Bonus[name] + 1

elseif btname=='btLVU_global.personalxp.LV_Health_Bonus' then
	global.personalxp.LV_Health_Bonus[name] =  global.personalxp.LV_Health_Bonus[name] + 1
end
  
UpdatePlayerLvStats(player)
	
end



script.on_nth_tick(1200,function (event)
XP_UPDATE_tick()
end)


function Cria_Player(event) 
local player = game.players[event.player_index]
SetupPlayer(player,true)
end


function on_force_created(event) 
local name = event.force.name
SetForceValues(name)
end


function onPlayerJoin(event)
local player = game.players[event.player_index]
CheckPlayer(player)
InitPlayerGui(player)
end


function On_Init() 
XPModSetup()
end




function on_configuration_changed(data)
XPModSetup()
end

script.on_event(defines.events.on_player_created, Cria_Player)
script.on_event(defines.events.on_player_joined_game, onPlayerJoin)
--script.on_event(defines.events.on_tick, on_tick )
script.on_event(defines.events.on_force_created,on_force_created)
script.on_configuration_changed(on_configuration_changed)
script.on_init(On_Init)
script.on_event("key-I", function(event) expand_char_gui(game.players[event.player_index]) end)

local function on_gui_click(event)

local player = game.players[event.element.player_index]
local name = event.element.name

    if (name == "btcharxp") then
        expand_char_gui(player)
    elseif (name == "btTagCharOK")then
		local textImput = player.gui.center["char-panel"].tabcharScroll.char_frametag.tabchartag.ctag_field.text
		
		if textImput == "{reset-points}" then 
			if player.admin then
				expand_char_gui(player) 
				ResetPointSpent()
				game.print({'xp_reset_altert'})
				end
			return 
		elseif textImput == "{reset-all}" then 
			if player.admin then
				expand_char_gui(player) 
				ResetAll()
				game.print({'xp_reset_altert'})
				end
			return 			
		elseif textImput == "{list}" then 
			ListAll(player) 
			player.gui.center["char-panel"].tabcharScroll.char_frametag.tabchartag.ctag_field.text = "{list}"
			return 
		elseif textImput == "{listXPTable}" then 
			ListXPTable(player) 
			return 
			end
			
			
		
		player.tag = textImput
		expand_char_gui(player)
	
	elseif string.sub(name,1,6)=='btLVU_' then
		if player.character ~= nil then
		LevelUPPlayer(player,name)
		expand_char_gui(player)
		expand_char_gui(player)
		end

	elseif name == "cb_pick_extender" then
		if player.character == nil then
			player.gui.center["char-panel"].tabcharScroll.cb_pick_extender.state = global.personalxp.opt_Pick_Extender[player.name]
			return
			end
		local cb_pick_extender = player.gui.center["char-panel"].tabcharScroll.cb_pick_extender.state
		global.personalxp.opt_Pick_Extender[player.name] = cb_pick_extender
		UpdatePlayerLvStats(player)
	end
	
end
script.on_event(defines.events.on_gui_click, on_gui_click)


-- ANTI RESPAWN EVENT DEPENDENCY
script.on_nth_tick(60*21, function (event)
for p, PL in pairs (game.connected_players) do 
	if PL.valid and PL.character and PL.character.valid then
		local name = PL.name
		if (PL.character.character_crafting_speed_modifier==0 and global.personalxp.LV_Craft_Speed[name]>0) or
		   (PL.character.character_running_speed_modifier==0  and global.personalxp.LV_Mining_Speed[name]>0) then
			UpdatePlayerLvStats(PL) end
		end
	end
end)


script.on_event(defines.events.on_player_respawned, function(event)
local player = game.players[event.player_index]
UpdatePlayerLvStats(player)
end)

script.on_event(defines.events.on_pre_player_died, function(event)
local player = game.players[event.player_index]
local name = player.name
local XP = global.personalxp.XP[name] 
local Level = global.personalxp.Level[name] 
local NextLevel = global.xp_table[Level]
local XP_ant
if Level==1 then XP_ant = 0 else XP_ant = global.xp_table[Level-1] end
local Interval_XP = NextLevel - XP_ant
local Penal = math.floor((XP-XP_ant)*settings.global["charxpmod_afk"].value/100)
global.personalxp.Death[name] = global.personalxp.Death[name]+1

if Penal>0 then 
global.personalxp.XP[name] = global.personalxp.XP[name]-Penal
player.print({'xp_lost'})
player.print(Penal)
end

end)




--- XP FOR KILL
script.on_event(defines.events.on_entity_died, function(event)

if event.force == nil then return end

local force=event.force.name  -- force that kill
local killer=event.cause


if event.entity.force.name == 'enemy' and force~='neutral' and force~='enemy' then --aliens
	local XP = event.entity.prototype.max_health

	if event.entity.type == 'unit' then
		global.kills_units[force] = global.kills_units[force] + 1
		elseif event.entity.type == 'unit-spawner' then
		XP = XP * 2.5
		global.kills_spawner[force] = global.kills_spawner[force] +1
		elseif event.entity.type == 'turret' then
		global.kills_worms[force] = global.kills_worms[force] +1
		end
	if XP > 999999 then XP=999999 end
	XP = math.ceil(XP_Mult * XP/100) 
	if XP<1 then XP=1 end

	local teamxp = true

--[[	if killer~=nil then
	if killer.valid then
		if killer.type=='player' then
			local plname = killer.player.name
			global.personalxp.XP[plname] = global.personalxp.XP[plname] + XP
			teamxp = false
			end 
		end
		end ]]

	if teamxp then
		global.XP_KILL_HP[force] = global.XP_KILL_HP[force] + XP
		global.XP[force] = global.XP[force] + XP
		end
	end


end)


-- XP by research
script.on_event(defines.events.on_research_finished, function(event)
if event.research.force ~= nil then
	local force = event.research.force.name
	if force~='neutral' and force~='enemy' then
	if global.XP_TECH[force] then
		local techXP = event.research.research_unit_count * #event.research.research_unit_ingredients
		techXP = math.ceil(XP_Mult * techXP * (1+ (6*game.forces["enemy"].evolution_factor)))		
		global.XP_TECH[force] = global.XP_TECH[force]  +techXP
		global.XP[force] = global.XP[force]  +techXP 
		end
	end
	end
end)

-- XP by Rocket
script.on_event(defines.events.on_rocket_launched, function(event)
local rocket = event.rocket
local force = rocket.force
local XP

	for p, PL in pairs (force.connected_players) do 
		local r_count = global.personalxp.rocketsXP_count[PL.name]
		if r_count == nil then r_count=0 end
		XP = math.ceil(XP_Mult * global.personalxp.XP[PL.name]/(5+(r_count*2))) --20% inicial
		global.personalxp.XP[PL.name] = global.personalxp.XP[PL.name] + XP
		printXP(PL,XP)
		global.personalxp.rocketsXP_count[PL.name] = r_count+1
	end
end)


--- XP FOR Mining rocks, trees
function XPByMiningRT(plname,rock)
local XP = 0
if rock == "rock-huge" then XP=10 
   elseif rock == "rock-big" or rock == "sand-rock-big" then XP=5 
   elseif rock == "tree" then XP=1 
   end
   
    
   
if XP>0 then 
   XP = math.ceil(XP * global.personalxp.Level[plname] * XP_Mult)
   global.personalxp.XP[plname] = global.personalxp.XP[plname] + XP
   end

end


script.on_event(defines.events.on_player_mined_entity, function(event)
local player = game.players[event.player_index]	
if not player.valid then return end
local plname = player.name
local name=event.entity.name
if event.entity.type=='tree' then name='tree' end
XPByMiningRT(plname,name)
end)


-- INTERFACE  --
--------------------------------------------------------------------------------------
-- /c remote.call("RPG","TeamXP","player",150)
local interface = {}

-- Give XP to Team (may be negative)
function interface.TeamXP(forcename,XP)
global.XP[forcename] = global.XP[forcename] + XP
end

-- Give XP to a player (may be negative)
function interface.PlayerXP(playername,XP)
global.personalxp.XP[playername] = global.personalxp.XP[playername] + XP
printXP(game.players[playername],XP)
end

-- Give a fixed XP multiplyed by player level (may be negative)
function interface.PlayerXPPerLevel(playername,XP)
global.personalxp.XP[playername] = global.personalxp.XP[playername] + (XP * global.personalxp.Level[playername])
end

-- Used only for compatibility with other mods
function interface.OtherEventsByPlayer(player,event_name,parameter)
if event_name=='mine_rock' then 
   XPByMiningRT(player.name,parameter) 
   end
if event_name=='adjust_player_stats' then 
   AdjustPlayerStat(player,parameter) 
   end
end


-- Give a player a XP % of his own XP
function interface.PlayerXPPerc(playername,Perc)
local XP = math.ceil(global.personalxp.XP[playername]*Perc/100) 
global.personalxp.XP[playername] = global.personalxp.XP[playername] + XP
printXP(game.players[playername],XP)
end

-- Penalty XP for a % of his own XP
function interface.PlayerXPPenalPerc(playername,Perc)
global.personalxp.XP[playername] = global.personalxp.XP[playername] - math.ceil(global.personalxp.XP[playername]*Perc/100) 
end


-- Give all force players a XP% of his own XP
function interface.TeamXPPerc(forcename,Perc)
local XP
	for p, PL in pairs (game.forces[forcename].connected_players) do 
		XP = math.ceil(global.personalxp.XP[PL.name]*Perc/100) 
		global.personalxp.XP[PL.name] = global.personalxp.XP[PL.name] + XP
		printXP(PL,XP)
	end
end

function interface.ResetAll()
ResetAll()
end


--[[ HOW TO subscribe to my 2 events below:
	script.on_event(remote.call("RPG", "get_on_player_updated_status"), function(event)
		--do your stuff
	end)
	WARNING: this has to be done within on_init and on_load, otherwise the game will error about the remote.call
	
	if your dependency on my mod is optional, remember to check if the remote interface exists before calling it:
	if remote.interfaces["RPG"] then
		--interface exists
	end]]
	
function interface.get_on_player_updated_status()
return on_player_updated_status
end
function interface.get_on_player_level_up()
return on_player_level_up
end
		-- Returns :
		-- event.player_index = Index of the player that placed the portal, which is the player the portal belongs to
		-- event.level        = Player current XP Level 


remote.add_interface("RPG", interface )
