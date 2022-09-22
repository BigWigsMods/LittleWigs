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
		
		{384978, "TANK_HEALER"}, -- Dragon Strike
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DragonStrike", 384978)
	self:Log("SPELL_AURA_APPLIED", "DragonStrikeApplied", 384978)
end

function mod:OnEngage()
	self:CDBar(384978, 7.5) -- Dragon Strike
end

--------------------------------------------------------------------------------
-- Event Handlers
--

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
