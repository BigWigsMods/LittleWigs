--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tribunal of Ages", 599, 606)
if not mod then return end
mod:RegisterEnableMob(28070)
-- mod.engageId = 0 -- not a real encounter, apparently
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local respawnPlugin = BigWigs:GetPlugin("Respawn", true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.engage_trigger = "Now keep an eye out"
	L.defeat_trigger = "The old magic fingers"
	L.fail_trigger = "Not yet... not ye--"

	L.timers = "Timers"
	L.timers_desc = "Timers for various events that take place."
	L.timers_icon = "INV_Misc_PocketWatch_01"

	L.victory = "Victory"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"timers",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
end

function mod:OnEngage()
	self:Bar("timers", 43, self.displayName, "Achievement_Character_Dwarf_Male") -- first wave
	self:Bar("timers", 315, L.victory, "INV_Misc_PocketWatch_01")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg == L.fail_trigger or msg:find(L.fail_trigger, nil, true) then
		if respawnPlugin then
			respawnPlugin:BigWigs_EncounterEnd(nil, self, nil, nil, nil, nil, 0) -- force a respawn timer
		end
		self:Wipe()
	elseif msg == L.engage_trigger or msg:find(L.engage_trigger, nil, true) then
		self:Engage()
	elseif msg == L.defeat_trigger or msg:find(L.defeat_trigger, nil, true) then
		self:Win()
	end
end
