--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Commander Sarannis", 553, 558)
if not mod then return end
mod:RegisterEnableMob(17976)
mod.engageId = 1925
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		34794, -- Arcane Resonance
		-5411, -- Summon Reinforcements
		35096, -- Greater Heal
	}, {
		[34794] = "general",
		[35096] = -5412, -- Bloodwarder Mender
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ArcaneResonance", 34794)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ArcaneResonance", 34794)
	self:Log("SPELL_CAST_START", "GreaterHeal", 35096)

	if self:Classic() then
		self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	else
		self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	end
end

function mod:OnEngage()
	-- Summon Reinforcements:
	if self:Normal() then -- at 55%
		if self:Classic() then
			self:RegisterEvent("UNIT_HEALTH")
		else
			self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
		end
	else -- every minute
		self:CDBar(-5411, 60)
		self:DelayedMessage(-5411, 55, "yellow", CL.soon:format(self:SpellName(-5411)))
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ArcaneResonance(args)
	self:StackMessage(args.spellId, "red", args.destName, args.amount, 0)
end

function mod:GreaterHeal(args)
	self:MessageOld(args.spellId, "orange", self:Interrupter() and "warning" or "alarm", CL.casting:format(args.spellName))
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) == 17976 then
		local hp = self:GetHealth(unit)
		if hp < 60 then
			if self:Classic() then
				self:UnregisterEvent(event)
			else
				self:UnregisterUnitEvent(event, unit)
			end
			self:MessageOld(-5411, "cyan", nil, CL.soon:format(self:SpellName(-5411))) -- Summon Reinforcements
		end
	end
end

do
	local prev
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, castId, spellId)
		if spellId == 34803 and castId ~= prev then -- Summon Reinforcements
			prev = castId
			self:MessageOld(-5411, "yellow", "info")
			if not self:Normal() then
				self:CDBar(-5411, 60)
				self:DelayedMessage(-5411, 55, "yellow", CL.soon:format(self:SpellName(-5411)))
			end
		end
	end
end
