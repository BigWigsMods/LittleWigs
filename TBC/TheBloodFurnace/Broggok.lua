-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Broggok", 725, 556)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod:RegisterEnableMob(17380)
mod.toggleOptions = {
	30916,
}

-------------------------------------------------------------------------------
--  Localization

local BCL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")

-------------------------------------------------------------------------------
--  Initialize

function mod:OnBossEnable()
	self:Log("SPELL_DAMAGE", "Cloud", 30916)
	self:Log("SPELL_MISSED", "Cloud", 30916)
	self:Death("Win", 17380)
end

-------------------------------------------------------------------------------
--  Event Handlers

local last = 0
function mod:Cloud(_, spellId, _, _, spellName)
	local time = GetTime()
	if (time - last) > 5 then
		last = time
		self:LocalMessage(30916, BCL["you"]:format(spellName), "Personal", spellId, "Alert")
	end
end
