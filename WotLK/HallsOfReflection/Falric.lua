-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Falric", 603)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "The Frozen Halls"
mod:RegisterEnableMob(38112)
mod.toggleOptions = {
	{72426, "ICON"}, -- Impending Despair
	{72422, "ICON"}, -- Quivering Strike
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_REMOVED", "Debuff", 72422, 72426)
	self:Log("SPELL_AURA_REMOVED", "Removed", 72422, 72426)
	self:Death("Win", 38112)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Debuff(player, spellId, _, _, spellName)
	local time = 10
	if spellId == 72426 then --Farlic Impending Despair
		time = 6
		self:SecondaryIcon(72426, player)
	elseif spellId == 72422 then -- Farlic Quivering Strike
		time = 5
		self:PrimaryIcon(72422, player)
	end
	self:TargetMessage(spellId, player, spellName, "Urgent", spellId)
	self:Bar(spellId, player..": "..spellName, time, spellId)
end

function mod:Removed(player, spellId, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
	self:PrimaryIcon(spellId, false)
	self:SecondaryIcon(spellId, false)
end
