--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rezan", 1204, 2083)
if not mod then return end
mod:RegisterEnableMob(122963)
mod.engageId = 2086

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		255371, -- Terrifying Visage
		257407, -- Pursuit
		{255434, "TANK"}, -- Serrated Teeth
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "TerrifyingVisage", 255371)
	self:Log("SPELL_CAST_START", "Pursuit", 257407)
	self:Log("SPELL_CAST_SUCCESS", "SerratedTeeth", 255434)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TerrifyingVisage(args)
	self:Message(args.spellId, "red", "Warning")
end

function mod:Pursuit(args)
	self:Message(args.spellId, "orange", "Alarm") -- XXX Get target on cast start through emote
end

function mod:SerratedTeeth(args)
	self:Message(args.spellId, "yellow", "Alert")
end
