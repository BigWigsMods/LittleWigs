-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Prophet Tharon'ja", 600, 591)
if not mod then return end
mod:RegisterEnableMob(26632)
mod.engageId = 1975
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		"stages",
		59971, -- Rain of Fire
		49527, -- Curse of Life
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:Log("SPELL_AURA_APPLIED", "RainOfFire", 49518, 59971) -- normal, heroic
	self:Log("SPELL_PERIODIC_DAMAGE", "RainOfFire", 49518, 59971)
	self:Log("SPELL_PERIODIC_MISSED", "RainOfFire", 49518, 59971)
	self:Log("SPELL_AURA_APPLIED", "CurseOfLife", 49527, 59972) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "CurseOfLifeRemoved", 49527, 59972)
	self:Log("SPELL_CAST_SUCCESS", "DecayFlesh", 49356)
	self:Log("SPELL_CAST_SUCCESS", "ReturnFlesh", 53463)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:UNIT_HEALTH(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 60 then
		self:UnregisterUnitEvent(event, unit)
		self:MessageOld("stages", "cyan", nil, CL.soon:format(CL.phase:format(2)), false)
	end
end

function mod:DecayFlesh()
	self:DelayedMessage("stages", 3, "cyan", CL.phase:format(2)) -- the 3s stun that's being applied before the 2nd phase starts
	self:CDBar("stages", 23.64, CL.phase:format(1), 53463)
end

function mod:ReturnFlesh()
	self:DelayedMessage("stages", 3, "cyan", CL.phase:format(1)) -- the 3s stun that's being applied before transitioning back to the 1st phase
end

do
	local prev = 0
	function mod:RainOfFire(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:MessageOld(59971, "blue", "alert", CL.you:format(args.spellName))
			end
		end
	end
end

function mod:CurseOfLife(args)
	if self:Me(args.destGUID) or self:Healer() then -- despite its name, it's not actually a curse
		self:TargetMessageOld(49527, args.destName, "orange")
		self:TargetBar(49527, 9, args.destName)
	end
end

function mod:CurseOfLifeRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
