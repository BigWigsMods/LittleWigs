
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gu Cloudstrike", 959, 673)
if not mod then return end
mod:RegisterEnableMob(56747, 56754) -- Gu, Serpent
mod.engageId = 1303
mod.respawnTime = 15

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		102573, -- Lightning Breath
		107140, -- Magnetic Shroud
		{-5630, "FLASH"}, -- Static Field
		"stages",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "LightningBreath", 102573)
	self:Log("SPELL_CAST_START", "MagneticShroud", 107140)
	self:Log("SPELL_AURA_APPLIED", "Stage2", 110945) -- Charging Soul
	self:Log("SPELL_AURA_REMOVED", "Stage3", 110945)

	self:Log("SPELL_DAMAGE", "StaticField", 106932, 128889)
	self:Log("SPELL_MISSED", "StaticField", 106932, 128889)
end

function mod:OnEngage()
	self:MessageOld("stages", "green", "info", CL.stage:format(1)..": "..self.displayName, false)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LightningBreath(args)
	self:MessageOld(args.spellId, "orange", "alert")
	self:CDBar(args.spellId, 9.5) -- 9.6 - 9.7
end

function mod:MagneticShroud(args)
	self:MessageOld(args.spellId, "yellow", nil)
	self:CDBar(args.spellId, 13) -- 13.2 - 15.7
end

function mod:Stage2()
	local _, serpent = EJ_GetCreatureInfo(2, 673)
	self:MessageOld("stages", "green", "info", CL.stage:format(2)..": "..serpent, false)
	self:CDBar(102573, 7) -- Breath
	self:Bar(107140, 20) -- Shroud
end

function mod:Stage3()
	self:MessageOld("stages", "green", "info", CL.stage:format(3)..": "..self.displayName.. " ("..self:SpellName(65294)..")", false) -- (Empowered)
	self:StopBar(102573) -- Breath
	self:StopBar(107140) -- Shroud
end

function mod:StaticField(args)
	if self:Me(args.destGUID) then
		self:MessageOld(-5630, "blue", "alarm", CL.underyou:format(args.spellName), 106941)
		self:Flash(-5630)
	end
end
