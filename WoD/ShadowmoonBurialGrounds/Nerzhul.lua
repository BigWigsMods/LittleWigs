
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ner'zhul", 969, 1160)
if not mod then return end
mod:RegisterEnableMob(76407)
--BOSS_KILL#1682#Ner'zhul

--------------------------------------------------------------------------------
-- Locals
--

local omenCounter = 1

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
		154442, -- Malevolence
		154350, -- Omen of Death
		-9680, -- Ritual of Bones
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "Malevolence", 154442)
	self:Log("SPELL_SUMMON", "OmenOfDeath", 154350)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "RitualOfBones", "boss1")

	self:Death("Win", 76407)
end

function mod:OnEngage()
	self:CDBar(-9680, 20.6) -- Ritual of Bones
	self:CDBar(154350, 11) -- Omen of Death
	omenCounter = 1
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Malevolence(args)
	self:Message(args.spellId, "Attention", self:Tank() and "Alarm")
	self:CDBar(args.spellId, 9) -- 8.4-10.8, remove?
end

do
	-- BETA: 36.8, 13.7, 35.8, 17.2, 37, 14.8, 35.8
	function mod:OmenOfDeath(args)
		self:Message(args.spellId, "Important", "Alert")
		self:CDBar(args.spellId, omenCounter % 2 == 0 and 14 or 35.8)
		omenCounter = omenCounter + 1
	end
end

function mod:RitualOfBones(_, _, _, _, spellId)
	if spellId == 154671 then -- Ritual of Bones
		self:Message(-9680, "Urgent", "Warning")
		self:CDBar(-9680, 50.5) -- 50.5-53.0
	end
end

