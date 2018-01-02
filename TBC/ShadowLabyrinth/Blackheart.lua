-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Blackheart the Inciter", 724, 545)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod:RegisterEnableMob(18667)
mod.toggleOptions = {33676}

-------------------------------------------------------------------------------
--  Locals

local handle_NextChaos = nil

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["chaos_message"] = "Incite Chaos! Next in ~70sec"
	L["chaos_warning"] = "Incite Chaos Soon!"
	L["chaos_nextbar"] = "~Possible Incite Chaos"
	L["engage_message"] = "Engaged - Incite Chaos in ~15sec!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Chaos", 33676)
	self:Death("Win", 18667)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
end

function mod:OnEngage()
	self:Message(33676, L["engage_message"], "Attention")
	self:Bar(33676, L["chaos_nextbar"], 15, 33676)
end

local function nextchaos()
	mod:Message(33676, L["chaos_warning"], "Attention", nil, "Alarm")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Chaos(_, spellId, _, _, spellName)
	self:CancelTimer(handle_NextChaos, true)
	self:SendMessage("BigWigs_StopBar", self, L["chaos_nextbar"])
	handle_NextChaos = self:ScheduleTimer(nextchaos, 65)

	self:Message(33676, L["chaos_message"], "Important", spellId)
	self:Bar(33676, spellName, 15, spellId)
	self:Bar(33676, L["chaos_nextbar"], 70, spellId)
end
