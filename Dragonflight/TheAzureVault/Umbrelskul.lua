if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Umbrelskul", 2515, 2508)
if not mod then return end
mod:RegisterEnableMob(186738) -- Umbrelskul
mod:SetEncounterID(2584)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		386746, -- Brittle
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
	self:Log("SPELL_CAST_START", "DragonStrike", 384978)
	self:Log("SPELL_AURA_APPLIED", "DragonStrikeApplied", 384978)
end

function mod:OnEngage()
	self:CDBar(384978, 7.5) -- Dragon Strike
	self:CDBar(384699, 12.4) -- Crystalline Roar
	self:CDBar(385399, 35.5) -- Unleashed Destruction
	self:CDBar(385075, 68.3) -- Arcane Eruption
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- TODO Brittle 386746 no CLEU
-- TODO Crystalline Roar 384696 and 384699 no CLEU
function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 386746 then -- Brittle
		self:Message(spellId, "orange") -- TODO add brittle %hp to message? 75, 50, 25
		self:PlaySound(spellId, "long")
		-- After a ~2.4 second delay the Detonating Crystals begin to cast 20s Fracture
		-- TODO no way to clean up this bar when conditions met? (no UNIT_DIED on crystals)
		self:Bar(spellId, 22.4, 385331) -- Fracture
	elseif spellId == 384696 or spellId == 384699 then -- Crystalline Roar TODO pick one of these
		spellId = 384699 -- TODO temp
		self:Message(spellId, "red")
		self:PlaySound(spellId, "alarm")
		self:CDBar(spellId, 25.5)
	end
end

function mod:UnleashedDestruction(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 66.8)
end

function mod:ArcaneEruption(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info") -- TODO long candidate?
	self:CDBar(args.spellId, 61.9)
end

function mod:DragonStrike(args)
	if self:Tank() then
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
	end
	self:CDBar(args.spellId, 12.2)
end

function mod:DragonStrikeApplied(args)
	if self:Healer() then
		self:TargetMessage(args.spellId, "purple", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end
