--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Bloodlord Mandokir", "Zul'Gurub")
if not mod then return end
mod:RegisterEnableMob(11382)
mod.toggleOptions = {24318, {24314, "ICON"}, "bosskill"}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 24318)
	self:Log("SPELL_AURA_APPLIED", "Gaze", 24314)
	self:Death("Win", 11382)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Frenzy(_, spellId, _, _, spellName)
	self:Message(spellId, spellName, "Positive", spellId)
end

function mod:Gaze(player, spellId, _, _, spellName)
	self:TargetMessage(spellId, spellName, player, "Attention", spellId)
	self:Bar(spellId, player, 6, spellId)
	self:PrimaryIcon(spellId, player)
end

