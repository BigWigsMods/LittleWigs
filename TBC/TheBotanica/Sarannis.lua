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
	self:Log("SPELL_CAST_START", "GreaterHeal", 35096)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	-- Summon Reinforcements:
	if self:Normal() then -- at 55%
		self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	else -- every minute
		self:CDBar(-5411, 60)
		self:DelayedMessage(-5411, 55, "Attention", CL.soon:format(self:SpellName(-5411)))
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ArcaneResonance(args)
	self:TargetMessage(args.spellId, args.spellName, "Important")
end

function mod:GreaterHeal(args)
	self:Message(args.spellId, "Urgent", self:Interrupter() and "Warning" or "Alarm", CL.casting:format(args.spellName))
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 60 then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		self:Message(-5411, "Neutral", nil, CL.soon:format(self:SpellName(-5411))) -- Summon Reinforcements
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 34803 then -- Summon Reinforcements
		self:Message(-5411, "Attention", "Info")
		if not self:Normal() then
			self:CDBar(-5411, 60)
			self:DelayedMessage(-5411, 55, "Attention", CL.soon:format(self:SpellName(-5411)))
		end
	end
end
