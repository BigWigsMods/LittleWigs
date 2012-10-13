
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sha of Violence", 877, 685)
mod:RegisterEnableMob(56719)

local smash = GetSpellInfo(34618)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "I will not be caged again. These Shado-Pan could not stop me. Neither shall you!"

	L.enrage, L.enrage_desc = EJ_GetSectionInfo(5813)
	L.enrage_icon = 38166
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"enrage", 106872, "bosskill"}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Enrage", 38166)
	self:Log("SPELL_AURA_REMOVED", "EnrageRemoved", 38166)
	self:Log("SPELL_AURA_APPLIED", "Smash", 106872)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("PARTY_KILL", "BossDeath", "*") -- No UNIT_DIED event...
end

function mod:OnEngage()
	self:RegisterEvent("UNIT_HEALTH_FREQUENT")
	self:Bar(106872, "~"..smash, 17, 106872) -- 17-19
	self:Message(106872, CL["custom_start_s"]:format(self.displayName, smash, 17), "Attention")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Smash(player, spellId)
	self:TargetMessage(spellId, smash, player, "Urgent", spellId, "Alarm")
	self:Bar(spellId, CL["other"]:format(smash, player), 4, spellId)
	self:Bar(spellId, "~"..smash, 17, spellId) -- 17-19
end

function mod:Enrage(_, spellId, _, _, spellName)
	self:Message("enrage", spellName, "Important", spellId, "Alert")
	self:Bar("enrage", spellName, 30, spellId)
end

function mod:EnrageRemoved(_, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, spellName)
end

function mod:BossDeath(...)
	local dGUID = select(10, ...)
	if self:GetCID(dGUID) == 56719 then
		self:Win()
	end
end

function mod:UNIT_HEALTH_FREQUENT(_, unitId)
	if unitId == "boss1" then
		local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
		if hp < 25 then
			self:Message("enrage", CL["soon"]:format((GetSpellInfo(38166))), "Positive", 38166, "Info")
			self:UnregisterEvent("UNIT_HEALTH_FREQUENT")
		end
	end
end

