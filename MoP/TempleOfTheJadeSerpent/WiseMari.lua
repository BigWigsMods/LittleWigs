
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Wise Mari", 867, 672)
if not mod then return end
mod:RegisterEnableMob(56448)

local deaths = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_say = "You dare to disturb these waters? You will drown!"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {-6327, "stages"}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CallWater", 106526)
	self:Log("SPELL_CAST_START", "BubbleBurst", 106612)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 56448)
	self:Death("AddDeath", 56511)
end

function mod:OnEngage()
	self:Message("stages", "Positive", "Info", CL.phase:format(1), false)
	deaths = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CallWater(args)
	self:DelayedMessage(-6327, 5, "Important", CL.count:format(CL.add_spawned, deaths+1), args.spellId, "Alert")
	self:Bar(-6327, 5, CL.next_add, args.spellId)
end

function mod:BubbleBurst(args)
	local text = CL.phase:format(2)
	self:DelayedMessage("stages", 4, "Positive", text, false, "Info")
	self:Bar("stages", 4, text, args.spellId)
end

function mod:AddDeath()
	deaths = deaths + 1
	self:Message(-6327, "Attention", nil, CL.add_killed:format(deaths, 4), 106526)
end

