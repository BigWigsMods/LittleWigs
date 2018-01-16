
--------------------------------------------------------------------------------
-- TODO List:
-- - UNIT_HEALTH_FREQUENT warnings are coded badly, was in a hurry, fix pls

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Inquisitor Tormentorum", 1045, 1695)
if not mod then return end
mod:RegisterEnableMob(96015)
mod.engageId = 1850

--------------------------------------------------------------------------------
-- Locals
--

local warnedForTeleport1 = nil
local warnedForTeleport2 = nil

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		200898, -- Teleport
		202455, -- Void Shield
		212564, -- Inquisitive Stare
		{200904, "FLASH"}, -- Sapped Soul
		196208, -- Seed of Corruption
		201488, -- Frightening Shout
		199918, -- Shadow Crash
		203685, -- Flesh to Stone
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Teleport", 200898)
	self:Log("SPELL_AURA_APPLIED", "VoidShieldApplied", 202455)
	self:Log("SPELL_AURA_REMOVED", "VoidShieldRemoved", 202455)
	self:Log("SPELL_AURA_APPLIED", "InquisitiveStare", 212564)
	self:Log("SPELL_AURA_REFRESH", "InquisitiveStare", 212564)
	self:Log("SPELL_CAST_SUCCESS", "SapSoul", 206303)
	self:Log("SPELL_AURA_APPLIED", "SappedSoul", 200904)
	self:Log("SPELL_AURA_REFRESH", "SappedSoul", 200904)
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	self:Log("SPELL_CAST_START", "SeedofCorruption", 196208)
	self:Log("SPELL_CAST_START", "FrighteningShout", 201488)
	self:Log("SPELL_AURA_APPLIED", "ShadowCrashDamage", 199918) -- Shadow Crash
	self:Log("SPELL_PERIODIC_DAMAGE", "ShadowCrashDamage", 199918)
	self:Log("SPELL_PERIODIC_MISSED", "ShadowCrashDamage", 199918)
	self:Log("SPELL_AURA_APPLIED_DOSE", "FleshToStoneApplied", 203685)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Teleport(args)
	self:Message(args.spellId, "Attention", "Info", CL.casting:format(args.spellName))
end

function mod:VoidShieldApplied(args)
	self:Bar(args.spellId, 10, CL.onboss:format(args.spellName))
end

function mod:VoidShieldRemoved(args)
	self:Message(args.spellId, "Positive", "Info", CL.removed:format(args.spellName))
end

do
	local prev = 0
	function mod:InquisitiveStare(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 0.5 then
			prev = t
			self:Message(args.spellId, "Urgent", "Alarm")
		end
	end
end

function mod:SapSoul(args)
	self:Message(200904, "Attention", "Info", CL.casting:format(args.spellName))
	self:CDBar(200904, 15.8, args.spellName)
end

do
	local prev = 0
	function mod:SappedSoul(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 0.5 then
			prev = t
			self:TargetMessage(args.spellId, args.destName, "Important", "Long")
			self:Flash(args.spellId)
		end
	end
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 75 and not warnedForTeleport1 then -- Teleport at 70%
		warnedForTeleport1 = true
		self:Message(200898, "Attention", nil, CL.soon:format(self:SpellName(200898))) -- Teleport soon
	elseif hp < 45 and not warnedForTeleport2 then -- Teleport at 40%
		warnedForTeleport2 = true
		self:Message(200898, "Important", nil, CL.soon:format(self:SpellName(200898))) -- Teleport soon
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
	end
end

function mod:SeedofCorruption(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end

function mod:FrighteningShout(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end

do
	local prev = 0
	function mod:ShadowCrashDamage(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "Personal", "Alert", CL.underyou:format(args.spellName))
		end
	end
end

do
	local scheduled, spellName = nil, mod:SpellName(203685)

	local function sortTable(x, y)
		if x.stacks == y.stacks then
			return x.name > y.name
		else
			return x.stacks > y.stacks
		end
	end

	local function printStacks(self, spellId)
		local meOnly = self:CheckOption(spellId, "ME_ONLY")
		if meOnly then
			local stacks = select(4, UnitDebuff("player", spellName)) or 0
			if stacks > 6 then
				self:StackMessage(spellId, self:UnitName("player"), stacks, "Urgent", stacks < 9 and "Alarm" or "Warning")
			end
		else
			local stacksOnMe = 0
			local affectedPlayers = {}
			for unit in self:IterateGroup() do
				local stacks = select(4, UnitDebuff(unit, spellName)) or 0
				if stacks > 6 then
					affectedPlayers[#affectedPlayers + 1] = { name = self:UnitName(unit), stacks = stacks }
					if UnitIsUnit("player", unit) then
						stacksOnMe = stacks
					end
				end
			end
			if #affectedPlayers == 1 then
				self:StackMessage(spellId, affectedPlayers[1].name, affectedPlayers[1].stacks, "Urgent", (self:UnitName("player") == affectedPlayers[1].name or self:Dispeller("magic")) and (affectedPlayers[1].stacks < 9 and "Alarm" or "Warning"))
			elseif #affectedPlayers > 1 then
				table.sort(affectedPlayers, sortTable)
				for i, v in ipairs(affectedPlayers) do
					affectedPlayers[i] = CL.count:format(self:ColorName(v.name), v.stacks)
				end
				local list = table.concat(affectedPlayers, ", ")
				local stacksOfInterest = self:Dispeller("magic") and affectedPlayers[1].stacks or stacksOnMe
				self:Message(spellId, "Urgent", stacksOfInterest > 8 and "Warning" or stacksOfInterest > 6 and "Alarm", CL.other:format(spellName, list))
			end
		end
		scheduled = nil
	end

	function mod:FleshToStoneApplied(args)
		if not scheduled then
			scheduled = self:ScheduleTimer(printStacks, 0.3, self, args.spellId)
		end
	end
end
