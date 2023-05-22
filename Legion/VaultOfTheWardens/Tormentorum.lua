
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Inquisitor Tormentorum", 1493, 1695)
if not mod then return end
mod:RegisterEnableMob(96015)
mod.engageId = 1850

--------------------------------------------------------------------------------
-- Locals
--

local nextTeleportSoonWarning = 0
local fleshToStoneList = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		200898, -- Teleport
		202455, -- Void Shield
		{212564, "CASTBAR"}, -- Inquisitive Stare
		{200904, "FLASH"}, -- Sapped Soul
		196208, -- Seed of Corruption
		201488, -- Frightening Shout
		199918, -- Shadow Crash
		{203685, "INFOBOX"}, -- Flesh to Stone
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Teleport", 200898)
	self:Log("SPELL_AURA_APPLIED", "VoidShieldApplied", 202455)
	self:Log("SPELL_AURA_REMOVED", "VoidShieldRemoved", 202455)
	self:Log("SPELL_AURA_APPLIED", "InquisitiveStare", 212564) -- using AURA events instead of SPELL_CAST_START because a player won't get targetted if they had an immunity
	self:Log("SPELL_AURA_REFRESH", "InquisitiveStare", 212564)
	self:Log("SPELL_CAST_SUCCESS", "SapSoul", 206303) -- Mythic, Mythic+
	self:Log("SPELL_CAST_SUCCESS", "SapSoulInterruptible", 200905) -- Normal, Heroic
	self:Log("SPELL_AURA_APPLIED", "SappedSoul", 200904)
	self:Log("SPELL_AURA_REFRESH", "SappedSoul", 200904)
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:Log("SPELL_CAST_START", "SeedofCorruption", 196208)
	self:Log("SPELL_CAST_START", "FrighteningShout", 201488)
	self:Log("SPELL_AURA_APPLIED", "ShadowCrashDamage", 199918) -- Shadow Crash
	self:Log("SPELL_PERIODIC_DAMAGE", "ShadowCrashDamage", 199918)
	self:Log("SPELL_PERIODIC_MISSED", "ShadowCrashDamage", 199918)
	self:Log("SPELL_AURA_APPLIED", "FleshToStoneApplied", 203685)
	self:Log("SPELL_AURA_APPLIED_DOSE", "FleshToStoneAppliedDose", 203685)
	self:Log("SPELL_AURA_REMOVED", "FleshToStoneRemoved", 203685)
end

function mod:OnEngage()
	fleshToStoneList = {}
	nextTeleportSoonWarning = 75 -- Teleport at 70%
	self:CDBar(200904, 11.6, self:SpellName(206303)) -- Sap Soul
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Teleport(args)
	self:MessageOld(args.spellId, "yellow", "info", CL.casting:format(args.spellName))
end

function mod:VoidShieldApplied(args)
	self:Bar(args.spellId, 10, CL.onboss:format(args.spellName))
end

function mod:VoidShieldRemoved(args)
	self:MessageOld(args.spellId, "green", "info", CL.removed:format(args.spellName))
end

do
	local prev = 0
	function mod:InquisitiveStare(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 0.5 then
				prev = t
				self:MessageOld(args.spellId, "orange", "alarm")
			end
			self:CastBar(args.spellId, 3)
		end
	end
end

function mod:SapSoul(args)
	self:MessageOld(200904, "yellow", "info", CL.casting:format(args.spellName))
	self:CDBar(200904, 15.8, args.spellName)
end

function mod:SapSoulInterruptible(args)
	self:MessageOld(200904, "yellow", self:Interrupter() and "warning" or "info", CL.casting:format(args.spellName))
	self:CDBar(200904, 20, args.spellName)
end

do
	local prev = 0
	function mod:SappedSoul(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 0.5 then
				prev = t
				self:TargetMessageOld(args.spellId, args.destName, "red", "long")
				self:Flash(args.spellId)
			end
		end
	end
end

function mod:UNIT_HEALTH(event, unit)
	local hp = self:GetHealth(unit)
	if hp < nextTeleportSoonWarning then
		self:MessageOld(200898, "yellow", nil, CL.soon:format(self:SpellName(200898)))
		nextTeleportSoonWarning = nextTeleportSoonWarning - 30 -- Teleport at 40%
		if nextTeleportSoonWarning < 40 then
			self:UnregisterUnitEvent(event, unit)
		end
	end
end

function mod:SeedofCorruption(args)
	self:MessageOld(args.spellId, "orange", "warning", CL.casting:format(args.spellName))
end

function mod:FrighteningShout(args)
	self:MessageOld(args.spellId, "orange", "warning", CL.casting:format(args.spellName))
end

do
	local prev = 0
	function mod:ShadowCrashDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alert", CL.underyou:format(args.spellName))
			end
		end
	end
end

function mod:FleshToStoneApplied(args)
	if not next(fleshToStoneList) then
		self:OpenInfo(args.spellId, args.spellName)
	end
	fleshToStoneList[args.destName] = 1
	self:SetInfoByTable(args.spellId, fleshToStoneList)
end

function mod:FleshToStoneAppliedDose(args)
	fleshToStoneList[args.destName] = args.amount
	self:SetInfoByTable(args.spellId, fleshToStoneList)

	if self:Me(args.destGUID) and args.amount > 6 then
		self:StackMessageOld(args.spellId, args.destName, args.amount, "orange")
		if args.amount < 9 then
			self:PlaySound(args.spellId, "alarm")
		else
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:FleshToStoneRemoved(args)
	fleshToStoneList[args.destName] = nil
	if not next(fleshToStoneList) then
		self:CloseInfo(args.spellId)
	else
		self:SetInfoByTable(args.spellId, fleshToStoneList)
	end
end
