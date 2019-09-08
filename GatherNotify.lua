GatherNotify = {}
GatherNotify.Frame = CreateFrame("Frame")

-- Table format: {level, prettyName, objectName}
-- If prettyName is nil, it's only used for modifying object tooltips, it should not be reported in chat that it is now mineable
-- If objectName is missing, it's assumed that it's the same as prettyName (as in most herbs)

GatherNotify.levels = {
	mining = {
		{1,   "Copper", 		"Copper Vein"},
		{65,  "Tin",			"Tin Vein"},
		{65,  nil,				"Incendicite Mineral Vein"},
		{75,  "Silver",			"Silver Vein"},
		{125, "Iron",			"Iron Deposit"},
		{150, nil,              "Indurium Mineral Vein"},
		{155, nil, 				"Lesser Bloodstone Deposit"},
		{155, "Gold",			"Gold Vein"},
		{175, "Mithril",		"Mithril Deposit"},
		{175, nil,				"Ooze Covered Mithril Deposit"},
		{230, "Truesilver",		"Truesilver Deposit"},
		{230, nil,				"Ooze Covered Truesilver Deposit"},
		{230, "Dark Iron",		"Dark Iron Deposit"},
		{245, "Small Thorium",	"Small Thorium Vein"},
		{245, nil,				"Ooze Covered Thorium Vein"},
		{275, "Rich Thorium",	"Rich Thorium Vein"},
		{275, nil,				"Ooze Covered Rich Thorium Vein"},
		{305, nil,				"Small Obsidian Chunk"},
		{305, nil,				"Large Obsidian Chunk"},
	},
	
	herbalism = {
		{1,   "Peacebloom"},
		{1,   "Silverleaf"},
		{15,  "Earthroot"},
		{50,  "Mageroyal"},
		{70,  "Briarthorn"},
		{85,  "Stranglekelp"},
		{100, "Bruiseweed"},
		{115, "Wild Steelbloom"},
		{120, "Grave Moss"},
		{125, "Kingsblood"},
		{150, "Liferoot"},
		{160, "Fadeleaf"},
		{170, "Goldthorn"},
		{185, "Khadgar's Whisker"},
		{195, "Wintersbite"},
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
		{285, "Plaguebloom"},
		{290, "Icecap"},
		{300, "Black Lotus"},
	},

	skinning = {
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
	}
}

--- Events ---

function GatherNotify.OnEvent(self, event, ...)				-- Fired on a registered event
	if event == "ADDON_LOADED" then
		local addon_name = ...
		if addon_name == "GatherNotify" then
			GameTooltip:HookScript("OnShow", GatherNotify.ModifyTooltip)
			GatherNotify.origErrorFunc = UIErrorsFrame:GetScript('OnEvent')
			UIErrorsFrame:SetScript('OnEvent', GatherNotify.OnUIError)
		end
	
	elseif event == "CHAT_MSG_SKILL" then
		local msg = ...
		C_Timer.After(0.1, function()
			GatherNotify.OnSkillUpMessage(self, msg)
		end)
		
	end
end

function GatherNotify.OnCommand(cmd)						-- Fired when a slash command is entered
	cmd = cmd:lower()
	
	if #cmd > 0 then
		for i = 0,8 do
			if cmd == string.sub("skinning", 1,-i-1) then
				GatherNotify.PrintHighestNode("skinning")
				return
			
			elseif cmd ==string.sub("mining", 1,-i-1) then
				GatherNotify.PrintHighestNode("mining")
				return
			
			elseif cmd == string.sub("herbalism", 1,-i-1) then
				GatherNotify.PrintHighestNode("herbalism")
				return
			
			elseif cmd == string.sub("version", 1,-i-1) then
				GatherNotify.Msg(format("GatherNotify version: |cff1aff1a%s|cffFFC300 (%s)", GetAddOnMetadata("GatherNotify","Version"), GetAddOnMetadata("GatherNotify","X-Date")), true)
				return
			end
		end
	end
	
	GatherNotify.Msg("/gn skinning - Print highest level creature you can skin", true)
	GatherNotify.Msg("/gn mining - Print highest node you can mine", true)
	GatherNotify.Msg("/gn herbalism - Print highest herb you can pick", true)
	GatherNotify.Msg("/gn version - Prints addon version", true)
end

function GatherNotify.OnUIError(self, event, errtype, err)	-- Fired when a red error is shown at the top of the screen
	local skill = strmatch(err,"Requires (.*) ")
	local rlevel = tonumber(strmatch(err,"Requires .* (%d+)"))
	
	if skill and rlevel then -- Error was a "requires" error
		local level,temp = GatherNotify.GetProfessionLevel(skill)
		if level then
			GatherNotify.AddError(skill,rlevel,level,temp)
		else
			return GatherNotify.origErrorFunc(self, event, errtype, err)
		end
	else
		return GatherNotify.origErrorFunc(self, event, errtype, err)
	end
end

function GatherNotify.OnSkillUpMessage(self, msg)			-- Fired when we get a "Your skill in x has increased to y." message
	local skill = strmatch(msg, "Your skill in (%a*) has increased to")
	if skill ~= "Mining" and skill ~= "Herbalism" and skill ~= "Skinning" then return end
	
	local level,temp = GatherNotify.GetProfessionLevel(skill)
	local skillcolor = GatherNotify.GetChatColor("SKILL")
	
	----- First, print if you can mine something new, without taking temp bonuses into account -----
	local new = GatherNotify.GetAllGatherable(skill,level)
	
	if new then
		local tempmsg = ""
		if temp>0 then tempmsg = " (without current |cff1aff1a+"..temp.."|cffFFC300 bonus)" end
		
			if skill == "Skinning"	then GatherNotify.Msg("Now able to skin level "..new.." creatures"..tempmsg, false)
		elseif skill == "Mining"	then GatherNotify.Msg("Now able to mine "..new..tempmsg, false)
		elseif skill == "Herbalism"	then GatherNotify.Msg("Now able to pick "..new..tempmsg, false)
		end
	end
	----- End -----
	
	----- Now, print if you can mine something new, WITH temp bonuses, but only if it differs from without bonuses -----
	local newtemp = GatherNotify.GetAllGatherable(skill,level+temp)
	
	if newtemp and newtemp ~= new then
		local tempmsg = ""
		if temp>0 then tempmsg = " (with current |cff1aff1a+"..temp.."|cffFFC300 bonus)" end
		
			if skill == "Skinning"	then GatherNotify.Msg("Now able to skin level "..newtemp.." creatures"..tempmsg, false)
		elseif skill == "Mining"	then GatherNotify.Msg("Now able to mine "..newtemp..tempmsg, false)
		elseif skill == "Herbalism"	then GatherNotify.Msg("Now able to pick "..newtemp..tempmsg, false)
		end
	end
	----- End -----
end

--- Functions ---

function GatherNotify.Msg(msg, printname, color)			-- Print a message to the chat frame
	if not color then
		color = "FFC300"
	end
	
	if printname then
		DEFAULT_CHAT_FRAME:AddMessage("|cffd2b48c[GatherNotify]|r |cff"..color..msg)
	else
		DEFAULT_CHAT_FRAME:AddMessage("|cff"..color..msg)
	end
end

function GatherNotify.GetChatColor(chattype)				-- Get the default color of a chat type (like SKILL or WHISPER)
	local chatinfo = ChatTypeInfo[chattype]
	return format("%02x%02x%02x", chatinfo.r*255, chatinfo.g*255, chatinfo.b*255)
end

function GatherNotify.AddError(skill,rlevel,current,temp)	-- Print a modified red error to the top of the screen
	if temp == 0 then
		UIErrorsFrame:AddMessage(string.format("Requires %s %s (currently %s)",skill,rlevel,current),1.0,0.1,0.1,1.0)
	else
		UIErrorsFrame:AddMessage(string.format("Requires %s %s (currently %s|cff1aff1a+%s|r)",skill,rlevel,current,temp),1.0,0.1,0.1,1.0)
	end
end

function GatherNotify.GetHighestNode(skill,level)			-- Get the highest herb/mine/corpse usable at the current skill level
	skill = skill:lower()
	if skill ~= "skinning" and skill ~= "herbalism" and skill ~= "mining" then return end
	
	local highest = 1
	for i,v in pairs(GatherNotify.levels[skill]) do
		if v[1] <= level and v[2] then
			highest = v[1]
		end
	end
	
	return GatherNotify.GetAllGatherable(skill,highest)
end

function GatherNotify.PrintHighestNode(skill)				-- Print the highest herb/mine/corpse usable at the current skill level
	local level,temp = GatherNotify.GetProfessionLevel(skill)
	
	if level then
		----- First, print highest mineable without taking temp bonuses into account -----
		local tempmsg = ""
		if temp>0 and GatherNotify.GetHighestNode(skill,level+temp) ~= GatherNotify.GetHighestNode(skill,level) then
			tempmsg = " (without current |cff1aff1a+"..temp.."|cffFFC300 bonus)"
		end
		
		if skill == "skinning"	then GatherNotify.Msg("Skinning "..level..": level "..GatherNotify.GetHighestNode("skinning",level).." creatures"..tempmsg, true) end
		if skill == "mining" 	then GatherNotify.Msg("Mining "..level..": "..GatherNotify.GetHighestNode("mining",level)..tempmsg, true) end
		if skill == "herbalism"	then GatherNotify.Msg("Herbalism "..level..": "..GatherNotify.GetHighestNode("herbalism",level)..tempmsg, true) end
		----- End -----
		
		----- Then print highest mineable, taking temp bonuses into account -----
		if GatherNotify.GetHighestNode(skill,level+temp) ~= GatherNotify.GetHighestNode(skill,level) then -- Only print what you can mine with current bonus if it differs from without bonus
			tempmsg = ""
			if temp>0 then tempmsg = " (with current |cff1aff1a+"..temp.."|cffFFC300 bonus)" end
			if skill == "skinning"	then GatherNotify.Msg("Skinning |cff1aff1a"..level+temp.."|cffFFC300: level "..GatherNotify.GetHighestNode("skinning",level+temp).." creatures"..tempmsg, true) end
			if skill == "mining" 	then GatherNotify.Msg("Mining |cff1aff1a"..level+temp.."|cffFFC300: "..GatherNotify.GetHighestNode("mining",level+temp)..tempmsg, true) end
			if skill == "herbalism"	then GatherNotify.Msg("Herbalism |cff1aff1a"..level+temp.."|cffFFC300: "..GatherNotify.GetHighestNode("herbalism",level+temp)..tempmsg, true) end
		end
		----- End -----
	else
		GatherNotify.Msg("You don't have "..skill, true)
	end
end

function GatherNotify.GetAllGatherable(skill,level)			-- Get a list of all herbs/mines/corpses usable at the current skill level
	skill = skill:lower()
	if skill ~= "skinning" and skill ~= "herbalism" and skill ~= "mining" then return end
	
	local i2 = 1
	local ret = {}
	for i,v in pairs(GatherNotify.levels[skill]) do
		if v[1] == level and v[2] then
			ret[i2] = v[2]
			i2=i2+1
		end
	end
	
	if #ret == 0 then return nil else return table.concat(ret,", ") end
end

function GatherNotify.GetRequiredLevel(skill,name)			-- Get the required herbalism/mining/skinning level required to use a node/corpse
	name = tostring(name)
	skill = skill:lower()
	if skill ~= "skinning" and skill ~= "herbalism" and skill ~= "mining" then return end
	
	for i,v in pairs(GatherNotify.levels[skill]) do
		if (not v[3] and v[2] == name) or v[3] == name then
			ret = v[1]
		end
	end
	
	return ret
end

function GatherNotify.GetProfessionLevel(name)				-- Get a profession's level
	local numSkills = GetNumSkillLines();
	for i=1, numSkills do
		local skillname,_,_,skillrank,_,skillmodifier = GetSkillLineInfo(i)
		if skillname:lower() == name:lower() then
			return skillrank, skillmodifier
		end
	end
end

function GatherNotify.ModifyTooltip(self, ...)				-- Modify an herb's/mine's/corpse's tooltip
	local skillname,objname,r,g,b,a
	
	if GameTooltipTextLeft2:GetText() == "Mining" then
		skillname = "Mining"
		objname = GameTooltipTextLeft1:GetText()
		r,g,b,a = GameTooltipTextLeft2:GetTextColor()
		linenum = 2
	elseif GameTooltipTextLeft2:GetText() == "Requires Herbalism" or GameTooltipTextLeft2:GetText() == "Herbalism" then
		skillname = "Herbalism"
		objname = GameTooltipTextLeft1:GetText()
		r,g,b,a = GameTooltipTextLeft2:GetTextColor()
		linenum = 2
	elseif UnitExists("mouseover") then
		skillname = "Skinning"
		objname = UnitLevel("mouseover") -- Skinning takes a mob level, not an object/node name
		local skinning_line = 0
		for i=1,GameTooltip:NumLines() do
			if _G["GameTooltipTextLeft"..i]:GetText() == "Skinnable" then
				skinning_line = i
			end
		end
		if skinning_line == 0 then return end -- Not a skinnable mob, so abort
		r,g,b,a = _G["GameTooltipTextLeft"..skinning_line]:GetTextColor()
		linenum = skinning_line
	else
		return -- Not a tooltip we care about
	end
	
	-- Modify the tooltip
	local req = GatherNotify.GetRequiredLevel(skillname,objname)
	
	if not req then
		return
	end
	
	local newstr = _G["GameTooltipTextLeft"..linenum]:GetText() .. " " .. req
	
	local skill,tempboost = GatherNotify.GetProfessionLevel(skillname)
	
	if skill then
		if req > skill+tempboost then
			if tempboost > 0 then
				newstr = newstr .. format(" (currently %s|cff1aff1a+%s|r)", skill, tempboost)
			else
				newstr = newstr .. " (currently "..skill .. ")"
			end
		end
	end
	
	_G["GameTooltipTextLeft"..linenum]:SetText(newstr)
	GameTooltip:Show() -- Re-show the tooltip to update its size
end

-- Debug functions

function GatherNotify.Debug(...)							-- Print a debug message to the chat frame
	local str = table.concat({...}, " ")
	DEFAULT_CHAT_FRAME:AddMessage("|cffff0000[GN]|r " .. str)
end

function GatherNotify.DebugErr(skill,level)					-- Generates a fake error message - GN.err("mining", 500) etc.
	UIErrorsFrame:GetScript("OnEvent")(UIErrorsFrame,"UI_ERROR_MESSAGE", format("Requires %s %s", skill, level))
end

function GatherNotify.DebugSkillup(str)						-- Generates a fake skillup message in chat
	GatherNotify.OnEvent(self, "CHAT_MSG_SKILL", str)
end

SLASH_GN1, SLASH_GN2, SLASH_GN3 = '/gn', '/gathernotify', '/gnotify'
SlashCmdList["GN"] = GatherNotify.OnCommand

GatherNotify.Frame:SetScript("OnEvent", GatherNotify.OnEvent)
GatherNotify.Frame:RegisterEvent("CHAT_MSG_SKILL")
GatherNotify.Frame:RegisterEvent("ADDON_LOADED")
GatherNotify.Frame:RegisterEvent("UI_ERROR_MESSAGE")