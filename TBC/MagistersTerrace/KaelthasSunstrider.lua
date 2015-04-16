-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Kael'thas Sunstrider", 798, 533)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(24664)
mod.toggleOptions = {
	44224, -- Gravity Lapse
	44194, -- Summon Phoenix
	"flamestrike",
	"bosskill",
	46165, -- Shock Barrier
	36819, -- Pyro Blast
}
mod.optionsHeader = {
	[44224] = "general",
	[46165] = "heroic",
}

-------------------------------------------------------------------------------
--  Locals

local glapseannounced
local handle

-------------------------------------------------------------------------------
--  Localization

local LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Kael'thas Sunstrider", "enUS", true)
if L then
	--@do-not-package@
	L["barrier_next_bar"] = "~ Next Shock Barrier"
	L["barrier_soon_message"] = "Shock Barrier Soon!"
	L["flamestrike"] = "Flame Strike"
	L["flamestrike_desc"] = "Warn when a Flame Strike is cast."
	L["glapse_message"] = "Gravity Lapse Soon!"
	--@end-do-not-package@
	--@localization(locale="enUS", namespace="MagistersTerrace/Kael_thas", format="lua_additive_table", handle-unlocalized="ignore")@
end

L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Kael'thas Sunstrider")
mod.locale = L

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	glapseannounce = nil

	self:RegisterEvent("UNIT_HEALTH")
	self:Log("SPELL_CAST_START", "Lapse", 44224)
	self:Log("SPELL_CAST_START", "Pyro", 36819)
	self:Log("SPELL_SUMMON", "Phoenix", 44194)
	self:Log("SPELL_SUMMON", "FlameStrike", 44192, 46162)
	self:Log("SPELL_AURA_APPLIED", "Barrier", 46165)
	self:Death("Win", 24664)
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
end

function mod:OnEngage()
	self:Bar(46165, L["barrier_next_bar"], 60, 46165)
	handle = self:ScheduleTimer(BarrierSoon, 50)
end

local function BarrierSoon()
	mod:Message(46165, L["barrier_soon_message"], "Attention", 46165)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:UNIT_HEALTH(event, msg)
	if UnitName(msg) ~= mod.displayName then return end
	local health = UnitHealth(msg)
	if health > 48 and health <= 52 and not glapseannounced then
		glapseannounced = true
		self:Message(44224, L["glapse_message"], "Important", 44224)
	elseif health > 60 and glapseannounced then
		glapseannounced = nil
	end

	if glapseannounced and handle then
		self:SendMessage("BigWigs_StopBar", self, L["bdbar"])
		self:CancelTimer(handle)
	end
end

function mod:Lapse(_, _, _, _, spellName)
	self:Bar(44224, spellName, 35, 44224)
end

function mod:Phoenix(_, _, _, _, spellName)
	self:Message(44194, spellName, "Urgent", 44194)
end

function mod:FlameStrike(_, _, _, _, spellName)
	self:Message("flamestrike", spellName, "Important", 44192)
end

function mod:Barrier(_, _, _, _, spellName)
	self:Message(46165, spellName, "Important", 46165)
end

function mod:Pyro(_, spellId, _, _, spellName)
	self:Bar(36819, spellName, 4, spellId)
	self:Message(36819, LCL["casting"]:format(spellName), "Important", spellId)
end
