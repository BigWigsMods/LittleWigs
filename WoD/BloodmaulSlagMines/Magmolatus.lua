
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Magmolatus", 1175, 893)
if not mod then return end
mod:RegisterEnableMob(74475, 74366, 74570, 74571) -- Magmolatus, Forgemaster Gog'duh, Ruination, Calamity
mod.engageId = 1655
mod.respawnTime = 34

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		150076, -- Throw Earth
		150078, -- Throw Fire
		150038, -- Molten Impact
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "SpawnAdd", 150076, 150078) -- Throw Earth, Throw Fire

	self:Log("SPELL_CAST_START", "MoltenImpact", 150038)
	self:Death("Stage2", 74366)
end

function mod:OnEngage()
	self:Message("stages", "Neutral", nil, CL.stage:format(1), false)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SpawnAdd(args)
	self:Message(args.spellId, "Positive", "Info", CL.add_spawned)
end

function mod:MoltenImpact(args)
	self:Message(args.spellId, "Urgent", "Warning")
end

function mod:Stage2()
	self:Message("stages", "Neutral", nil, CL.stage:format(2), false)
end
