
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("General Husam", 755, 117)
if not mod then return end
mod:RegisterEnableMob(44577)
mod.engageId = 1052
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		83445, -- Shockwave
		91263, -- Detonate Traps
		83113, -- Bad Intentions
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Shockwave", 83445)
	self:Log("SPELL_CAST_START", "DetonateTraps", 91263)
	self:Log("SPELL_CAST_SUCCESS", "BadIntentions", 83113)
end

function mod:OnEngage()
	self:CDBar(83445, 18) -- Shockwave
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Shockwave(args)
	self:MessageOld(args.spellId, "red", "info")
	self:Bar(args.spellId, 5, CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 40)
end

function mod:DetonateTraps(args)
	self:MessageOld(args.spellId, "orange", "alarm")
end

function mod:BadIntentions(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow", "alert")
	self:CDBar(args.spellId, 25)
end

