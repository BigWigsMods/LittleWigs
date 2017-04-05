
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Archmage Xylem", nil, nil, 1673)
if not mod then return end
mod:RegisterEnableMob(115244) -- Archmage Xylem
mod.otherMenu = 1021 -- Broken Shore

--------------------------------------------------------------------------------
-- Locals
--



--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.name = "Archmage Xylem"
end
mod.displayName = L.name

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	self:Death("Win", 115244)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_MONSTER_YELL(event)
	self:UnregisterEvent(event)
	self:Bar("warmup", 28, CL.active, "spell_mage_focusingcrystal")
end

