-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Talon King Ikiss", 556, 543)
if not mod then return end
mod:RegisterEnableMob(18473)
mod.engageId = 1902
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Locals
--

local explosionWarnings = 1

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		38197, -- Arcane Explosion
		38245, -- Polymorph
		35032, -- Slow
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil,  "boss1")
	self:Log("SPELL_CAST_SUCCESS", "ArcaneExplosion", 38197, 40425) -- normal, heroic
	self:Log("SPELL_AURA_APPLIED", "Polymorph", 38245, 43309) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "PolymorphRemoved", 38245, 43309)
	self:Log("SPELL_CAST_SUCCESS", "SlowCast", 35032)
	self:Log("SPELL_AURA_APPLIED", "Slow", 35032)
	self:Log("SPELL_AURA_REMOVED", "SlowRemoved", 35032)
end

function mod:OnEngage()
	explosionWarnings = 1
	if not self:Normal() then
		self:CDBar(35032, 12.8) -- Slow
	end
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:ArcaneExplosion(args)
	self:Message(38197, "Urgent", "Warning", CL.casting:format(args.spellName))
	self:CastBar(38197, 5)
end

function mod:Polymorph(args)
	self:TargetMessage(38245, args.destName, "Attention")
	self:TargetBar(38245, 6, args.destName)
end

function mod:PolymorphRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

do
	local playerList, isOnMe = mod:NewTargetList(), nil
	local function announce(self, spellId, spellName)
		-- this applies to the whole group but can be immuned
		if self:Dispeller("magic") then -- the only case where we care who exactly got the debuff
			self:TargetMessage(spellId, playerList, "Important", "Alarm", nil, nil, true)
		else
			wipe(playerList)
			if isOnMe then
				self:TargetMessage(spellId, isOnMe, "Important", "Alarm")
			else
				self:Message(spellId, "Important")
			end
		end
		isOnMe = nil
	end

	function mod:Slow(args)
		if self:Me(args.destGUID) then
			isOnMe = args.destName
			self:TargetBar(args.spellId, 8, args.destName)
		end
		playerList[#playerList + 1] = args.destName
		if #playerList == 1 then
			self:ScheduleTimer(announce, 0.3, args.spellId, args.spellName)
		end
	end

	function mod:SlowRemoved(args)
		self:StopBar(args.spellName, args.destName)
	end

	function mod:SlowCast(args)
		self:CDBar(args.spellId, 18.2) -- 18.2 - 19.4, can be further delayed by Arcane Explosions
	end
end

do
	local warnAt = { 85, 55, 30 }
	function mod:UNIT_HEALTH_FREQUENT(unit)
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < warnAt[explosionWarnings] then
			explosionWarnings = explosionWarnings + 1
			self:Message(38197, "Urgent", nil, CL.soon:format(self:SpellName(38197))) -- Arcane Explosion

			while explosionWarnings <= #warnAt and hp < warnAt[explosionWarnings] do
				-- account for high-level characters hitting multiple thresholds
				explosionWarnings = explosionWarnings + 1
			end

			if explosionWarnings > #warnAt then
				self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
			end
	 	end
	end
end
