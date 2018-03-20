
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Archmage Xylem", 1673)
if not mod then return end
mod:RegisterEnableMob(115244) -- Archmage Xylem
mod.otherMenu = 1716 -- Broken Shore Mage Tower

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.name = "Archmage Xylem"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
	}
end

function mod:OnRegister()
	self.displayName = L.name
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

