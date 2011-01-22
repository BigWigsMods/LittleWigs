-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Vanessa VanCleef", "The Deadmines")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(49541)
mod.toggleOptions = {92614, {92278, "FLASHSHAKE", "ICON"}, 95542, {90396, "FLASHSHAKE", "ICON"}, "bosskill"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Deflection", 92614)
	self:Log("SPELL_AURA_APPLIED", "Spark", 92278) -- check, not sure this is actually used, may be from Beta.
	self:Log("SPELL_CAST_SUCCESS", "Vengeance", 95542) -- check
	self:Log("SPELL_AURA_APPLIED", "Blades", 90396, 90962, 90963) -- check

	self:Death("Win", 49541)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Deflection(_, spellId, _, _, spellName)
	self:Message(92614, spellName, "Urgent", spellId)
	self:Bar(92614, spellName, 10, spellId)
end

function mod:Spark(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(92278, spellName, "Important", spellId, "Alarm")
		self:FlashShake(92278)
	end
	self:PrimaryIcon(92278, player)
end

function mod:Vengeance(_, spellId, _, _, spellName)
	self:Message(95542, spellName, "Attention", spellId, "Long")
end

function mod:Blades(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(90396, spellName, "Important", spellId, "Alarm")
		self:FlashShake(90396)
	end
	self:PrimaryIcon(90396, player)
end

