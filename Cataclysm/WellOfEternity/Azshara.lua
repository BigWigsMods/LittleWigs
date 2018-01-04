--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Queen Azshara", 816, 291)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(54853, 54884, 54882, 54883) --Queen Azshara, Enchanted Magi
mod.toggleOptions = {"ej:3968", "ej:3969", "bosskill"}

local canEnable = true

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.win_trigger = "Enough! As much as I adore playing hostess, I have more pressing matters to attend to."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnBossEnable()
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "MC")
	self:Log("SPELL_CAST_START", "MassMC", 103241)

	self:Yell("Win", L["win_trigger"])
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
end

function mod:OnWin()
	canEnable = nil
end

function mod:VerifyEnable()
	if canEnable then return true end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MC(_, unit, spellName, _, _, spellId)
	if unit == "boss1" and spellId == 102334 then
		self:Message("ej:3968", spellName, "Attention", spellId, "Alert")
		--self:TargetMessage("ej:3969", spellName, player, "Urgent", spellId, "Long")
		--self:PrimaryIcon("ej:3969", player)
	end
end

function mod:MassMC(_, spellId, _, _, spellName)
	self:Message("ej:3969", spellName, "Urgent", spellId, "Long")
	self:Bar("ej:3969", "<"..spellName..">", 10, spellId)
end

