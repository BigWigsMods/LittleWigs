
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Mindbender Ghur'sha", 643, 103)
if not mod then return end
mod:RegisterEnableMob(40788, 40825)
mod.engageId = 1046
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{76207, "ICON"}, -- Enslave
		76307, -- Absorb Magic
		76230, -- Mind Fog
		"stages",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Enslave", 76207)
	self:Log("SPELL_AURA_REMOVED", "EnslaveRemoved", 76207)
	self:Log("SPELL_CAST_START", "AbsorbMagic", 76307)
	self:Log("SPELL_AURA_APPLIED", "MindFog", 76230)

	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_HEALTH_FREQUENT(event, unit)
	if self:MobId(UnitGUID(unit)) == 40825 then -- Erunak Stonespeaker
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 55 then
			self:UnregisterUnitEvent(event, unit)
			self:Message("stages", "green", nil, CL.soon:format(CL.stage:format(2)), false)
		end
	end
end

function mod:Enslave(args)
	self:TargetMessage(args.spellId, args.destName, "red", "Alert")
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:EnslaveRemoved(args)
	self:PrimaryIcon(args.spellId)
end

function mod:AbsorbMagic(args)
	self:Message(args.spellId, "orange", nil, CL.casting:format(args.spellName))
end

function mod:MindFog(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "blue", "Alarm")
	end
end

