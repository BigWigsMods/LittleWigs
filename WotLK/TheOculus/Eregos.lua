-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Ley-Guardian Eregos", 528)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod:RegisterEnableMob(27656)
mod.toggleOptions = {
	51162, -- Planar Shift
	51170, -- Enraged Assult
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["enragedassault_message"] = "Enraged Assault"
	L["planarshift_expire_message"] = "Planar Shift ends in 5 sec"
	L["planarshift_message"] = "Planar Shift"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "PlanarShift", 51162)
	self:Log("SPELL_AURA_APPLIED", "EnragedAssault", 51170)
	self:Death("Win", 27656)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:PlanarShift(_, spellId, _, _, spellName)
	self:Message(51162, L["planarshift_message"], "Important", spellId)
	self:DelayedMessage(51162, 13, L["planarshift_expire_message"], "Attention")
	self:Bar(51162, spellName, 18, spellId)
end

function mod:EnragedAssault(player, spellId, _, _, spellName)
	self:Message(51170, L["enragedassault_message"], "Important", spellId)
	self:Bar(51170, spellName, 12, spellId)
end
