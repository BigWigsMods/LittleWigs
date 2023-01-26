--TO DO
--maybe some sort of dispel warning when people reach x stacks of Withering Soul?

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Talixae Flamewreath", 1571, 1719)
if not mod then return end
mod:RegisterEnableMob(104217)
mod:SetEncounterID(1869)
mod:SetRespawnTime(30)

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

function mod:OnWin()
	local trashModule = BigWigs:GetBossModule("Court of Stars Trash", true)
	if trashModule then
		-- reboot the trash module to clear clues and reassert gossip event handling
		-- order ahead of the Spy event
		trashModule:Reboot()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InfernalEruption(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 20.3)
end

function mod:BurningIntensity(args)
	burningIntensityCount = burningIntensityCount + 1
	self:Message(args.spellId, "red", CL.count:format(args.spellName, burningIntensityCount))
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, burningIntensityCount % 2 == 0 and 23.1 or 26.8)
end

function mod:WitheringSoul(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 14.2)
end
