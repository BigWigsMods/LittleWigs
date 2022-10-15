if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sentinel Talondras", 2451, 2484)
if not mod then return end
mod:RegisterEnableMob(184124) -- Sentinel Talondras
mod:SetEncounterID(2557)
mod:SetRespawnTime(30)

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
	self:Log("SPELL_AURA_REMOVED_DOSE", "InexorableRemovedDose", 372600)
	self:Log("SPELL_AURA_REMOVED", "InexorableRemoved", 372600)
	self:Log("SPELL_AURA_APPLIED", "InexorableApplied", 372600)
	self:Log("SPELL_CAST_START", "TitanicEmpowerment", 372719)
	self:Log("SPELL_AURA_APPLIED", "TitanicEmpowermentApplied", 372719)
	self:Log("SPELL_CAST_START", "ResonatingOrb", 372623)
	self:Log("SPELL_AURA_APPLIED", "ResonatingOrbFixate", 382071)
	self:Log("SPELL_AURA_APPLIED", "ResonatingOrbApplied", 372652)
	self:Log("SPELL_CAST_START", "CrushingStomp", 372701)
	self:Log("SPELL_CAST_SUCCESS", "EarthenShardsApplied", 372718)
end

function mod:OnEngage()
	self:Bar(372718, 4.6) -- Earthen Shards
	self:CDBar(372701, 8.1) -- Crushing Stomp
	self:Bar(372719, 30.1) -- Titanic Empowerment
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InexorableRemovedDose(args)
	self:Message(args.spellId, "yellow", CL.stack:format(1, args.spellName, args.destName))
	self:PlaySound(args.spellId, "info")
end

function mod:InexorableRemoved(args)
	self:Message(args.spellId, "green", CL.removed:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:InexorableApplied(args)
	self:Message(args.spellId, "red", CL.stack:format(2, args.spellName, args.destName))
	self:PlaySound(args.spellId, "long")
end

function mod:TitanicEmpowerment(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:TitanicEmpowermentApplied(args)
	self:Message(args.spellId, "red", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	
	local duration
	if self:Mythic() then
		duration = 40
	elseif self:Heroic() then
		duration = 30
	else -- Normal
		duration = 20
	end

	self:Bar(args.spellId, duration, CL.onboss:format(args.spellName))
end

do
	local playerList = {}

	function mod:ResonatingOrb(args)
		playerList = {}
	end

	function mod:ResonatingOrbFixate(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(372623, "yellow", playerList, 2)
		self:PlaySound(372623, "alert", nil, playerList)
	end
end

function mod:ResonatingOrbApplied(args)
	if self:MobId(args.destGUID) == 184124 then -- Sentinel Talondras
		self:Message(372623, "green", CL.onboss:format(args.spellName))
		self:PlaySound(372623, "info")

		-- energy resets when Resonating Orb is applied to boss
		-- 3s stun + 25s energy gain + 5s cast
		self:Bar(372719, 33) -- Titanic Empowerment
	end
end

function mod:CrushingStomp(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 12.1)
end

function mod:EarthenShardsApplied(args)
	if self:Healer() or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
	self:CDBar(args.spellId, 9.7)
end
