--TO DO
--maybe some sort of dispel warning when people reach x stacks of Withering Soul?

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Talixae Flamewreath", 1571, 1719)
if not mod then return end
mod:RegisterEnableMob(104217)
mod.engageId = 1869

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
	self:Log("SPELL_CAST_START", "InfernalEruption", 207881)
	self:Log("SPELL_CAST_START", "BurningIntensity", 207906)
	self:Log("SPELL_CAST_START", "WitheringSoul", 208165)
end

function mod:OnEngage()
	burningIntensityCount = 0
	self:CDBar(207906, 6) -- Burning Intensity
	self:CDBar(208165, 13) -- Withering Soul
	self:CDBar(207881, 19) -- Infernal Eruption
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InfernalEruption(args)
	self:MessageOld(args.spellId, "orange", "long")
	self:CDBar(args.spellId, 18)
end

function mod:BurningIntensity(args)
	burningIntensityCount = burningIntensityCount + 1
	self:MessageOld(args.spellId, "red", "info", CL.count:format(args.spellName, burningIntensityCount))
	self:CDBar(args.spellId, 22)
end

function mod:WitheringSoul(args)
	self:MessageOld(args.spellId, "yellow", "alert")
	self:CDBar(args.spellId, 14)
end
