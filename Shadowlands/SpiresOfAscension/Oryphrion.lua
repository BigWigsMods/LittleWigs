--------------------------------------------------------------------------------
-- TODO:
-- - Mythic Abilties
-- - Improve timers
-- - Respawn

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Oryphrion", 2285, 2414)
if not mod then return end
mod:RegisterEnableMob(162060) -- Oryphrion
mod.engageId = 2358
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		323878, -- Drained
		324046, -- Recharge Anima
		324427, -- Empyreal Ordnance
		{334053, "SAY"}, -- Purifying Blast
		324608, -- Charged Stomp
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "DrainedApplied", 323878)
	self:Log("SPELL_CAST_START", "RechargeAnima", 324046)
	self:Log("SPELL_CAST_START", "EmpyrealOrdnance", 324427)
	self:Log("SPELL_CAST_START", "PurifyingBlast", 334053)
	self:Log("SPELL_CAST_START", "ChargedStomp", 324608)
end

function mod:OnEngage()
	self:Bar(324427, 17) -- Empyreal Ordnance
	self:Bar(334053, 8.5) -- Purifying Blast
	self:Bar(324608, 46) -- Charged Stomp
	self:Bar(323878, self:Mythic() and 89 or 108) -- Drained
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DrainedApplied(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "long")
	--self:Bar(args.spellId, 42)
end

function mod:RechargeAnima(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	--self:CastBar(args.spellId, 0)
	--self:Bar(args.spellId, 42)
end

function mod:EmpyrealOrdnance(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 26)
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) then
			self:Say(334053)
			self:PlaySound(334053, "warning")
		end
		self:TargetMessage(334053, "red", name)
	end

	function mod:PurifyingBlast(args)
		self:GetBossTarget(printTarget, args.sourceGUID)
		self:CDBar(args.spellId, 13)
	end
end

function mod:ChargedStomp(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 26)
end
