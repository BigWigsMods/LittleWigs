
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

local nextTeleportSoonWarning = 0

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
	self:Log("SPELL_CAST_SUCCESS", "SapSoul", 206303) -- Mythic, Mythic+
	self:Log("SPELL_CAST_SUCCESS", "SapSoulInterruptible", 200905) -- Normal, Heroic
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
	nextTeleportSoonWarning = 75 -- Teleport at 70%
	self:CDBar(200904, 11.6, self:SpellName(206303)) -- Sap Soul
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
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 0.5 then
				prev = t
				self:Message(args.spellId, "Urgent", "Alarm")
			end
		end
	end
end

function mod:SapSoul(args)
	self:Message(200904, "Attention", "Info", CL.casting:format(args.spellName))
	self:CDBar(200904, 15.8, args.spellName)
end

function mod:SapSoulInterruptible(args)
	self:Message(200904, "Attention", self:Interrupter() and "Warning" or "Info", CL.casting:format(args.spellName))
	self:CDBar(200904, 20, args.spellName)
end

do
	local prev = 0
	function mod:SappedSoul(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 0.5 then
				prev = t
				self:TargetMessage(args.spellId, args.destName, "Important", "Long")
				self:Flash(args.spellId)
			end
		end
	end
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < nextTeleportSoonWarning then
		self:Message(200898, "Attention", nil, CL.soon:format(self:SpellName(200898)))
		nextTeleportSoonWarning = nextTeleportSoonWarning - 30 -- Teleport at 40%
		if nextTeleportSoonWarning < 40 then
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		end
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
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:Message(args.spellId, "Personal", "Alert", CL.underyou:format(args.spellName))
			end
		end
	end
end

do
	local scheduled = nil

	local function sortTable(x, y)
		if x.stacks == y.stacks then
			return x.name > y.name
		else
			return x.stacks > y.stacks
		end
	end

	local function printStacks(self, spellId, spellName)
		local meOnly = self:CheckOption(spellId, "ME_ONLY")
		if meOnly then
			local _, _, _, stacks = UnitDebuff("player", spellName)
			if stacks and stacks > 6 then
				self:StackMessage(spellId, self:UnitName("player"), stacks, "Urgent")
				if stacks < 9 then
					self:PlaySound(spellId, "Alarm")
				else
					self:PlaySound(spellId, "Warning")
				end
			end
		else
			local stacksOnMe = 0
			local affectedPlayers = {}
			for unit in self:IterateGroup() do
				local _, _, _, stacks = UnitDebuff(unit, spellName)
				if stacks and stacks > 6 then
					if UnitIsUnit("player", unit) then
						stacksOnMe = stacks
						affectedPlayers[#affectedPlayers + 1] = { name = self:UnitName(unit), stacks = stacks, isOnMe = true }
					else
						affectedPlayers[#affectedPlayers + 1] = { name = self:UnitName(unit), stacks = stacks }
					end
				end
			end
			if #affectedPlayers == 1 then
				self:StackMessage(spellId, affectedPlayers[1].name, affectedPlayers[1].stacks, "Urgent")
				if affectedPlayers[1].isOnMe or self:Dispeller("magic") then
					if affectedPlayers[1].stacks < 9 then
						self:PlaySound(spellId, "Alarm")
					else
						self:PlaySound(spellId, "Warning")
					end
				end
			elseif #affectedPlayers > 1 then
				table.sort(affectedPlayers, sortTable)

				local topStacks = affectedPlayers[1].stacks
				local msg = CL.count:format(self:ColorName(affectedPlayers[1].name), topStacks) -- 1st entry
				for i = 2, #affectedPlayers do -- 2nd entry +
					local tbl = affectedPlayers[i]
					msg = msg .. ", " .. CL.count:format(self:ColorName(tbl.name), tbl.stacks)
				end
				self:Message(spellId, "Urgent", nil, CL.other:format(spellName, msg))

				local stacksOfInterest = self:Dispeller("magic") and topStacks or stacksOnMe
				if stacksOfInterest > 8 then
					self:PlaySound(spellId, "Warning")
				elseif stacksOfInterest > 6 then
					self:PlaySound(spellId, "Alarm")
				end
			end
		end
		scheduled = nil
	end

	function mod:FleshToStoneApplied(args)
		if not scheduled then
			scheduled = self:ScheduleTimer(printStacks, 0.3, self, args.spellId, args.spellName)
		end
	end
end
