--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("High Priestess Arlokk", "Zul'Gurub")
if not mod then return end
mod:RegisterEnableMob(14515)
mod.toggleOptions = {{24210, "ICON"}, "bosskill"}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Mark", 24210)
	self:Death("Win", 14515)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Mark(player, spellId, _, _, spellName)
	self:TargetMessage(spellId, spellName, player, "Attention", spellId)
	local mark = GetSpellInfo(28836) --Translation of "Mark"
	self:Bar(spellId, mark..": "..player, 120, spellId)
	self:PrimaryIcon(spellId, player)
end

