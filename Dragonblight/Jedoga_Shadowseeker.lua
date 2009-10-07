-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Jedoga Shadowseeker", "Ahn'kahet: The Old Kingdom")
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod:RegisterEnableMob(29310)
mod.toggleOptions = {
	56926, -- Thunder Shock
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Thundershock", 56926, 60029)
	self:Death("Win", 29310)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Thundershock(_, spellId, _, _, spellName)
	self:Message(56926, spellName, "Important", spellId)
	self:Bar(56926, spellName, 10, spellId)
end
