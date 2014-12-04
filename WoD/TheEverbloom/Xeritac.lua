
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Xeri'tac", 1008, 1209)
if not mod then return end
mod:RegisterEnableMob(84550)

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
		169248, -- Consume
		169233, -- Inhale
		"stages",
		"bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "Consume", 169248)
	self:Log("SPELL_CAST_START", "Inhale", 169233)

	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1")

	self:Death("Win", 84550)
end

function mod:OnEngage()
	
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Consume(args)
	self:Message(args.spellId, "Urgent", "Warning")
	self:Bar(args.spellId, 10)
end

function mod:Inhale(args)
	self:Message(args.spellId, "Important", "Info")
end

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	if UnitCanAttack("player", unit) then
		self:Message("stages", "Important", "Info", CL.incoming:format(self.displayName), "inv_misc_monsterspidercarapace_01")
	end
end

