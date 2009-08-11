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
	--trigger_surrender = "",
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
