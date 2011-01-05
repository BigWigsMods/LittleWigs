-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("High Prophet Barim", "Lost City of the Tol'vir")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43612)
mod.toggleOptions = {
	{89997, "FLASHSHAKE", "ICON"}, -- Plague of Ages
	82506, -- Fifty Lashings
	{88814, "FLASHSHAKE"}, -- Hallowed Ground
	"bosskill",
}
local BCL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")
mod.optionHeaders = {
	[89997] = BCL.phase:format(1),
	[88814] = BCL.phase:format(2),
	bosskill = "general",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Plague", 82622, 89997)
	self:Log("SPELL_AURA_APPLIED", "Lashings", 82506)
	self:Log("SPELL_AURA_APPLIED", "Ground", 88814, 90010)

	self:RegisterEvent("UNIT_HEALTH")

	self:Death("Win", 43612)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Plague(unit, spellId, _, _, spellName)
	if UnitIsUnit(unit, "player") then
		self:LocalMessage(89997, BCL["you"]:format(spellName), "Personal", spellId, "Info")
		self:FlashShake(89997)
	end
	self:PrimaryIcon(89997, unit)
end

function mod:Lashings(_, spellId, _, _, spellName)
	self:Message(82506, spellName, "Important", spellId)
end

function mod:Ground(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(88814, BCL["you"]:format(spellName), "Urgent", spellId, "Alert")
		self:FlashShake(88814)
	end
end

function mod:UNIT_HEALTH(_, unit)
	if unit ~= "boss1" then return end
	if UnitName(unit) == self.displayName then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 55 then
			self:Message(88814, LW_CL["phase_soon"]:format(2), "Attention")
			self:UnregisterEvent("UNIT_HEALTH")
		end
	end
end

