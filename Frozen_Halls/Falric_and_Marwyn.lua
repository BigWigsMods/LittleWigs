if not QueryQuestsCompleted then return end
-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Falric and Marwyn", "Halls of Reflection")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "The Frozen Halls"
mod:RegisterEnableMob(38112, 38113)
mod.toggleOptions = {
	{72426, "ICON"}, -- Impending Despair
	{72422, "ICON"}, -- Quivering Strike
	72363, -- Corrupted Flesh
	{72368, "ICON"},-- Shared Suffering
	{72383, "ICON"}, -- Corrupted Touch
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local deaths = 0
local flesh = mod:NewTargetList()
local pName = UnitName("player")

-------------------------------------------------------------------------------
--  Localization

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Falric and Marwyn", "enUS", true)
if L then
	--@do-not-package@
	L["engage_trigger"] = "Place holder"
	--@end-do-not-package@
	--@localization(locale="enUS", namespace="Frozen_Halls/Falric_and_Marwyn", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Falric and Marwyn")
mod.locale = L

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	deaths = 0
	--[[ XXX Just leaving this here for the moment in case my condensed code doesn't work
	-- Falric
	self:Log("SPELL_AURA_APPLIED", "Despair", 72426) --6s
	self:Log("SPELL_AURA_APPLIED", "Strike", 72422) --5s

	-- Marwyn
	self:Log("SPELL_AURA_APPLIED", "Suffering", 72368) --12s
	self:Log("SPELL_AURA_APPLIED", "Touch", 72383) --10s]]--
	self:Log("SPELL_AURA_APPLIED", "Flesh", 72363) --10s no dispell

	self:Log("SPELL_AURA_REMOVED", "Debuff", 72368, 72383, 72422, 72426)
	self:Log("SPELL_AURA_REMOVED", "Removed", 72368, 72383, 72422, 72426)
	self:Death("Deaths", 38112, 38113)

	self:Yell("OnEngage", L["engage_trigger"])
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Debuff(player, spellId, _, _, spellName)
	local time = 10
	if spellId == 72426 then --Farlic Impending Despair
		time = 6
		self:SecondaryIcon(72426, player)
	elseif spellId == 72422 then -- Farlic Quivering Strike
		time = 5
		self:PrimaryIcon(72422, player)
	elseif spellId == 72368 then -- Marwyn Shared Suffering
		time=12
		self:SecondaryIcon(72368, player)
	elseif spellId == 72363 then -- Marwyn Corrupted Flesh
		self:PrimaryIcon(72363, player)
	end
	self:TargetMessage(spellId, player, spellName, "Urgent", spellId)
	self:Bar(spellId, player..": "..spellName, time, spellId)
end

-- XXX Just leaving this here for the moment in case my condensed code doesn't work
--[[function mod:Despair(player, spellId, _, _, spellName)
	self:Message(72426, spellName..": "..player, "Important", spellId)
	self:Bar(72426, player..": "..spellName, 6, spellId)
	self:SecondaryIcon(72426, player)
end

function mod:Strike(player, spellId, _, _, spellName)
	self:Message(72422, spellName..": "..player, "Important", spellId)
	self:Bar(72422, player..": "..spellName, 5, spellId)
	self:PrimaryIcon(72422, player)
end

function mod:Suffering(player, spellId, _, _, spellName)
	self:Message(72368, spellName..": "..player, "Important", spellId)
	self:Bar(72368, player..": "..spellName, 5, spellId)
	self:SecondaryIcon(72368, player)
end

function mod:Touch(player, spellId, _, _, spellName)
	self:TargetMessage(72383, player, spellName, "Urgent", spellId)
	self:Bar(72383, player..": "..spellName, 5, spellId)
	self:PrimaryIcon(72383, player)
end]]--
	
do
	local handle = nil
	local id, name = nil, nil
	local function fleshWarn()
		if not warned then
			mod:TargetMessage(72383, name, flesh, "Urgent", id)
		else
			warned = nil
			wipe(flesh)
		end
		handle = nil
	end
	function mod:Flesh(player, spellId, _, _, spellName)
		flesh[#flesh + 1] = player
		if handle then self:CancelTimer(handle) end
		id, name = spellId, spellName
		handle = self:ScheduleTimer(fleshWarn, 0.1) -- has been 0.2 before
		if player == pName then
			self:LocalMessage(72383, spellName, player, "Personal", spellId, "Info")
		end
	end
end

function mod:Removed(player, spellId, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
	self:PrimaryIcon(spellId, false)
	self:SecondaryIcon(spellId, false)
end

function mod:Deaths()
	deaths = deaths + 1
	if deaths == 2 then self:Win() end
end
