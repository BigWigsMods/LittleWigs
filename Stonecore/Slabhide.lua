-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Slabhide", "The Stonecore")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43214)
mod.toggleOptions = {
	{80801, "FLASHSHAKE"}, -- Lava Pool
	92265, --Crystal Storm
	"bosskill",
}
mod.optionHeaders = {
	[80801] = "normal",
	[92265] = "heroic",
	bosskill = "general",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	-- Heroic
	self:Log("SPELL_CAST_START", "Storm", 92265)
	self:Log("SPELL_AURA_APPLIED", "StormBegun", 92265)
	-- Normal
	self:Log("SPELL_AURA_APPLIED", "LavaPool", 80801, 92658)

	self:Death("Win", 43214)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Storm(_, spellId, _, _, spellName)
	self:Message(92265, LW_CL["casting"]:format(spellName), "Important", spellId, "Alert")
	self:Bar(92265, LW_CL["casting"]:format(spellName), 2.5, spellId)
end

function mod:StormBegun(_, spellId, _, _, spellName)
	self:Bar(92265, spellName, 6, spellId)
end

function mod:LavaPool(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(80801, LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")["you"]:format(spellName), "Personal", spellId, "Alarm")
		self:FlashShake(80801)
	end
end

