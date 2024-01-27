
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
		150023, -- Slag Smash
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "SpawnAdd", 150076, 150078) -- Throw Earth, Throw Fire
	self:Log("SPELL_CAST_START", "MoltenImpact", 150038)
	self:Log("SPELL_CAST_START", "SlagSmash", 150023)
	self:Death("Stage2", 74366)
end

function mod:OnEngage()
	self:MessageOld("stages", "cyan", nil, CL.stage:format(1), false)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SpawnAdd(args)
	self:MessageOld(args.spellId, "green", "info", CL.add_spawned)
end

function mod:MoltenImpact(args)
	self:MessageOld(args.spellId, "orange", "warning")
end

function mod:SlagSmash(args)
	self:MessageOld(args.spellId, "orange", "info")
end

function mod:Stage2()
	self:MessageOld("stages", "cyan", nil, CL.stage:format(2), false)
end
