if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gorak Tul", 1862, 2129)
if not mod then return end
mod:RegisterEnableMob(131864)
mod.engageId = 2117

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		266181, -- Dread Essence
		266258, -- Summon Deathtouched Slaver
		266225, -- Darkened Lightning
		268208, -- Grim Portal
		268202, -- Death Lens
		266198, -- Alchemical Fire
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DreadEssence", 266181)
	self:Log("SPELL_CAST_SUCCESS", "SummonDeathtouchedSlaver", 266258)
	self:Log("SPELL_CAST_START", "DarkenedLightning", 266225)
	self:Log("SPELL_CAST_SUCCESS", "GrimPortal", 268208)
	self:Log("SPELL_AURA_APPLIED", "DeathLens", 268202)
	self:Log("SPELL_CAST_SUCCESS", "AlchemicalFire", 266198)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DreadEssence(args)
	self:Message(args.spellId, "red", "Warning")
end

function mod:SummonDeathtouchedSlaver(args)
	self:Message(args.spellId, "yellow", "Alert")
end

function mod:DarkenedLightning(args)
	self:Message(args.spellId, "orange", self:Interrupter() and "Warning")
end

function mod:GrimPortal(args)
	self:Message(args.spellId, "cyan", "Info")
end

function mod:DeathLens(args)
	self:TargetMessage(args.spellId, args.destName, "orange", "Alarm", nil, nil, self:Healer())
end

function mod:AlchemicalFire(args)
	self:Message(args.spellId, "green", "Long")
end
