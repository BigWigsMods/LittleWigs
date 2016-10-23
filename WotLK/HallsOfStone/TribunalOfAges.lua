--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Tribunal of Ages", 526)
if not mod then return end
mod.partycontent = true
mod.otherMenu = "The Storm Peaks"
mod:RegisterEnableMob(28070)
mod.toggleOptions = {"timers"}

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L["moduleName"] = "Tribunal of Ages"

	L["enable_trigger"] = "Time to get some answers"
	L["engage_trigger"] = "Now keep an eye out"
	L["defeat_trigger"] = "The old magic fingers"
	L["fail_trigger"] = "Not yet, not"

	L["timers"] = "Timers"
	L["timers_desc"] = "Timers for various events that take place."

	L["wave"] = "First wave!"--leaving this just incase I revert the warmup
	L["victory"] = "Victory!"
end
L = mod:GetLocale()

mod.displayName = L["moduleName"]

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
end
mod.OnBossDisable = mod.OnRegister

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
end

function mod:OnEngage()
	self:Bar("timers", self.displayName, 45, "Achievement_Character_Dwarf_Male")
	self:Bar("timers", L["victory"], 315, "INV_Misc_PocketWatch_01")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg == L.enable_trigger or msg:find(L.enable_trigger, nil, true) then
		self:Enable()
	elseif msg == L.fail_trigger or msg:find(L.fail_trigger, nil, true) then
		self:Reboot()
	elseif msg == L.engage_trigger or msg:find(L.engage_trigger, nil, true) then
		self:Engage()
	elseif msg == L.defeat_trigger or msg:find(L.defeat_trigger, nil, true) then
		self:Win()
	end
end
