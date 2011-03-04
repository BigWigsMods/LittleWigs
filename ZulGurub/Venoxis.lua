--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("High Priest Venoxis", "Zul'Gurub")
if not mod then return end
mod:RegisterEnableMob(14507)
mod.toggleOptions = {23895, {23862, "ICON"}, "bosskill"}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Renew", 23895)
	self:Log("SPELL_AURA_APPLIED", "Venom", 23862)
	self:Log("SPELL_AURA_REMOVED", "VenomRemoved", 23862)
	self:Death("Win", 14507)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Renew(mob, spellId, _, _, spellName)
	self:Message(spellId, spellName..": "..mob, "Urgent", spellId)
end

function mod:Venom(player, spellId, _, _, spellName)
	self:TargetMessage(spellId, spellName, player, "Attention", spellId)
	self:Bar(spellId, player, 10, spellId)
	self:PrimaryIcon(spellId, player)
end

function mod:VenomRemoved(player)
	self:SendMessage("BigWigs_StopBar", self, player)
	self:PrimaryIcon(23862, false)
end

