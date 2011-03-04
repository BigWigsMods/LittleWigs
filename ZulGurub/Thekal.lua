--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("High Priest Thekal", "Zul'Gurub")
if not mod then return end
mod:RegisterEnableMob(14509)
mod.toggleOptions = {24208, 24183, "bosskill"}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Heal", 24208)
	self:Log("SPELL_INTERRUPT", "HealStop")
	self:Log("SPELL_CAST_SUCCESS", "Tigers", 24183)
	self:Death("Win", 14509)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Heal(_, spellId, _, _, spellName)
	self:Message(spellId, spellName, "Attention", spellId)
	self:Bar(spellId, spellName, 4, spellId)
end

function mod:HealStop(_, spellId, source, secSpellId, spellName)
	if secSpellId == 24208 then
		self:TargetMessage(24208, "%2$s: %1$s", source, "Positive", spellId, nil, spellName)
		self:SendMessage("BigWigs_StopBar", self, GetSpellInfo(secSpellId))
	end
end

function mod:Tigers(_, spellId, _, _, spellName)
	self:Message(spellId, spellName, "Urgent", spellId)
end

