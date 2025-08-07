--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("High Adjudicator Aleez", 2287, 2411)
if not mod then return end
mod:RegisterEnableMob(165410) -- High Adjudicator Aleez
mod:SetEncounterID(2403)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- High Adjudicator Aleez
		{323538, "OFF"}, -- Anima Bolt
		329340, -- Anima Fountain
		323597, -- Spectral Procession
		1236512, -- Unstable Anima
		-- Ghastly Parishioner
		323650, -- Haunting Fixation
	}, {
		[323538] = self.displayName, -- High Adjudicator Aleez
		[323650] = -21861, -- Ghastly Parishioner
	}, {
		[323597] = CL.add_spawning, -- Spectral Procession (Add spawning)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AnimaBolt", 323538)
	self:Log("SPELL_CAST_SUCCESS", "UnstableAnima", 1236512)
	self:Log("SPELL_AURA_APPLIED", "UnstableAnimaApplied", 1236513)
	self:Log("SPELL_SUMMON", "SpectralProcession", 323597)
	self:Log("SPELL_AURA_APPLIED", "HauntingFixation", 323650)
	self:Log("SPELL_AURA_REMOVED", "HauntingFixationRemoved", 323650)
	self:Log("SPELL_CAST_START", "AnimaFountain", 329340)
end

function mod:OnEngage()
	self:CDBar(323538, 5.0) -- Anima Bolt
	if self:Mythic() then
		self:CDBar(1236512, 10.1) -- Unstable Anima
	end
	self:CDBar(323650, 17.2, CL.add_spawning) -- Spectral Procession
	self:CDBar(329340, 19.1) -- Anima Fountain
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AnimaBolt(args)
	local _, ready = self:Interrupter()
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 8.5)
	if ready then
		self:PlaySound(args.spellId, "alert")
	end
end

do
	local playerList = {}

	function mod:UnstableAnima(args)
		playerList = {}
		self:CDBar(args.spellId, 15.7)
	end

	function mod:UnstableAnimaApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(1236512, "orange", playerList, 2)
		self:PlaySound(1236512, "alarm", nil, playerList)
	end
end

function mod:SpectralProcession(args)
	self:Message(args.spellId, "cyan", CL.add_spawned)
	self:CDBar(args.spellId, 20.7, CL.add_spawning)
	self:PlaySound(args.spellId, "long")
end

function mod:HauntingFixation(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	else
		self:PlaySound(args.spellId, "info")
	end
end

function mod:HauntingFixationRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:AnimaFountain(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 23.2)
	self:PlaySound(args.spellId, "alarm")
end
