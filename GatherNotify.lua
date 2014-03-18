GN = {}

-- Table format: {level, prettyName, objectName}
-- If prettyName is nil, it's only used for modifying object tooltips, it should not be reported in chat that it is now mineable
-- If objectName is missing, it's assumed that it's the same as prettyName (as in most herbs)

GN.mining_levels = {
	{1,   "Copper", 		"Copper Vein"},
	{1,   "Tin",			"Tin Vein"},
	{1,   nil,				"Black Blood of Yogg-Saron"},
	{50,  "Silver",			"Silver Vein"},
	{50,  nil,				"Incendicite Mineral Vein"},
	{65,  nil, 				"Lesser Bloodstone Deposit"},
	{100, "Iron",			"Iron Deposit"},
	{115, "Gold",			"Gold Vein"},
	{150, "Mithril",		"Mithril Deposit"},
	{150, nil,				"Ooze Covered Mithril Deposit"},
	{165, "Truesilver",		"Truesilver Deposit"},
	{165, nil,				"Ooze Covered Truesilver Deposit"},
	{175, "Dark Iron",		"Dark Iron Deposit"},
	{200, "Small Thorium",	"Small Thorium Vein"},
	{200, nil,				"Ooze Covered Thorium Vein"},
	{215, "Rich Thorium",	"Rich Thorium Vein"},
	{215, nil,				"Ooze Covered Rich Thorium Vein"},
	{275, "Fel Iron",		"Fel Iron Deposit"},
	{275, nil,				"Nethercite Deposit"},
	{305, nil,				"Small Obsidian Chunk"},
	{305, nil,				"Large Obsidian Chunk"},
	{325, "Adamantite",		"Adamantite Deposit"},
	{350, "Rich Adamantite","Rich Adamantite Deposit"},
	{350, "Cobalt",			"Cobalt Deposit"},
	{375, "Khorium",		"Khorium Vein"},
	{375, nil,				"Ancient Gem Vein"},
	{375, "Rich Cobalt",	"Rich Cobalt Deposit"},
	{400, "Saronite",		"Saronite Deposit"},
	{425, "Rich Saronite",	"Rich Saronite Deposit"},
	{425, "Obsidium",		"Obsidium Deposit"},
	{450, nil,				"Pure Saronite Deposit"},
	{450, "Rich Obsidium",	"Rich Obsidium Deposit"},
	{450, "Titanium",		"Titanium Vein"},
	{475, "Elementium",		"Elementium Vein"},
	{500, "Rich Elementium","Rich Elementium Vein"},
	{525, "Pyrite",			"Pyrite Deposit"},
	{525, "Rich Pyrite",	"Rich Pyrite Deposit"},
	
	{1, "Ghost Iron",		"Ghost Iron Deposit"},		-- Originally 500
	{1, "Rich Ghost Iron",	"Rich Ghost Iron Deposit"},	-- Originally 550
	{1, "Kyparite",			"Kyparite Deposit"},		-- Originally 550
	{1, "Rich Kyparite",	"Rich Kyparite Deposit"},	-- Originally 575
	{1, "Trillium",			"Trillium Vein"},			-- Originally 600
	{1, "Rich Trillium",	"Rich Trillium Vein"}		-- Originally 600
}

GN.herbalism_levels = {
	{1,   "Peacebloom"},
	{1,   "Silverleaf"},
	{1,   "Earthroot"},
	{1,   "Mageroyal"},
	{1,   "Briarthorn"},
	{1,   "Bruiseweed"},
	{1,   nil, "Bloodthistle"},
	{85,  "Stranglekelp"},
	{105, "Grave Moss"},
	{115, "Wild Steelbloom"},
	{125, "Kingsblood"},
	{150, "Liferoot"},
	{150, "Fadeleaf"},
	{150, "Goldthorn"},
	{160, "Khadgar's Whisker"},
	{195, "Dragon's Teeth"},
	{205, "Firebloom"},
	{210, "Purple Lotus"},
	{220, "Arthas' Tears"},
	{230, "Sungrass"},
	{235, "Blindweed"},
	{245, "Ghost Mushroom"},
	{250, "Gromsblood"},
	{260, "Golden Sansam"},
	{270, "Dreamfoil"},
	{280, "Mountain Silversage"},
	{285, "Sorrowmoss"},
	{290, "Icecap"},
	{300, "Black Lotus"},
	{300, "Felweed"},
	{315, "Dreaming Glory"},
	{325, "Terocone"},
	{325, "Ragveil"},
	{335, "Flame Cap"},
	{340, "Ancient Lichen"},
	{350, "Netherbloom"},
	{350, nil, "Netherdust Bush"},
	{350, "Goldclover"},
	{360, "Fire Leaf", "Firethorn"},
	{365, "Nightmare Vine"},
	{375, "Mana Thistle"},
	{375, "Tiger Lily"},
	{385, "Talandra's Rose"},
	{400, "Adder's Tongue"},
	{400, "Frozen Herb"},
	{425, "Lichbloom"},
	{425, "Cinderbloom"},
	{425, "Azshara's Veil"},
	{425, "Stormvine"},
	{435, "Icethorn"},
	{450, "Frost Lotus"},
	{475, "Heartblossom"},
	{500, "Whiptail"},
	{525, "Twilight Jasmine"},
	
	{1, 	"Green Tea Leaf"},		-- Originally 500
	{1, 	"Rain Poppy"},			-- Originally 525
	{1, 	"Silkweed"},			-- Originally 545
	{1, 	"Golden Lotus"},		-- Originally 550
	{1, 	"Snow Lily"},			-- Originally 575
	{1,		"Sha-Touched Herb"},	-- Originally 575
	{1, 	"Fool's Cap"}			-- Originally 600
}

GN.skinning_levels = {
	{1, nil, "1"},
	{1, nil, "2"},
	{1, nil, "3"},
	{1, nil, "4"},
	{1, nil, "5"},
	{1, nil, "6"},
	{1, nil, "7"},
	{1, nil, "8"},
	{1, nil, "9"},
	{1, nil, "10"},
	{10, "11"},
	{20, "12"},
	{30, "13"},
	{40, "14"},
	{50, "15"},
	{60, "16"},
	{70, "17"},
	{80, "18"},
	{90, "19"},
	{100, "20"},
	{105, "21"},
	{110, "22"},
	{115, "23"},
	{120, "24"},
	{125, "25"},
	{130, "26"},
	{135, "27"},
	{140, "28"},
	{145, "29"},
	{150, "30"},
	{155, "31"},
	{160, "32"},
	{165, "33"},
	{170, "34"},
	{175, "35"},
	{180, "36"},
	{185, "37"},
	{190, "38"},
	{195, "39"},
	{200, "40"},
	{205, "41"},
	{210, "42"},
	{215, "43"},
	{220, "44"},
	{225, "45"},
	{230, "46"},
	{235, "47"},
	{240, "48"},
	{245, "49"},
	{250, "50"},
	{255, "51"},
	{260, "52"},
	{265, "53"},
	{270, "54"},
	{275, "55"},
	{280, "56"},
	{285, "57"},
	{290, "58"},
	{295, "59"},
	{300, "60"},
	{305, "61"},
	{310, "62"},
	{315, "63"},
	{320, "64"},
	{325, "65"},
	{330, "66"},
	{335, "67"},
	{340, "68"},
	{345, "69"},
	{350, "70"},
	{355, "71"},
	{360, "72"},
	{365, "73"},
	{375, "74"},
	{385, "75"},
	{395, "76"},
	{405, "77"},
	{415, "78"},
	{425, "79"},
	{435, "80"},
	{440, "81"},
	{445, "82"},
	{450, "83"},
	{455, "84"},
	{470, "85"},
	{485, "86"},
	{500, "87"},
	{520, "88"},
	{540, "89"},
	{560, "90"},
}

--- Events ---

function GN.OnLoad(self)						-- Fired when the addon is loaded
	self:RegisterEvent("CHAT_MSG_SKILL")
	GameTooltip:HookScript("OnShow",GN.ModifyTooltip)
	
	GN.origErrorFunc = UIErrorsFrame:GetScript('OnEvent')
	UIErrorsFrame:SetScript('OnEvent', GN.OnUIError)
	
	SLASH_GN1, SLASH_GN2, SLASH_GN3 = '/gn', '/gathernotify', '/gnotify'
	SlashCmdList["GN"] = GN.OnCommand
end

function GN.OnEvent(self, event, ...)			-- Fired on a registered event
	GN.Debug("event : " .. event)
	if event == "CHAT_MSG_SKILL" then
		local skill = strmatch(...,"Your skill in (%a*) has increased to")
		if skill == "Mining" or skill == "Herbalism" or skill == "Skinning" then
			local level,temp = GN.GetProfessionLevel(skill)
			
			----- First, print if you can mine something new, without taking temp bonuses into account -----
			local new = GN.GetAllGatherable(skill,level)
			
			if new then
				local tempmsg = ""
				if temp>0 then tempmsg = " (without current |cff1aff1a+"..temp.."|cffFFC300 bonus)" end
				
					if skill == "Skinning"	then GN.Msg("Now able to skin level "..new.." creatures"..tempmsg,true)
				elseif skill == "Mining"	then GN.Msg("Now able to mine "..new..tempmsg,true)
				elseif skill == "Herbalism"	then GN.Msg("Now able to pick "..new..tempmsg,true)
				end
			end
			----- End -----
			
			----- Now, print if you can mine something new, WITH temp bonuses, but only if it differs from without bonuses -----
			local newtemp = GN.GetAllGatherable(skill,level+temp)
			
			if newtemp and newtemp ~= new then
				local tempmsg = ""
				if temp>0 then tempmsg = " (with current |cff1aff1a+"..temp.."|cffFFC300 bonus)" end
				
					if skill == "Skinning"	then GN.Msg("Now able to skin level "..newtemp.." creatures"..tempmsg,true)
				elseif skill == "Mining"	then GN.Msg("Now able to mine "..newtemp..tempmsg,true)
				elseif skill == "Herbalism"	then GN.Msg("Now able to pick "..newtemp..tempmsg,true)
				end
			end
			----- End -----
		end
	end
end

function GN.OnCommand(cmd)						-- Fired when a slash command is entered
	cmd = cmd:lower()
	
	if cmd == "s" or cmd == "skin" or cmd == "skinning" then
		GN.PrintHighestNode("skinning")
	
	elseif cmd == "m" or cmd == "mine" or cmd == "mining" then
		GN.PrintHighestNode("mining")
	
	elseif cmd == "h" or cmd == "herb" or cmd == "herbalism" then
		GN.PrintHighestNode("herbalism")
	
	elseif cmd == "v" or cmd == "ver" or cmd == "version" then
		GN.Msg("GatherNotify version: "..GetAddOnMetadata("GatherNotify","Version"))
	
	else
		GN.Msg("/gn skinning - Print highest level creature you can skin")
		GN.Msg("/gn mining - Print highest node you can mine")
		GN.Msg("/gn herbalism - Print highest herb you can pick")
		GN.Msg("/gn version - Prints addon version")
	end
end

function GN.OnUIError(self, event, err, ...)	-- Fired when a red error is shown at the top of the screen
	local skill = strmatch(err,"Requires (.*) ")
	local rlevel = tonumber(strmatch(err,"Requires .* (%d+)"))
	
	if skill and rlevel then -- Error was a "requires" error
		local level,temp = GN.GetProfessionLevel(skill)
		if level then
			GN.AddError(skill,rlevel,level,temp)
		else
			return GN.origErrorFunc(self, event, err, ...)
		end
	else
		return GN.origErrorFunc(self, event, err, ...)
	end
end

--- Functions ---

function GN.Msg(msg,noname)						-- Print a message to the chat frame
	if noname then
		DEFAULT_CHAT_FRAME:AddMessage("|cffFFC300"..msg)
	else
		DEFAULT_CHAT_FRAME:AddMessage("|cffd2b48c[GatherNotify]|r "..msg)
	end
end

function GN.Debug(...)							-- Print a debug message to the chat frame
	--if GN_Settings.debug then
		local str = table.concat({...}, " ")
		DEFAULT_CHAT_FRAME:AddMessage("|cffff0000[GN]|r " .. str)
	--end
end

function GN.AddError(skill,rlevel,current,temp)	-- Print a modified red error to the top of the screen
	if temp == 0 then
		UIErrorsFrame:AddMessage(string.format("Requires %s %s (currently %s)",skill,rlevel,current),1.0,0.1,0.1,1.0)
	else
		--UIErrorsFrame:AddMessage(string.format("Requires %s %s (currently %s - %s|cff1aff1a+%s|r)",skill,rlevel,current+temp,current,temp),1.0,0.1,0.1,1.0)
		UIErrorsFrame:AddMessage(string.format("Requires %s %s (currently %s|cff1aff1a+%s|r)",skill,rlevel,current,temp),1.0,0.1,0.1,1.0)
	end
end

function GN.GetHighestNode(skill,level)			-- Get the highest herb/mine/corpse usable at the current skill level
	local tbl
		if string.lower(skill) == "skinning" then tbl = GN.skinning_levels
	elseif string.lower(skill) == "mining" then tbl = GN.mining_levels
	elseif string.lower(skill) == "herbalism" then tbl = GN.herbalism_levels
	  else return
	end
	
	local highest = 1
	for i,v in pairs(tbl) do
		if v[1] <= level and v[2] then
			highest = v[1]
		end
	end
	
	return GN.GetAllGatherable(skill,highest)
end

function GN.PrintHighestNode(skill)				-- Print the highest herb/mine/corpse usable at the current skill level
	local level,temp = GN.GetProfessionLevel(skill)
	
	if level then
		----- First, print highest mineable without taking temp bonuses into account -----
		local tempmsg = ""
		if temp>0 and GN.GetHighestNode(skill,level+temp) ~= GN.GetHighestNode(skill,level) then tempmsg = " (without current |cff1aff1a+"..temp.."|cffFFC300 bonus)" end
		if skill == "skinning"	then GN.Msg("Skinning "..level..": level "..GN.GetHighestNode("skinning",level).." creatures"..tempmsg,true) end
		if skill == "mining" 	then GN.Msg("Mining "..level..": "..GN.GetHighestNode("mining",level)..tempmsg,true) end
		if skill == "herbalism"	then GN.Msg("Herbalism "..level..": "..GN.GetHighestNode("herbalism",level)..tempmsg,true) end
		----- End -----
		
		----- Then print highest mineable, taking temp bonuses into account -----
		if found==true then
			if GN.GetHighestNode(skill,level+temp) ~= GN.GetHighestNode(skill,level) then -- Only print what you can mine with current bonus if it differs from without bonus
				tempmsg = ""
				if temp>0 then tempmsg = " (with current |cff1aff1a+"..temp.."|cffFFC300 bonus)" end
				if skill == "skinning"	then GN.Msg("Skinning |cff1aff1a"..level+temp.."|cffFFC300: level "..GN.GetHighestNode("skinning",level+temp).." creatures"..tempmsg,true) end
				if skill == "mining" 	then GN.Msg("Mining |cff1aff1a"..level+temp.."|cffFFC300: "..GN.GetHighestNode("mining",level+temp)..tempmsg,true) end
				if skill == "herbalism"	then GN.Msg("Herbalism |cff1aff1a"..level+temp.."|cffFFC300: "..GN.GetHighestNode("herbalism",level+temp)..tempmsg,true) end
			end
		----- End -----
		end
	else
		GN.Msg("You don't have "..skill)
	end
end

function GN.GetAllGatherable(skill,level)		-- Get a list of all herbs/mines/corpses usable at the current skill level
	local tbl
		if string.lower(skill) == "skinning" then tbl = GN.skinning_levels
	elseif string.lower(skill) == "mining" then tbl = GN.mining_levels
	elseif string.lower(skill) == "herbalism" then tbl = GN.herbalism_levels
	  else return nil
	end
	
	local i2 = 1
	local ret = {}
	for i,v in pairs(tbl) do
		if v[1] == level and v[2] then
			ret[i2] = v[2]
			i2=i2+1
		end
	end
	
	if #ret == 0 then return nil else return table.concat(ret,", ") end
end

function GN.GetRequiredLevel(skill,name)		-- Get the required herbalism/mining/skinning level required to use a node/corpse
	name = tostring(name)
	local tbl,ret
		if string.lower(skill) == "skinning" then tbl = GN.skinning_levels
	elseif string.lower(skill) == "mining" then tbl = GN.mining_levels
	elseif string.lower(skill) == "herbalism" then tbl = GN.herbalism_levels
	  else return
	end
	
	for i,v in pairs(tbl) do
		if (not v[3] and v[2] == name) or v[3] == name then
			ret = v[1]
		end
	end
	
	return ret
end

function GN.GetProfessionLevel(name)			-- Get a profession's level
	local p = {}
	local n,l,t,level,temp
	p[1],p[2],p[3],p[4],p[5],p[6] = GetProfessions()
	for i=1,6 do
		if p[i] then
			n,_,l,_,_,_,_,t = GetProfessionInfo(p[i])
			if n:lower() == name:lower() then
				level = l
				temp = t
			end
		end
	end
	return level,temp
end

function GN.ModifyTooltip(self, ...)			-- Modify an herb's/mine's/corpse's tooltip
	if GameTooltipTextLeft2:GetText() == "Requires Mining" then
		req = GN.GetRequiredLevel("Mining",GameTooltipTextLeft1:GetText())
		r,g,b,a = GameTooltipTextLeft2:GetTextColor()
		if req then GameTooltipTextLeft2:SetText("Requires Mining "..req) end
		local skill,temp = GN.GetProfessionLevel("Mining")
		if skill then
			local tempmsg = ""
			if temp>0 then tempmsg = "|cff1aff1a+"..temp.."|r" end
			if skill and req>skill+temp then GameTooltip:AddLine("Currently "..skill..tempmsg,r,g,b,a) end
		end
		GameTooltip:Show()
	
	elseif GameTooltipTextLeft2:GetText() == "Requires Herbalism" then
		req = GN.GetRequiredLevel("Herbalism",GameTooltipTextLeft1:GetText())
		r,g,b,a = GameTooltipTextLeft2:GetTextColor()
		if req then GameTooltipTextLeft2:SetText("Requires Herbalism "..req) end
		local skill,temp = GN.GetProfessionLevel("Herbalism")
		if skill then
			local tempmsg = ""
			if temp>0 then tempmsg = "|cff1aff1a+"..temp.."|r" end
			if req>skill+temp then GameTooltip:AddLine("Currently "..skill..tempmsg,r,g,b,a) end
		end
		GameTooltip:Show()
	
	elseif UnitExists("mouseover") then -- Is a mob
		local sline = 0
		for i=1,GameTooltip:NumLines() do if _G["GameTooltipTextLeft"..i]:GetText() == "Skinnable" then sline = i end end
		if sline > 0 then
			req = GN.GetRequiredLevel("Skinning",UnitLevel("mouseover"))
			r,g,b,a = _G["GameTooltipTextLeft"..sline]:GetTextColor()
			if req then _G["GameTooltipTextLeft"..sline]:SetText("Skinnable ("..req..")") end
			local skill,temp = GN.GetProfessionLevel("Skinning")
			if skill then
				local tempmsg = ""
				if temp>0 then tempmsg = "|cff1aff1a+"..temp.."|r" end
				if req>skill+temp then GameTooltip:AddLine("Currently "..skill..tempmsg,r,g,b,a) end
			end
			GameTooltip:Show()
		end
	end
end

-- Debug functions

function GN.err(skill,level)					-- Generates a fake error message - GN.err("mining", "500) etc.
	--GN.OnEvent(nil,"UI_ERROR_MESSAGE",string.format("Requires %s %s",skill,level))
	UIErrorsFrame:GetScript("OnEvent")(UIErrorsFrame,"UI_ERROR_MESSAGE", format("Requires %s %s", skill, level))
end

-- Initialize the addon (not using XML)
local frame = CreateFrame("Frame")
GN.OnLoad(frame)
frame:SetScript("OnEvent", GN.OnEvent)