--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("An Affront of Challengers", 2293, 2397)
if not mod then return end
mod:RegisterEnableMob(
	164451, -- Dessia the Decapitator
	164463, -- Paceran the Virulent
	164461 -- Sathel the Accursed
)
mod:SetEncounterID(2391)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local decayingBreathCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Dessia the Decapitator
		1215741, -- Mighty Smash
		{320069, "TANK_HEALER"}, -- Mortal Strike
		-- Paceran the Virulent
		320182, -- Noxious Spores
		1215738, -- Decaying Breath
		-- Sathel the Accursed
		333231, -- Searing Death
		{1215600, "DISPEL"}, -- Withering Touch
	}, {
		[1215741] = -21582, -- Dessia the Decapitator
		[320182] = -21581, -- Paceran the Virulent
		[333231] = -21591, -- Sathel the Accursed
	}
end

function mod:OnBossEnable()
	-- Dessia the Decapitator
	self:Log("SPELL_CAST_START", "MortalStrike", 320069)
	self:Log("SPELL_CAST_START", "MightySmash", 1215741)
	self:Death("DessiaDeath", 164451)

	-- Sathel the Accursed
	self:Log("SPELL_CAST_START", "SearingDeath", 333231)
	self:Log("SPELL_AURA_APPLIED", "SearingDeathApplied", 333231)
	self:Log("SPELL_CAST_START", "WitheringTouch", 1215600)
	self:Log("SPELL_AURA_APPLIED", "WitheringTouchApplied", 1215600)
	self:Death("SathelDeath", 164461)

	-- Paceran the Virulent
	self:Log("SPELL_CAST_START", "DecayingBreath", 1215738)
	self:Log("SPELL_CAST_START", "NoxiousSpores", 320182)
	self:Death("PaceranDeath", 164463)
end

function mod:OnEngage()
	decayingBreathCount = 1
	self:SetStage(1)
	self:CDBar(320069, 3.2) -- Mortal Strike
	self:CDBar(1215600, 5.7) -- Withering Touch
	self:CDBar(1215738, 5.7) -- Decaying Breath
	self:CDBar(1215741, 10.5) -- Mighty Smash
	self:CDBar(320182, 20.3) -- Noxious Spores
	self:CDBar(333231, 30.2) -- Searing Death
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Dessia the Decapitator

function mod:MightySmash(args)
	self:Message(args.spellId, "red")
	if self:Mythic() then
		if self:GetStage() == 1 then
			self:CDBar(args.spellId, 43.7)
		elseif self:GetStage() == 2 then
			self:CDBar(args.spellId, 30.3)
		else -- Stage 3
			self:CDBar(args.spellId, 15.8)
		end
	else -- Heroic, Normal
		self:CDBar(args.spellId, 43.7)
	end
	self:PlaySound(args.spellId, "info")
end

function mod:MortalStrike(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 17.0)
	self:PlaySound(args.spellId, "alert")
end

function mod:DessiaDeath()
	if self:GetStage() < 3 then
		self:SetStage(self:GetStage() + 1)
	end
	self:StopBar(1215741) -- Mighty Smash
	self:StopBar(320069) -- Mortal Strike
end

-- Paceran the Virulent

function mod:DecayingBreath(args)
	self:Message(args.spellId, "orange")
	decayingBreathCount = decayingBreathCount + 1
	if self:Mythic() and self:GetStage() >= 1 then
		self:CDBar(args.spellId, 29.1)
		-- TODO 29.1 in stage 2, but what about stage 3?
		-- should we instead adjust the timer in :NoxiousSpores? always 14.6 after
	else -- Heroic, Normal, Mythic Stage 1
		if decayingBreathCount % 2 == 0 then
			self:CDBar(args.spellId, 29.1)
		else
			self:CDBar(args.spellId, 14.6)
		end
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:NoxiousSpores(args)
	self:Message(args.spellId, "yellow")
	if self:Mythic() then
		if self:GetStage() == 1 then
			self:CDBar(args.spellId, 42.5)
		elseif self:GetStage() == 2 then
			self:CDBar(args.spellId, 29.1)
		else -- Stage 3
			self:CDBar(args.spellId, 14.5)
		end
	else -- Heroic, Normal
		self:CDBar(args.spellId, 42.5)
	end
	self:PlaySound(args.spellId, "long")
end

function mod:PaceranDeath()
	if self:GetStage() < 3 then
		self:SetStage(self:GetStage() + 1)
	end
	self:StopBar(1215738) -- Decaying Breath
	self:StopBar(320182) -- Noxious Spores
end

-- Sathel the Accursed

do
	local playerList = {}

	function mod:SearingDeath(args)
		playerList = {}
		if self:Mythic() then
			if self:GetStage() == 1 then
				self:CDBar(args.spellId, 42.5)
			elseif self:GetStage() == 2 then
				self:CDBar(args.spellId, 29.2)
			else -- Stage 3
				self:CDBar(args.spellId, 14.5)
			end
		else -- Heroic, Normal
			self:CDBar(args.spellId, 42.5)
		end
	end

	function mod:SearingDeathApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "yellow", playerList, 4)
		self:PlaySound(args.spellId, "info", nil, playerList)
	end
end

do
	local playerList = {}

	function mod:WitheringTouch(args)
		playerList = {}
		self:CDBar(args.spellId, 18.2)
		if self:Dispeller("magic", nil, args.spellId) then
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alert")
		end
	end

	function mod:WitheringTouchApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(args.spellId, "red", playerList, 2)
			self:PlaySound(args.spellId, "info", nil, playerList)
		end
	end
end

function mod:SathelDeath()
	if self:GetStage() < 3 then
		self:SetStage(self:GetStage() + 1)
	end
	self:StopBar(333231) -- Searing Death
	self:StopBar(1215600) -- Withering Touch
end
