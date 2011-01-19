-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Commander Ulthok", "Throne of the Tides")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(40765)
mod.toggleOptions = {
	76047, -- Dark Fissure
	{91484, "ICON"}, -- Squeeze
	76100, -- Enrage
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Fissure", 76047)
	self:Log("SPELL_AURA_APPLIED", "Squeeze", 76026, 91484)
	self:Log("SPELL_AURA_REMOVED", "SqueezeRemoved", 76026, 91484)
	self:Log("SPELL_AURA_APPLIED", "Enrage", 76100)
	self:Death("Win", 40765)
end

-------------------------------------------------------------------------------
--  Event Handlers


function mod:Fissure(_, spellId, _, _, spellName)
	self:Message(76047, LW_CL["casting"]:format(spellName), "Urgent", spellId)
end

function mod:Squeeze(player, spellId, _, _, spellName)
	self:TargetMessage(91484, spellName, player, "Attention", spellId)
	self:PrimaryIcon(91484, player)
end

function mod:SqueezeRemoved()
	self:PrimaryIcon(91484)
end

function mod:Enrage(_, spellId, _, _, spellName)
	self:Message(76100, spellName, "Info", spellId)
end

