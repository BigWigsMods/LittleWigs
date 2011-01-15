-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Forgemaster Throngus", "Grim Batol")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(40177)
mod.toggleOptions = {
	74908, -- Personal Phalanx
	75007, -- Encumbered
	74981, -- Dual Blades
	90756, -- Impaling Slam
	{74987, FLASHSHAKE}, -- Cave In
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Phalanx", 74908)
	self:Log("SPELL_AURA_APPLIED", "Encumbered", 75007, 90729)
	self:Log("SPELL_AURA_APPLIED", "Blades", 74981, 90738)
	self:Log("SPELL_CAST_SUCCESS", "Impale", 75056, 90756)
	self:Log("SPELL_AURA_APPLIED", "CaveIn", 74987)

	self:Death("Win", 40177)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Phalanx(_, spellId, _, _, spellName)
	self:Message(74908, spellName, "Important", spellId, "Alert")
	self:Bar(74908, spellName, 30, spellId)
	self:DelayedMessage(74908, 25, LW_CL["ends"]:format(spellName, 5), "Attention")
end

function mod:Encumbered(_, spellId, _, _, spellName)
	self:Message(75007, spellName, "Important", spellId, "Alert")
	self:Bar(75007, spellName, 30, spellId)
	self:DelayedMessage(75007, 25, LW_CL["ends"]:format(spellName, 5), "Attention")
end

function mod:Blades(_, spellId, _, _, spellName)
	self:Message(74981, spellName, "Important", spellId, "Alert")
	self:Bar(74981, spellName, 30, spellId)
	self:DelayedMessage(74981, 25, LW_CL["ends"]:format(spellName, 5), "Attention")
end

function mod:Impale(player, spellId, _, _, spellName)
	self:TargetMessage(90756, spellName, player, "Important", spellId)
end

function mod:CaveIn(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(74987, LW_CL["you"]:format(spellName), "Urgent", spellId, "Alarm")
		self:FlashShake(74987)
	end
end

