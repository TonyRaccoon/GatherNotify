--[[ Changelog:
	1.0 : Initial release
	1.1 : Added "(currently xxx)" to end of "Requires (Fishing, Cooking, etc.)" messages. For example, "Requires Mining 500 (currently 496)"
	1.2 : Added command to print highest herb/mob/mine you can pick/skin/mine, fixed "Requires skinning knife (currently 0)" bug
	1.3 : Updated for 5.0, added Pandaria resources, now takes into account levels gained from enchants and items in bag (Herbalist's Spade, etc.)
	1.4 : Added node/herb/skinnable mob tooltip modifications
	1.41: Fixed bug with tooltips
	1.42: Fixed the addon not allowing other addons to hide its UIErrorsFrame messages (like Leatrix Plus), thanks tordekflesk
	1.43: Fixed duplicate "Now able to mine..." messages when you don't have any skill bonuses
	1.44: Fixed error when hovering over Truesilver deposits
	1.45: Updated TOC version for 5.1
	1.46: Updated TOC version for 5.2
	1.47: Updated TOC version for 5.3, and fixed minor skinning error (need 10 Skinning, not 1, to skin a level 11 mob)
	1.48: Updated TOC version for 5.4
]]

local origErrorFunc

-- Table format: {level, prettyName, objectName}
-- If prettyName is nil, it's only used for modifying object tooltips, it should not be reported in chat that it is now mineable
-- If objectName is missing, it's assumed that it's the same as prettyName (as in most herbs)

local mining_levels = {
	{1,   "Copper", 		"Copper Vein"},
	{50,  "Tin",			"Tin Vein"},
	{65,  "Silver",			"Silver Vein"},
	{100, "Iron",			"Iron Deposit"},
	{115, "Gold",			"Gold Vein"},
	{150, "Mithril",		"Mithril Deposit"},
	{150, nil,				"Ooze Covered Mithril Deposit"},
	{165, "Truesilver",		"Truesilver Deposit"},
	{165, nil,				"Ooze Covered Truesilver Deposit"},
	{165, "Dark Iron",		"Dark Iron Deposit"},
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
	{500, "Ghost Iron",		"Ghost Iron Deposit"},
	{525, "Pyrite",			"Pyrite Deposit"},
	{525, "Rich Pyrite",	"Rich Pyrite Deposit"},
	{550, "Rich Ghost Iron","Rich Ghost Iron Deposit"},
	{550, "Kyparite",		"Kyparite Deposit"},
	{575, "Rich Kyparite",	"Rich Kyparite Deposit"},
	{600, "Trillium",		"Trillium Vein"},
	{600, "Rich Trillium",	"Rich Trillium Vein"}
}

local herbalism_levels = {
	{1,   "Peacebloom"},
	{1,   "Silverleaf"},
	{1,   "Earthroot"},
	{1,   "Mageroyal"},
	{70,  "Briarthorn"},
	{85,  "Stranglekelp"},
	{85,  "Bruiseweed"},
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
	{500, "Green Tea Leaf"},
	{525, "Twilight Jasmine"},
	{525, "Rain Poppy"},
	{545, "Silkweed"},
	{550, "Golden Lotus"},
	{575, "Snow Lily"},
	{575, "Sha-Touched Herb"},
	{600, "Fool's Cap"}
}

local skinning_levels = {
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

function GNGetHighest(skill,level)
	local tbl
		if string.lower(skill) == "skinning" then tbl = skinning_levels
	elseif string.lower(skill) == "mining" then tbl = mining_levels
	elseif string.lower(skill) == "herbalism" then tbl = herbalism_levels
	  else return nil
	end
	
	local highest = 1
	for i,v in pairs(tbl) do
		if v[1] <= level and v[2] then
			highest = v[1]
		end
	end
	
	return GNGetForLevel(skill,highest)
end

function GNGetForLevel(skill,level)
	local tbl
		if string.lower(skill) == "skinning" then tbl = skinning_levels
	elseif string.lower(skill) == "mining" then tbl = mining_levels
	elseif string.lower(skill) == "herbalism" then tbl = herbalism_levels
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

function GNGetLevelForObject(skill,name)
	name = tostring(name)
	local tbl,ret
		if string.lower(skill) == "skinning" then tbl = skinning_levels
	elseif string.lower(skill) == "mining" then tbl = mining_levels
	elseif string.lower(skill) == "herbalism" then tbl = herbalism_levels
	  else return nil
	end
	
	for i,v in pairs(tbl) do
		if (v[3] == nil and v[2] == name) or v[3] == name then
			ret = v[1]
		end
	end
	
	return ret
end

function GNGetProfessionLevel(name)
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

function GNModifyTooltip(self, ...)
	if GameTooltipTextLeft2:GetText() == "Requires Mining" then
		req = GNGetLevelForObject("Mining",GameTooltipTextLeft1:GetText())
		r,g,b,a = GameTooltipTextLeft2:GetTextColor()
		if req then GameTooltipTextLeft2:SetText("Requires Mining "..req) end
		local skill,temp = GNGetProfessionLevel("Mining")
		if skill then
			local tempmsg = ""
			if temp>0 then tempmsg = "|cff1aff1a+"..temp.."|r" end
			if skill and req>skill+temp then GameTooltip:AddLine("Currently "..skill..tempmsg,r,g,b,a) end
		end
		GameTooltip:Show()
	
	elseif GameTooltipTextLeft2:GetText() == "Requires Herbalism" then
		req = GNGetLevelForObject("Herbalism",GameTooltipTextLeft1:GetText())
		r,g,b,a = GameTooltipTextLeft2:GetTextColor()
		if req then GameTooltipTextLeft2:SetText("Requires Herbalism "..req) end
		local skill,temp = GNGetProfessionLevel("Herbalism")
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
			req = GNGetLevelForObject("Skinning",UnitLevel("mouseover"))
			r,g,b,a = _G["GameTooltipTextLeft"..sline]:GetTextColor()
			if req then _G["GameTooltipTextLeft"..sline]:SetText("Skinnable ("..req..")") end
			local skill,temp = GNGetProfessionLevel("Skinning")
			if skill then
				local tempmsg = ""
				if temp>0 then tempmsg = "|cff1aff1a+"..temp.."|r" end
				if req>skill+temp then GameTooltip:AddLine("Currently "..skill..tempmsg,r,g,b,a) end
			end
			GameTooltip:Show()
		end
	end
end

function OnUIError(self, event, err, ...)
	local skill = strmatch(err,"Requires (.*) ")
	local rlevel = tonumber(strmatch(err,"Requires .* (%d+)"))
	
	if (skill ~= nil) and (rlevel ~= nil) then -- Error was a "requires" error
		local level,temp = GNGetProfessionLevel(skill)
		if level then
			GN_AddError(skill,rlevel,level,temp)
		else
			return origErrorFunc(self, event, err, ...)
		end
	else
		return origErrorFunc(self, event, err, ...)
	end
end

function GN_OnLoad(self)
	self:RegisterEvent("CHAT_MSG_SKILL")
	GameTooltip:HookScript("OnShow",GNModifyTooltip)
	
	origErrorFunc = UIErrorsFrame:GetScript('OnEvent')
	UIErrorsFrame:SetScript('OnEvent', OnUIError)
	
	--self:RegisterEvent("UI_ERROR_MESSAGE")
	--UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
end

function GNTestError(skill,level)
	GN_OnEvent(nil,"UI_ERROR_MESSAGE",string.format("Requires %s %s",skill,level))
end

function GN_OnEvent(self, event, ...)
	if (event == "CHAT_MSG_SKILL") then
		local skill = strmatch(...,"Your skill in (%a*) has increased to")
		if skill == "Mining" or skill == "Herbalism" or skill == "Skinning" then
			local level,temp = GNGetProfessionLevel(skill)
			
			----- First, print if you can mine something new, without taking temp bonuses into account -----
			local new = GNGetForLevel(skill,level)
			
			if new then
				local tempmsg = ""
				if temp>0 then tempmsg = " (without current |cff1aff1a+"..temp.."|cffFFC300 bonus)" end
				
					if skill == "Skinning"	then GN_Msg("Now able to skin level "..new.." creatures"..tempmsg,true)
				elseif skill == "Mining"	then GN_Msg("Now able to mine "..new..tempmsg,true)
				elseif skill == "Herbalism"	then GN_Msg("Now able to pick "..new..tempmsg,true)
				end
			end
			----- End -----
			
			----- Now, print if you can mine something new, WITH temp bonuses, but only if it differs from without bonuses -----
			local newtemp = GNGetForLevel(skill,level+temp)
			
			if newtemp and newtemp ~= new then
				local tempmsg = ""
				if temp>0 then tempmsg = " (with current |cff1aff1a+"..temp.."|cffFFC300 bonus)" end
				
					if skill == "Skinning"	then GN_Msg("Now able to skin level "..newtemp.." creatures"..tempmsg,true)
				elseif skill == "Mining"	then GN_Msg("Now able to mine "..newtemp..tempmsg,true)
				elseif skill == "Herbalism"	then GN_Msg("Now able to pick "..newtemp..tempmsg,true)
				end
			end
			----- End -----
		end
	
	-- Using a SetScript based method now for better integration with other addons that modify UIErrorsFrame
	--[[
	elseif (event == "UI_ERROR_MESSAGE") then
		local skill = strmatch(...,"Requires (.*) ")
		local rlevel = tonumber(strmatch(...,"Requires .* (%d+)"))
		
		if ((skill ~= nil) and (rlevel ~= nil)) then -- Error was a "requires" error
			local level,temp = GNGetProfessionLevel(skill)
			if level then
				GN_AddError(skill,rlevel,level,temp)
			else
				UIErrorsFrame:AddMessage(...,1,.1,.1)
			end
		else
			UIErrorsFrame:AddMessage(...,1,.1,.1)
		end
	]]
	end
end

function GN_AddError(skill,rlevel,current,temp)
	if temp == 0 then
		UIErrorsFrame:AddMessage(string.format("Requires %s %s (currently %s)",skill,rlevel,current),1.0,0.1,0.1,1.0)
	else
		--UIErrorsFrame:AddMessage(string.format("Requires %s %s (currently %s - %s|cff1aff1a+%s|r)",skill,rlevel,current+temp,current,temp),1.0,0.1,0.1,1.0)
		UIErrorsFrame:AddMessage(string.format("Requires %s %s (currently %s|cff1aff1a+%s|r)",skill,rlevel,current,temp),1.0,0.1,0.1,1.0)
	end
end

function GN_Msg(msg,noname)
	if noname then
		DEFAULT_CHAT_FRAME:AddMessage("|cffFFC300"..msg)
	else
		DEFAULT_CHAT_FRAME:AddMessage("|cffd2b48c[GatherNotify]|r "..msg)
	end
end

SLASH_GN1, SLASH_GN2, SLASH_GN3 = '/gn', '/gathernotify', '/gnotify'
function SlashCmdList.GN(cmd)
	cmd = string.lower(cmd)
	if (cmd == "s" or cmd == "skinning") then
		GN_PrintHighest("skinning")
	elseif (cmd == "m" or cmd == "mining") then
		GN_PrintHighest("mining")
	elseif (cmd == "h" or cmd == "herbalism") then
		GN_PrintHighest("herbalism")
	elseif (cmd == "v" or cmd == "ver" or cmd == "version") then
		GN_Msg("GatherNotify version: "..GetAddOnMetadata("GatherNotify","Version"))
	else
		GN_Msg("/gn skinning - Print highest level creature you can skin")
		GN_Msg("/gn mining - Print highest node you can mine")
		GN_Msg("/gn herbalism - Print highest herb you can pick")
		GN_Msg("/gn version - Prints addon version")
	end
end

function GN_PrintHighest(skill)
	local level,temp = GNGetProfessionLevel(skill)
	
	if level then
		----- First, print highest mineable without taking temp bonuses into account -----
		local tempmsg = ""
		if temp>0 and GNGetHighest(skill,level+temp) ~= GNGetHighest(skill,level) then tempmsg = " (without current |cff1aff1a+"..temp.."|cffFFC300 bonus)" end
		if skill == "skinning"	then GN_Msg("Skinning "..level..": level "..GNGetHighest("skinning",level).." creatures"..tempmsg,true) end
		if skill == "mining" 	then GN_Msg("Mining "..level..": "..GNGetHighest("mining",level)..tempmsg,true) end
		if skill == "herbalism"	then GN_Msg("Herbalism "..level..": "..GNGetHighest("herbalism",level)..tempmsg,true) end
		----- End -----
		
		----- Then print highest mineable, taking temp bonuses into account -----
		if found==true then
			if GNGetHighest(skill,level+temp) ~= GNGetHighest(skill,level) then -- Only print what you can mine with current bonus if it differs from without bonus
				tempmsg = ""
				if temp>0 then tempmsg = " (with current |cff1aff1a+"..temp.."|cffFFC300 bonus)" end
				if skill == "skinning"	then GN_Msg("Skinning |cff1aff1a"..level+temp.."|cffFFC300: level "..GNGetHighest("skinning",level+temp).." creatures"..tempmsg,true) end
				if skill == "mining" 	then GN_Msg("Mining |cff1aff1a"..level+temp.."|cffFFC300: "..GNGetHighest("mining",level+temp)..tempmsg,true) end
				if skill == "herbalism"	then GN_Msg("Herbalism |cff1aff1a"..level+temp.."|cffFFC300: "..GNGetHighest("herbalism",level+temp)..tempmsg,true) end
			end
		----- End -----
		end
	else
		GN_Msg("You don't have "..skill)
	end
end