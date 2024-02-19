--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Doctor Ickus", 2289, 2403)
if not mod then return end
mod:RegisterEnableMob(164967) -- Doctor Ickus
mod:SetEncounterID(2384)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local leapCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		322358, -- Burning Strain
		67382, -- Leap // Alternative to use for the boss changing platform
		329217, -- Slime Lunge
		329110, -- Slime Injection
		332617, -- Pestilence Surge
		{321406, "CASTBAR"}, -- Virulent Explosion
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")

	self:Log("SPELL_CAST_START", "BurningStrain", 322358)
	self:Log("SPELL_CAST_SUCCESS", "SlimeLunge", 329217)
	self:Log("SPELL_CAST_START", "SlimeInjection", 329110)
	self:Log("SPELL_CAST_SUCCESS", "SlimeInjectionSuccess", 329110)
	self:Log("SPELL_AURA_APPLIED", "SlimeInjectionApplied", 329110)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SlimeInjectionApplied", 329110)
	self:Log("SPELL_AURA_REMOVED", "SlimeInjectionRemoved", 329110)
	self:Log("SPELL_CAST_SUCCESS", "PestilenceSurge", 332617)
	self:Log("SPELL_CAST_START", "VirulentExplosion", 321406)
	self:Death("BombDeath", 169498) -- Plague Bomb
end

function mod:OnEngage()
	leapCount = 0
	self:CDBar(329110, 10) -- Slime Injection
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("329200") then -- Virulent Explosion
		leapCount = leapCount + 1
		-- Ickus leaps at 66% and 33% health
		self:Message(67382, "yellow", CL.percent:format(leapCount == 1 and 66 or 33, self:SpellName(67382))) -- 'Leap'
		self:PlaySound(67382, "long")
		self:CDBar(332617, 10.5) -- Pestilence Surge
	end
end

function mod:BurningStrain(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:SlimeLunge(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

do
	local function printTarget(self, name, guid)
		 -- cast on tank in an organized group, but use :Me() instead for soloers
		if self:Me(guid) then
			self:Message(329110, "purple", CL.casting:format(self:SpellName(329110)))
			self:PlaySound(329110, "alert")
		end
	end
	function mod:SlimeInjection(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
	end
end

function mod:SlimeInjectionSuccess(args)
	self:CDBar(args.spellId, 20)
end

function mod:SlimeInjectionApplied(args)
	local amount = args.amount or 0
	self:StackMessageOld(args.spellId, args.destName, args.amount, "purple")
	self:PlaySound(args.spellId, "info")
end

function mod:SlimeInjectionRemoved(args)
	self:Message(args.spellId, "yellow", CL.spawning:format(self:SpellName(-21712))) -- Erupting Ooze
	self:PlaySound(args.spellId, "alert")
end

function mod:PestilenceSurge(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

function mod:VirulentExplosion(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 30)
end

function mod:BombDeath(args)
	self:StopBar(CL.cast:format(self:SpellName(321406))) -- Virulent Explosion
end
