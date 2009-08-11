----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Eadric the Pure"]
local mod = BigWigs:New(boss, tonumber(("$Revision: 550 $"):sub(12, -3)))
if not mod then return end
mod.partycontent = true
mod.otherMenu = "The Argent Coliseum"
mod.zonename = BZ["Trial of the Champion"]
mod.enabletrigger = boss
mod.guid = 35119
mod.toggleoptions = {"radiance", "radianceBar", "bosskill"}

--------------------------------
--        Localization        --
--------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return {
	cmd = "Eadric the Pure",
	radiance = "radiance",
	radianceBar = "radiance Bar",
	radianceBar_desc = "Display a casting bar for Eadrics radiance.",
	radiance_desc = "Warn when Eadric is casting radiance.",
	radiance_message = "Casting radiance!",
	hammer_message_you = "You have the hammer!",
	hammer_message_other = "%s has the hammer!",
	trigger_surrender = "I give up",-- just a placeholder
}
end )

L:RegisterTranslations("deDE", function() return {
	radiance = "Strahlen",
	radianceBar = "Strahlen-Anzeige",
	radianceBar_desc = "Eine Zauberleiste für Strahlen anzeigen.",
	radiance_desc = "Warnt, wenn Eadric Strahlen wirkt.",
	radiance_message = "Blick! WEGDREHN!",
	hammer_message_you = "Du hast den Hammer!",
	hammer_message_other = "%s hat den Hammer!",
	trigger_surrender = "Ich ergebe mich! Exzellente Arbeit. Darf ich jetzt wegrennen?",
}
end )

L:RegisterTranslations("zhCN", function() return {
	radiance = "radiance",
	radianceBar = "radiance计时条",
	radianceBar_desc = "当Eadrics正在施放radiance时显示计时条。",
	radiance_desc = "当Eadric正在施放radiance时发出警报。",
	radiance_message = "正在施放 radiance！",
	hammer_message_you = ">你< 制裁之锤！",
	hammer_message_other = "制裁之锤：>%s<！",
	trigger_surrender = "I give up",-- just a placeholder
}
end )

L:RegisterTranslations("zhTW", function() return {
	radiance = "烈光",
	radianceBar = "烈光計時條",
	radianceBar_desc = "當埃卓克正在施放烈光時顯示計時條。",
	radiance_desc = "當埃卓克正在施放烈光時發出警報。",
	radiance_message = "正在施放 烈光！",
	hammer_message_you = ">你< 制裁之錘！",
	hammer_message_other = "制裁之錘：>%s<！",
	trigger_surrender = "I give up",-- just a placeholder
}
end )
----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "radiance", 66935, 66862, 67681)
	--self:AddCombatListener("SPELL_AURA_APPLIED", "hammer", 66940)
	--self:AddCombatListener("UNIT_DIED", "BossDeath")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:radiance(_, spellId, _, _, spellName)
	if self.db.profile.radiance then
		self:IfMessage(L["radiance_message"], "Urgent", spellId)
	end
	if self.db.profile.radianceBar then
		self:Bar(spellName, 3, spellId)
	end
end

--[[function mod:hammer(player)
	local other = fmt(L["hammer_message_other"], player)
	if player == pName and db.youhammer then

		self:LocalMessage(L["hammer_message_you"], "Personal", 66940)
		self:WideMessage(other)
	elseif db.elsehammer then
		self:IfMessage(other, "Attention", 66940)
		self:Whisper(player, L["hammer_message_you"])
	end

end]]--

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L["trigger_surrender"] then
		self:BossDeath(nil, self.guid)
	end
end
