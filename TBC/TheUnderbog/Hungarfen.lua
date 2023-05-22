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
		{-6008, "CASTBAR"}, -- Foul Spores
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

	if self:Classic() then
		self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
		self:RegisterEvent("UNIT_HEALTH")
	else
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	end
	self:Death("Win", 17770)
end

function mod:OnEngage()
	if self:Classic() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:SporeCloud(args)
	self:StackMessageOld(args.spellId, args.destName, args.amount, "orange", self:Me(args.destGUID) and "warning" or "info")
	self:TargetBar(args.spellId, 20, args.destName)
end

function mod:SporeCloudRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:FoulSpores(args)
	self:MessageOld(-6008, "yellow", "alarm", CL.casting:format(args.spellName))
	self:CastBar(-6008, 11, args.spellName)
end

function mod:FoulSporesRemoved(args)
	self:StopBar(CL.cast:format(args.spellName))
end

do
	local prev = 0
	function mod:FoulSporesDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > (self:Melee() and 4 or 1.5) then -- melees/tank can't hit the boss while he's casting that but they are still healing the boss taking this damage and he's immobile, so not throttling for the entire cast
				prev = t
				self:MessageOld(-6008, "blue", "alert", CL.you:format(args.spellName))
			end
		end
	end
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) == 17770 then
		local hp = self:GetHealth(unit)
		if hp < 25 then
			if self:Classic() then
				self:UnregisterEvent(event)
			else
				self:UnregisterUnitEvent(event, unit)
			end
			self:MessageOld(-6008, "orange", nil, CL.soon:format(self:SpellName(-6008))) -- Foul Spores
		end
	end
end
