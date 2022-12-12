--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Umbrelskul", 2515, 2508)
if not mod then return end
mod:RegisterEnableMob(186738) -- Umbrelskul
mod:SetEncounterID(2584)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local brittleCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		386746, -- Brittle
		385331, -- Fracture
		385399, -- Unleashed Destruction
		385075, -- Arcane Eruption
		384699, -- Crystalline Roar
		{384978, "TANK_HEALER"}, -- Dragon Strike
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "UnleashedDestruction", 385399)
	self:Log("SPELL_CAST_START", "ArcaneEruption", 385075)
	self:Log("SPELL_CAST_SUCCESS", "CrystallineRoar", 384696)
	self:Log("SPELL_CAST_START", "DragonStrike", 384978)
	self:Log("SPELL_AURA_APPLIED", "DragonStrikeApplied", 384978)
end

function mod:OnEngage()
	brittleCount = 0
	self:CDBar(384978, 7.4) -- Dragon Strike
	self:CDBar(384699, 12.2) -- Crystalline Roar
	self:CDBar(385075, 28.2) -- Arcane Eruption
	self:CDBar(385399, 54.8) -- Unleashed Destruction
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- TODO Brittle 386746 no CLEU
function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 386746 then -- Brittle
		brittleCount = brittleCount + 1
		self:Message(spellId, "orange", CL.percent:format(100 - brittleCount * 25, self:SpellName(spellId)))
		self:PlaySound(spellId, "long")
		-- After a ~2.4 second delay the Detonating Crystals begin to cast 20s Fracture
		-- TODO no way to clean up this bar when conditions met? (no UNIT_DIED on crystals)
		self:Bar(385331, 22.4) -- Fracture
	end
end

function mod:UnleashedDestruction(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 66.8)
end

function mod:ArcaneEruption(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 55.9)
end

function mod:CrystallineRoar(args)
	self:Message(384699, "red")
	self:PlaySound(384699, "alarm")
	self:CDBar(384699, 25.5)
end

function mod:DragonStrike(args)
	if self:Tank() then
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
	end
	self:CDBar(args.spellId, 7.3)
end

function mod:DragonStrikeApplied(args)
	if self:Healer() then
		self:TargetMessage(args.spellId, "purple", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end
