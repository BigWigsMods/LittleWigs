--TO DO
--Fix timers
--maybe some sort of dispel warning when people reach x stacks of Withering Soul?

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Talixae Flamewreath", 1087, 1719)
if not mod then return end
mod:RegisterEnableMob(104217)
--mod.engageId = 1869

--------------------------------------------------------------------------------
-- Locals
--

local burningIntensityCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		207881, -- Infernal Eruption
		207906, -- Burning Intensity
		208165, -- Withering Soul
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "InfernalEruption", 207881)
	self:Log("SPELL_CAST_START", "BurningIntensity", 207906)
	self:Log("SPELL_CAST_START", "WitheringSoul", 208165)

	self:Death("Win", 104217)
end

function mod:OnEngage()
	burningIntensityCount = 0
	--self:CDBar(??, ??)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InfernalEruption(args)
	self:Message(args.spellId, "Urgent", "Long")
	--self:CDBar(args.spellId, ??)
end

function mod:BurningIntensity(args)
	burningIntensityCount = burningIntensityCount + 1
	self:Message(args.spellId, "Important", "Info", CL.count:format(args.spellName, burningIntensityCount))
	--self:CDBar(args.spellId, ??)
end

function mod:WitheringSoul(args)
	self:Message(args.spellId, "Attention", "Alert")
	--self:CDBar(args.spellId, ??)
end
