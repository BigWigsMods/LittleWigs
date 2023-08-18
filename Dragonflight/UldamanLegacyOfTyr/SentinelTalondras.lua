--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sentinel Talondras", 2451, 2484)
if not mod then return end
mod:RegisterEnableMob(184124) -- Sentinel Talondras
mod:SetEncounterID(2557)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local titanicEmpowermentActive = false
local lastTitanicEmpowermentCooldown = 30.4

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		372600, -- Inexorable
		372719, -- Titanic Empowerment
		372623, -- Resonating Orb
		372701, -- Crushing Stomp
		{372718, "ME_ONLY_EMPHASIZE"}, -- Earthen Shards
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_POWER_UPDATE", nil, "boss1")
	self:Log("SPELL_AURA_REMOVED_DOSE", "InexorableRemovedDose", 372600)
	self:Log("SPELL_AURA_REMOVED", "InexorableRemoved", 372600)
	self:Log("SPELL_CAST_START", "InexorableCast", 372600)
	self:Log("SPELL_AURA_APPLIED", "InexorableApplied", 372600)
	self:Log("SPELL_CAST_START", "TitanicEmpowerment", 372719)
	self:Log("SPELL_AURA_APPLIED", "TitanicEmpowermentApplied", 372719)
	self:Log("SPELL_CAST_START", "ResonatingOrb", 372623)
	self:Log("SPELL_AURA_APPLIED", "ResonatingOrbApplied", 382071)
	self:Log("SPELL_CAST_START", "CrushingStomp", 372701)
	self:Log("SPELL_CAST_SUCCESS", "EarthenShardsApplied", 372718)
end

function mod:OnEngage()
	titanicEmpowermentActive = false
	if self:Healer() then
		self:CDBar(372718, 4.5) -- Earthen Shards
	end
	self:CDBar(372701, 5.1) -- Crushing Stomp
	if self:Normal() then
		-- 30s energy gain + 5s cast + .4s delay
		lastTitanicEmpowermentCooldown = 35.4
		self:CDBar(372719, 35.4) -- Titanic Empowerment
	else -- Heroic, Mythic
		-- 25s energy gain + 5s cast + .4s delay
		lastTitanicEmpowermentCooldown = 30.4
		self:CDBar(372719, 30.4) -- Titanic Empowerment
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_POWER_UPDATE(_, unit)
	-- use UNIT_POWER_UPDATE instead of something like Resonating Orb applying to boss because
	-- you can actually stun the boss to reset her energy with player abilities as well.
	if not titanicEmpowermentActive and UnitPower(unit) == 0 then
		self:Message(372719, "green", CL.interrupted:format(self:SpellName(372719))) -- Titanic Empowerment Interrupted
		self:PlaySound(372719, "info")
		-- energy gain is paused for 3s out of the 5.5s while stunned
		if self:Normal() then
			-- 3s pause + 30s energy gain + 5s cast + .6 delay
			lastTitanicEmpowermentCooldown = 38.6
			self:CDBar(372719, 38.6) -- Titanic Empowerment
		else -- Heroic, Mythic
			-- 3s pause + 25s energy gain + 5s cast + .6 delay
			lastTitanicEmpowermentCooldown = 33.6
			self:CDBar(372719, 33.6) -- Titanic Empowerment
		end
		-- 5.5s stun, abilities can't happen while stunned
		if self:Healer() and self:BarTimeLeft(372718) < 5.5 then -- Earthen Shards
			self:CDBar(372718, {5.5, 9.7})
		end
		if self:BarTimeLeft(372701) < 5.5 then -- Crushing Stomp
			self:CDBar(372701, {5.5, 12.1})
		end
		if self:BarTimeLeft(372623) < 5.5 then -- Resonating Orb
			self:CDBar(372623, {5.5, 26.7})
		end
	end
end

function mod:InexorableRemovedDose(args)
	self:Message(args.spellId, "yellow", CL.stack:format(1, args.spellName, CL.boss))
	self:PlaySound(args.spellId, "info")
end

function mod:InexorableRemoved(args)
	if not titanicEmpowermentActive then
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:InexorableCast(args)
	if self:IsEngaged() then
		titanicEmpowermentActive = false
		-- after a stun, her energy gain starts when this is cast
		if self:Normal() then
			-- 30s energy gain + 5s cast + ~.6s delay
			self:CDBar(372719, {35.6, lastTitanicEmpowermentCooldown}) -- Titanic Empowerment
		else -- Heroic, Mythic
			-- 25s energy gain + 5s cast + ~.6s delay
			self:CDBar(372719, {30.6, lastTitanicEmpowermentCooldown}) -- Titanic Empowerment
		end
	end
end

function mod:InexorableApplied(args)
	if self:IsEngaged() then
		if titanicEmpowermentActive then
			titanicEmpowermentActive = false
			-- after Titanic Empowerment, her energy gain starts when this is applied (no cast)
			if self:Normal() then
				-- 30s energy gain + 5s cast + ~.6s delay
				lastTitanicEmpowermentCooldown = 35.6
				self:CDBar(372719, 35.6) -- Titanic Empowerment
			else -- Heroic, Mythic
				-- 25s energy gain + 5s cast + ~.6s delay
				lastTitanicEmpowermentCooldown = 30.6
				self:CDBar(372719, 30.6) -- Titanic Empowerment
			end
		end
		self:Message(args.spellId, "red", CL.stack:format(2, args.spellName, CL.boss))
		self:PlaySound(args.spellId, "long")
	end
end

function mod:TitanicEmpowerment(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	-- correct the bar
	self:Bar(args.spellId, {5, lastTitanicEmpowermentCooldown})
	-- 5s cast, abilities can't happen while casting
	if self:Healer() and self:BarTimeLeft(372718) < 5 then -- Earthen Shards
		self:CDBar(372718, {5, 9.7})
	end
	if self:BarTimeLeft(372701) < 5 then -- Crushing Stomp
		self:CDBar(372701, {5, 12.1})
	end
	if self:BarTimeLeft(372623) < 5 then -- Resonating Orb
		self:CDBar(372623, {5, 26.7})
	end
end

function mod:TitanicEmpowermentApplied(args)
	titanicEmpowermentActive = true
	self:Message(args.spellId, "red", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	if self:Normal() then
		self:Bar(args.spellId, 20, CL.onboss:format(args.spellName))
	else -- Heroic, Mythic
		self:Bar(args.spellId, 30, CL.onboss:format(args.spellName))
	end
end

do
	local playerList = {}

	function mod:ResonatingOrb(args)
		playerList = {}
		self:CDBar(args.spellId, 26.7)
	end

	function mod:ResonatingOrbApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(372623, "yellow", playerList, 2)
		self:PlaySound(372623, "alert", nil, playerList)
	end
end

function mod:CrushingStomp(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 12.1)
end

function mod:EarthenShardsApplied(args)
	if not self:Tank() and (self:Healer() or self:Me(args.destGUID)) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
	if self:Healer() then
		-- mostly noise, so scope the bar to just healers
		self:CDBar(args.spellId, 9.7)
	end
end
