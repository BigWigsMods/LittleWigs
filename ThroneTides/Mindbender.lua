-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Mindbender Ghur'sha", 767)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(40788, 40825)
mod.toggleOptions = {
	{91413, "ICON"}, -- Enslave
	91492, -- Absorb Magic
	76234, -- Mind Fog
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local erunak = BigWigs:Translate("Erunak Stonespeaker")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Enslave", 76207, 91413)
	self:Log("SPELL_AURA_REMOVED", "EnslaveRemoved", 76207, 91413)
	self:Log("SPELL_CAST_START", "Absorb", 76307, 91492)
	self:Log("SPELL_AURA_APPLIED", "MindFog", 76230)
	self:RegisterEvent("UNIT_HEALTH")

	self:Death("Win", 40788)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:UNIT_HEALTH(_, unit)
	if unit == "boss1" and UnitName(unit) == erunak then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 55 then
			self:Message(91413, LW_CL["phase_soon"]:format(2), "Attention")
			self:UnregisterEvent("UNIT_HEALTH")
		end
	end
end

function mod:Enslave(player, spellId, _, _, spellName)
	self:TargetMessage(91413, spellName, player, "Important", spellId, "Alert")
	self:PrimaryIcon(91413, player)
end

function mod:EnslaveRemoved()
	self:PrimaryIcon(91413)
end

function mod:Absorb(_, spellId, _, _, spellName)
	self:Message(91492, LW_CL["casting"]:format(spellName), "Urgent", spellId)
end

function mod:MindFog(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(76234, LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")["you"]:format(spellName), "Personal", spellId, "Alarm")
	end
end

