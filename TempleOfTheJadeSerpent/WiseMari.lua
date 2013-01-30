
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Wise Mari", 867, 672)
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
	return {"ej:6327", "stages", "bosskill"}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CallWater", 106526)
	self:Log("SPELL_CAST_START", "BubbleBurst", 106612)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Deaths", 56448, 56511)
end

function mod:OnEngage()
	self:Message("stages", CL["phase"]:format(1), "Positive", nil, "Info")
	deaths = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CallWater(args)
	self:DelayedMessage("ej:6327", 5, CL["add_spawned"], "Important", args.spellId, "Alert")
	self:Bar("ej:6327", CL["next_add"], 5, args.spellId)
end

function mod:BubbleBurst(args)
	self:DelayedMessage("stages", 4, CL["phase"]:format(2), "Positive", nil, "Info")
	self:Bar("stages", args.spellName, 4, args.spellId)
end

function mod:Deaths(args)
	if args.mobId == 56448 then
		self:Win()
	else
		deaths = deaths + 1
		self:Message("ej:6327", CL["add_killed"]:format(deaths, 4), "Attention", 106526)
	end
end

