
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Doctor Ickus", 2289, 2403)
if not mod then return end
mod:RegisterEnableMob(164967) -- Doctor Ickus
mod.engageId = 2384
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		322358, -- Burning Strain
		329217, -- Slime Lunge
		329110, -- Slime Injection
		332617, -- Pestilence Surge
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BurningStrain", 322358)
	self:Log("SPELL_CAST_SUCCESS", "SlimeLunge", 329217)
	self:Log("SPELL_CAST_SUCCESS", "SlimeInjection", 329217)
	self:Log("SPELL_AURA_APPLIED", "SlimeInjectionApplied", 329217)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SlimeInjectionApplied", 329217)
	self:Log("SPELL_AURA_REMOVED", "SlimeInjectionRemoved", 329217)
	self:Log("SPELL_CAST_SUCCESS", "PestilenceSurge", 332617)
end

function mod:OnEngage()
	--self:CDBar(329217, 8.6) -- Slime Lunge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BurningStrain(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:SlimeLunge(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	--self:CDBar(args.spellId, 8.6)
end

function mod:SlimeInjection(args)
	--self:CDBar(args.spellId, 8.6)
end

function mod:SlimeInjectionApplied(args)
	local amount = args.amount or 0
	self:StackMessage(args.spellId, args.destName, args.amount, "cyan")
	self:PlaySound(args.spellId, "info")
end

function mod:SlimeInjectionRemoved(args)
	self:Message2(args.spellId, "yellow", CL.spawning:format(self:SpellName(-21712))) -- Slithering Ooze
	self:PlaySound(args.spellId, "alert")
end

function mod:PestilenceSurge(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "warning")
	--self:CDBar(args.spellId, 8.6)
end
