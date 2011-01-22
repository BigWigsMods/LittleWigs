-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Ozruk", "The Stonecore")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(42188)
mod.toggleOptions = {
	78939, -- Elementium Bulwark
	92410, -- Ground Slam
	92662, -- Shatter
	80467, -- Enrage
	92426, -- Paralyze
	"bosskill",
}
mod.optionHeaders = {
	[78939] = "normal",
	[92426] = "heroic",
	bosskill = "general",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Bulwark", 78939, 92659)
	self:Log("SPELL_AURA_REMOVED", "BulwarkRemoved", 78939, 92659)
	self:Log("SPELL_AURA_APPLIED", "Enrage", 80467)
	self:Log("SPELL_CAST_START", "Paralyze", 92426)
	self:Log("SPELL_CAST_START", "Shatter", 78807, 92662)
	self:Log("SPELL_CAST_START", "GroundSlam", 78903, 92410)

	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 42188)
end

function mod:OnEngage()
	self:Bar(92662, LW_CL["next"]:format(GetSpellInfo(92662)), 20, 92662)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Bulwark(player, spellId, _, _, spellName)
	if player == self.displayName then -- we only warn if the boss gains it, not a mage spell stealing
		self:Message(78939, spellName, "Important", spellId, "Alarm")
		self:Bar(78939, spellName, 10, spellId)
	end
end

function mod:BulwarkRemoved(_, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, spellName) -- stop the bar early if dispelled
end

function mod:UNIT_HEALTH(_, unit)
	if unit ~= "boss1" then return end
	if UnitName(unit) == self.displayName then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 27 then
			self:Message(80467, LW_CL["soon"]:format(GetSpellInfo(80467)), "Attention", 80467)
			self:UnregisterEvent("UNIT_HEALTH")
		end
	end
end

function mod:Enrage(_, spellId, _, _, spellName)
	self:Message(80467, spellName, "Attention", spellId)
end

function mod:Paralyze(_, spellId, _, _, spellName)
	self:Message(92426, spellName.." - "..LW_CL["soon"]:format(GetSpellInfo(92662)), "Important", spellId, "Alert")
end

function mod:Shatter(_, spellId, _, _, spellName)
	self:Bar(92662, LW_CL["casting"]:format(spellName), 2.5, spellId) -- XXX change to 3 sec in 4.0.6
	self:Bar(92662, LW_CL["next"]:format(spellName), 20, spellId)
end

function mod:GroundSlam(_, spellId, _, _, spellName)
	self:Message(92410, LW_CL["casting"]:format(spellName), "Urgent", spellId, "Alarm")
	self:Bar(92410, LW_CL["casting"]:format(spellName), 3, spellId)
end

