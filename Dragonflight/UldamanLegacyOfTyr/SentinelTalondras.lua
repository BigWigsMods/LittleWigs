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

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.boss = "BOSS"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		372600, -- Inexorable
		372719, -- Titanic Empowerment
		372623, -- Resonating Orb
		372701, -- Crushing Stomp
		372718, -- Earthen Shards
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
	self:Log("SPELL_AURA_APPLIED", "ResonatingOrbFixate", 382071)
	self:Log("SPELL_CAST_START", "CrushingStomp", 372701)
	self:Log("SPELL_CAST_SUCCESS", "EarthenShardsApplied", 372718)
end

function mod:OnEngage()
	titanicEmpowermentActive = false
	self:Bar(372718, 4.5) -- Earthen Shards
	self:CDBar(372701, 5.1) -- Crushing Stomp
	-- 15s energy gain, 5s cast, .4s delay
	self:CDBar(372719, 20.4) -- Titanic Empowerment
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_POWER_UPDATE(_, unit)
	if not titanicEmpowermentActive and UnitPower(unit) == 0 then
		self:Message(372719, "green", CL.interrupted:format(self:SpellName(372719))) -- Titanic Empowerment Interrupted
		self:PlaySound(372719, "info")
		self:StopBar(372719) -- Titanic Empowerment
	end
end

function mod:InexorableRemovedDose(args)
	self:Message(args.spellId, "yellow", CL.stack:format(1, args.spellName, L.boss))
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
		-- 15s energy gain + 5s cast + ~.6s delay
		self:CDBar(372719, 20.6) -- Titanic Empowerment
	end
end

function mod:InexorableApplied(args)
	if self:IsEngaged() then
		if titanicEmpowermentActive then
			titanicEmpowermentActive = false
			-- after Titanic Empowerment, her energy gain starts when this is applied (no cast)
			-- 15s energy gain + 5s cast + ~.6s delay
			self:CDBar(372719, 20.6) -- Titanic Empowerment
		end
		self:Message(args.spellId, "red", CL.stack:format(2, args.spellName, L.boss))
		self:PlaySound(args.spellId, "long")
	end
end

function mod:TitanicEmpowerment(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	-- correct the bar
	self:Bar(args.spellId, {5, 20.6})
end

function mod:TitanicEmpowermentApplied(args)
	titanicEmpowermentActive = true
	self:Message(args.spellId, "red", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	if self:Mythic() then
		self:Bar(args.spellId, 40, CL.onboss:format(args.spellName))
	elseif self:Heroic() then
		self:Bar(args.spellId, 30, CL.onboss:format(args.spellName))
	else -- Normal
		self:Bar(args.spellId, 20, CL.onboss:format(args.spellName))
	end
end

do
	local playerList = {}

	function mod:ResonatingOrb(args)
		playerList = {}
		self:CDBar(args.spellId, 26.7)
	end

	function mod:ResonatingOrbFixate(args)
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
	self:CDBar(args.spellId, 9.7)
end
