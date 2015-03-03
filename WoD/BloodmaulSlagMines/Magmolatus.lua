
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Magmolatus", 964, 893)
if not mod then return end
mod:RegisterEnableMob(74475, 74366, 74570, 74571) -- Magmolatus, Forgemaster Gog'duh, Ruination, Calamity
--BOSS_KILL#1655#Magmolatus

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		150076, -- Throw Earth
		150078, -- Throw Fire
		150038, -- Molten Impact
		"stages",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_SUCCESS", "SpawnAdd", 150076, 150078) -- Throw Earth, Throw Fire

	self:Log("SPELL_CAST_START", "MoltenImpact", 150038)

	self:Death("Win", 74475)
	self:Death("Stage2", 74366)
end

function mod:OnEngage()
	self:Message("stages", "Neutral", nil, CL.stage:format(1), false)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SpawnAdd(args)
	self:Message(args.spellId, "Positive", "Info", CL.add_spawned)
end

function mod:MoltenImpact(args)
	self:Message(args.spellId, "Urgent", "Warning")
end

function mod:Stage2()
	self:Message("stages", "Neutral", nil, CL.stage:format(2), false)
end

