-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Forgemaster Throngus", 757)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(40177)
mod.toggleOptions = {
	74908, -- Personal Phalanx
	75007, -- Encumbered
	74981, -- Dual Blades
	{90737, "FLASHSHAKE"}, -- Disorienting Roar
	90756, -- Impaling Slam
	{74987, "FLASHSHAKE"}, -- Cave In
	"bosskill",
}

-------------------------------------------------------------------------------
-- Locale

local BCL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")
local L = mod:NewLocale("enUS", true)
if L then--@do-not-package@
	L.roar_message = "%dx Roar"--@end-do-not-package@
--@localization(locale="enUS", namespace="GrimBatol/Forgemaster", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Phalanx", 74908)
	self:Log("SPELL_AURA_APPLIED", "Encumbered", 75007, 90729)
	self:Log("SPELL_AURA_APPLIED", "Blades", 74981, 90738)
	self:Log("SPELL_CAST_SUCCESS", "Impale", 75056, 90756)
	self:Log("SPELL_AURA_APPLIED", "CaveIn", 74987)
	self:Log("SPELL_AURA_APPLIED", "Roar", 90737)
	self:Log("SPELL_AURA_REMOVED_DOSE", "MinusRoar", 90737)

	self:Death("Win", 40177)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Roar(player, spellId)
	if not UnitIsUnit(player, "player") then return end
	self:FlashShake(90737)
	self:LocalMessage(90737, BCL["you"]:format(L["roar_message"]:format(3)), "Personal", spellId, "Long")
end

function mod:MinusRoar(player, spellId, _, _, spellName, remaining)
	if not UnitIsUnit(player, "player") then return end
	self:LocalMessage(90737, BCL["you"]:format(L["roar_message"]:format(remaining)), "Attention", spellId)
end

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
	self:TargetMessage(90756, spellName, player, "Urgent", spellId)
end

function mod:CaveIn(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(74987, BCL["you"]:format(spellName), "Personal", spellId, "Alarm")
		self:FlashShake(74987)
	end
end

