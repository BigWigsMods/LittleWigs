
-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Ozruk", "The Stonecore")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(42188)
mod.toggleOptions = {
	78939, -- Elementium Bulwark
	92662, -- Shatter
	80467, -- Enrage
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Bulwark", 78939, 92659)
	self:Log("SPELL_AURA_REMOVED", "BulwarkRemoved", 78939, 92659)
	self:Log("SPELL_AURA_APPLIED", "Enraged", 80467)
	self:Log("SPELL_CAST_START", "Paralyze", 92426)
	self:Log("SPELL_CAST_START", "Shatter", 78807, 92662)

	self:RegisterEvent("UNIT_HEALTH")

	self:Death("Win", 42188)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Bulwark(player, spellId, _, _, spellName)
	if player == self.displayName then --we only warn if the boss gains it, not a mage spell stealing
		self:Message(78939, spellName, "Important", spellId)
		self:Bar(78939, spellName, 10, spellId)
	end
end

function mod:BulwarkRemoved(_, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, spellName) --stop the bar early if dispelled
end

function mod:UNIT_HEALTH(_, unit)
	if unit ~= "boss1" then return end --if it's not the boss, don't do anything
	if UnitName(unit) == self.displayName then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 27 and hp > 21 then
			self:Message(80467, LW_CL["soon"]:format(GetSpellInfo(80467)), "Attention", 80467)
			self:UnregisterEvent("UNIT_HEALTH")
		end
	end
end

function mod:Enraged(_, spellId, _, _, spellName)
	self:Message(80467, spellName, "Positive", spellId, "Long")
end

function mod:Paralyze(_, _, _, _, spellName)
	self:Message(92662, spellName.." - "..LW_CL["soon"]:format(GetSpellInfo(92662)), "Attention", 92662, "Alert")
end

function mod:Shatter(_, spellId, _, _, spellName)
	self:Bar(92662, spellName, 2.5, spellId)
end

