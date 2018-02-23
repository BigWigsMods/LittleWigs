
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gu Cloudstrike", 877, 673)
if not mod then return end
mod:RegisterEnableMob(56747, 56754) -- Gu, Serpent
mod.engageId = 1303
mod.respawnTime = 15

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-5632, -- Lightning Breath
		-5633, -- Magnetic Shroud
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
	self:Message("stages", "Positive", "Info", CL.stage:format(1)..": "..self.displayName, false)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LightningBreath(args)
	self:Message(-5632, "Urgent", "Alert", args.spellId)
	self:CDBar(-5632, 9.5, args.spellId) -- 9.6 - 9.7
end

function mod:MagneticShroud(args)
	self:Message(-5633, "Attention", nil, args.spellId)
	self:CDBar(-5633, 13, args.spellId) -- 13.2 - 15.7
end

function mod:Stage2()
	local _, serpent = EJ_GetCreatureInfo(2, 673)
	self:Message("stages", "Positive", "Info", CL.stage:format(2)..": "..serpent, false)
	self:CDBar(-5632, 7, 102573) -- Breath
	self:Bar(-5633, 20, 107140) -- Shroud
end

function mod:Stage3()
	self:Message("stages", "Positive", "Info", CL.stage:format(3)..": "..self.displayName.. " ("..self:SpellName(65294)..")", false) -- (Empowered)
	self:StopBar(102573) -- Breath
	self:StopBar(107140) -- Shroud
end

function mod:StaticField(args)
	if self:Me(args.destGUID) then
		self:Message(-5630, "Personal", "Alarm", CL.underyou:format(args.spellName), 106941)
		self:Flash(-5630)
	end
end
