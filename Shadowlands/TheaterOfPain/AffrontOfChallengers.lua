local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
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
-- Initialization
--

if isElevenDotOne then -- XXX remove this check when 11.1 is live
	function mod:GetOptions()
		return {
			-- Dessia the Decapitator
			1215741, -- Mighty Smash
			{320069, "TANK_HEALER"}, -- Mortal Strike
			{320063, "TANK"}, -- Slam XXX not cast anymore but still in journal
			-- Paceran the Virulent
			320182, -- Noxious Spores
			1215738, -- Decaying Breath
			-- Sathel the Accursed
			333231, -- Searing Death
			1215600, -- Withering Touch
		}, {
			[1215741] = -21582, -- Dessia the Decapitator
			[320182] = -21581, -- Paceran the Virulent
			[333231] = -21591, -- Sathel the Accursed
		}
	end
else -- XXX remove this block when 11.1 is live
	function mod:GetOptions()
		return {
			-- Dessia the Decapitator
			{320063, "TANK"}, -- Slam
			{320069, "TANK_HEALER"}, -- Mortal Strike
			324085, -- Enrage
			326892, -- Fixate
			-- Paceran the Virulent
			320248, -- Genetic Alteration
			-- Sathel the Accursed
			{333231, "SAY"}, -- Searing Death
			320293, -- One with Death
			320272, -- Spectral Transference
			-- Xira the Underhanded (Mythic)
			333540, -- Opportunity Strikes
		}, {
			[320063] = -21582, -- Dessia the Decapitator
			[320248] = -21581, -- Paceran the Virulent
			[333231] = -21591, -- Sathel the Accursed
			[333540] = CL.extra:format(self:SpellName(-23841), CL.mythic), -- Xira the Underhanded
		}
	end
end

function mod:OnBossEnable()
	-- Dessia the Decapitator
	self:Log("SPELL_CAST_START", "MortalStrike", 320069)
	self:Log("SPELL_CAST_START", "Slam", 320063) -- XXX not cast anymore in 11.1 but still in journal

	-- Sathel the Accursed
	self:Log("SPELL_CAST_START", "SearingDeath", 333231)
	self:Log("SPELL_AURA_APPLIED", "SearingDeathApplied", 333231)

	if isElevenDotOne then -- XXX remove this check when 11.1 is live
		-- Dessia the Decapitator
		self:Log("SPELL_CAST_START", "MightySmash", 1215741)
		self:Death("DessiaDeath", 164451)

		-- Paceran the Virulent
		self:Log("SPELL_CAST_START", "DecayingBreath", 1215738)
		self:Log("SPELL_CAST_START", "NoxiousSpores", 320182)
		self:Death("PaceranDeath", 164463)

		-- Sathel the Accursed
		self:Log("SPELL_CAST_START", "WitheringTouch", 1215600)
		self:Death("SathelDeath", 164461)
	else -- XXX remove this block when 11.1 is live
		-- Dessia the Decapitator
		self:Log("SPELL_AURA_APPLIED", "EnrageApplied", 324085)
		self:Log("SPELL_AURA_APPLIED", "FixateApplied", 326892)
		-- Paceran the Virulent
		self:Log("SPELL_CAST_SUCCESS", "GeneticAlteration", 320248)
		-- Sathel the Accursed
		self:Log("SPELL_CAST_SUCCESS", "OneWithDeath", 320293)
		self:Log("SPELL_AURA_APPLIED", "SpectralTransferenceApplied", 320272)
		-- Xira the Underhanded
		self:Log("SPELL_AURA_APPLIED", "OpportunityStrikesApplied", 333540)
	end
end

function mod:OnEngage()
	self:SetStage(1)
	if not isElevenDotOne then -- XXX remove this block when 11.1 is live
		self:Bar(320063, 8.5) -- Slam
		self:Bar(333231, 9.7) -- Searing Death
		self:Bar(320069, 21) -- Mortal Strike
	else
		self:CDBar(320069, 3.5) -- Mortal Strike
		self:CDBar(1215600, 5.7) -- Withering Touch
		self:CDBar(1215738, 6.9) -- Decaying Breath
		self:CDBar(1215741, 10.5) -- Mighty Smash
		self:CDBar(320182, 20.3) -- Noxious Spores
		self:CDBar(333231, 30.2) -- Searing Death
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Dessia the Decapitator

function mod:MightySmash(args)
	self:Message(args.spellId, "red")
	if self:Mythic() then
		if self:GetStage() == 1 then
			self:CDBar(args.spellId, 42.5)
		elseif self:GetStage() == 2 then
			self:CDBar(args.spellId, 29.2)
		else -- Stage 3
			self:CDBar(args.spellId, 14.5)
		end
	else -- Heroic
		self:CDBar(args.spellId, 42.5)
	end
	self:PlaySound(args.spellId, "info")
end

function mod:MortalStrike(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 21.9)
	self:PlaySound(args.spellId, "alert")
end

function mod:Slam(args) -- XXX not cast anymore in 11.1 but still in journal
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 13.4)
	self:PlaySound(args.spellId, "alert")
end

function mod:DessiaDeath()
	self:SetStage(self:GetStage() + 1)
	self:StopBar(1215741) -- Mighty Smash
	self:StopBar(320069) -- Mortal Strike
	self:StopBar(320063) -- Slam XXX not cast anymore in 11.1 but still in journal
end

if not isElevenDotOne then -- XXX remove this block when 11.1 is live
	function mod:EnrageApplied(args)
		self:Message(args.spellId, "yellow", CL.percent:format(40, args.spellName))
		self:PlaySound(args.spellId, "long")
	end

	function mod:FixateApplied(args)
		if args.sourceGUID ~= args.destGUID then -- Boss buffs itself as well as the target
			self:TargetMessage(args.spellId, "red", args.destName)
			self:TargetBar(args.spellId, 10, args.destName)
			if self:Me(args.destGUID) then
				self:PlaySound(args.spellId, "warning")
			end
		end
	end

	function mod:FixateRemoved(args)
		if args.sourceGUID ~= args.destGUID then
			self:StopBar(args.spellId, args.destName)
		end
	end
end

-- Paceran the Virulent

if not isElevenDotOne then -- XXX remove this block when 11.1 is live
	function mod:GeneticAlteration(args)
		self:Message(args.spellId, "orange", CL.percent:format(40, args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:DecayingBreath(args)
	self:Message(args.spellId, "orange")
	self:StopBar(args.spellId) -- TODO only cast once (at least in heroic)
	self:PlaySound(args.spellId, "alarm")
end

function mod:NoxiousSpores(args)
	self:Message(args.spellId, "yellow")
	if self:Mythic() then
		if self:GetStage() == 1 then
			self:CDBar(args.spellId, 42.5)
		elseif self:GetStage() == 2 then
			self:CDBar(args.spellId, 29.2)
		else -- Stage 3
			self:CDBar(args.spellId, 14.5)
		end
	else -- Heroic
		self:CDBar(args.spellId, 42.5)
	end
	self:PlaySound(args.spellId, "long")
end

function mod:PaceranDeath()
	self:SetStage(self:GetStage() + 1)
	self:StopBar(1215738) -- Decaying Breath
	self:StopBar(320182) -- Noxious Spores
end

-- Sathel the Accursed

do
	local playerList = {}

	function mod:SearingDeath(args)
		if isElevenDotOne then
			playerList = {}
			if self:Mythic() then
				if self:GetStage() == 1 then
					self:CDBar(args.spellId, 42.5)
				elseif self:GetStage() == 2 then
					self:CDBar(args.spellId, 29.2)
				else -- Stage 3
					self:CDBar(args.spellId, 14.5)
				end
			else -- Heroic
				self:CDBar(args.spellId, 42.5)
			end
		else -- XXX remove in 11.1
			self:CDBar(args.spellId, 12.8)
		end
	end

	function mod:SearingDeathApplied(args)
		if isElevenDotOne then
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(args.spellId, "yellow", playerList, 4) -- everyone except healer
			self:PlaySound(args.spellId, "info", nil, playerList)
		else -- XXX remove in 11.1
			self:TargetMessage(args.spellId, "yellow", args.destName)
			if self:Me(args.destGUID) then
				self:Say(args.spellId, nil, nil, "Searing Death")
			end
			self:PlaySound(args.spellId, "info", nil, args.destName)
		end
	end
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) or self:Healer() then
			self:TargetMessage(1215600, "orange", name, CL.casting:format(self:SpellName(1215600)))
			self:PlaySound(1215600, "alert", nil, name)
		end
	end

	function mod:WitheringTouch(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		self:CDBar(args.spellId, 17.0)
	end
end

function mod:SathelDeath()
	self:SetStage(self:GetStage() + 1)
	self:StopBar(333231) -- Searing Death
	self:StopBar(1215600) -- Withering Touch
end

if not isElevenDotOne then -- XXX remove this block when 11.1 is live
	function mod:OneWithDeath(args)
		self:Message(args.spellId, "yellow", CL.percent:format(40, args.spellName))
		self:PlaySound(args.spellId, "long")
	end

	function mod:SpectralTransferenceApplied(args)
		if self:Dispeller("magic", true, args.spellId) then
			self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
			self:PlaySound(args.spellId, "info")
		end
	end

	-- Xira the Underhanded

	function mod:OpportunityStrikesApplied(args)
		self:TargetMessage(args.spellId, "red", args.destName)
		if self:Me(args.destGUID) then
			self:PlaySound(args.spellId, "alarm")
		else
			self:PlaySound(args.spellId, "warning", nil, args.destName)
		end
	end
end
