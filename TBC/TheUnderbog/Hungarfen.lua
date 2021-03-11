-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Hungarfen", 546, 576)
if not mod then return end
mod:RegisterEnableMob(17770)
-- mod.engageId = 1946 -- doesn't fire ENCOUNTER_END on a wipe
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		-6008, -- Foul Spores
		{31689, "ME_ONLY"}, -- Spore Cloud
	}, {
		[-6008] = "general",
		[31689] = -6006, -- Underbog Mushroom
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "SporeCloud", 31689)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SporeCloud", 31689)
	self:Log("SPELL_AURA_REMOVED", "SporeCloudRemoved", 31689)

	self:Log("SPELL_AURA_APPLIED", "FoulSpores", 31673) -- channel that can be offensively dispelled
	self:Log("SPELL_AURA_REMOVED", "FoulSporesRemoved", 31673)
	self:Log("SPELL_DAMAGE", "FoulSporesDamage", 31697)
	self:Log("SPELL_MISSED", "FoulSporesDamage", 31697)
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 17770)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:SporeCloud(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "orange", self:Me(args.destGUID) and "warning" or "info")
	self:TargetBar(args.spellId, 20, args.destName)
end

function mod:SporeCloudRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:FoulSpores(args)
	self:MessageOld(-6008, "yellow", "alarm", CL.casting:format(args.spellName))
	self:CastBar(-6008, 11)
end

function mod:FoulSporesRemoved(args)
	self:StopBar(CL.cast:format(args.spellName))
end

do
	local prev = 0
	function mod:FoulSporesDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > (self:Melee() and 4 or 1.5) then -- melees/tank can't hit the boss while he's casting that but they are still healing the boss taking this damage and he's immobile, so not throttling for the entire cast
				prev = t
				self:MessageOld(-6008, "blue", "alert", CL.you:format(args.spellName))
			end
		end
	end
end

function mod:UNIT_HEALTH(event, unit)
	local hp = UnitHealth(unit) / UnitHealth(unit) * 100
	if hp < 25 then
		self:UnregisterUnitEvent(event, unit)
		self:MessageOld(-6008, "orange", nil, CL.soon:format(self:SpellName(-6008))) -- Foul Spores
	end
end
