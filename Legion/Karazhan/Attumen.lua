--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Attumen the Huntsman", 1651, 1835)
if not mod then return end
mod:RegisterEnableMob(114262, 114264) -- Attumen, Midnight
mod:SetEncounterID(1960)
mod:SetRespawnTime(15)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local inIntermission = false
local intermissionOver = false

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		228895, -- Enrage
		227363, -- Mighty Stomp
		227365, -- Spectral Charge
		227493, -- Mortal Strike
		228852, -- Shared Suffering
	}, {
		[227363] = -14300, -- Horse and Rider as One
		[227493] = -14304, -- Fighting on Foot
	}
end

function mod:OnBossEnable()
	-- Stages
	self:Log("SPELL_AURA_APPLIED", "DismountedApplied", 227474)
	self:Log("SPELL_AURA_REMOVED", "DismountedRemoved", 227474)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2")
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")

	-- Attumen
	self:Log("SPELL_CAST_START", "MortalStrike", 227493)
	self:Log("SPELL_AURA_APPLIED", "MortalStrikeApplied", 227493)
	self:Log("SPELL_AURA_REMOVED", "MortalStrikeRemoved", 227493)
	self:Log("SPELL_CAST_START", "SharedSuffering", 228852)
	self:Log("SPELL_CAST_SUCCESS", "SharedSufferingSuccess", 228852)

	-- Midnight
	self:Log("SPELL_CAST_SUCCESS", "SpectralCharge", 227365)
	self:Log("SPELL_AURA_APPLIED", "Enrage", 228895)
	self:Log("SPELL_CAST_START", "MightyStomp", 227363)
end

function mod:OnEngage()
	self:CDBar(227363, 15.4) -- Mighty Stomp
	self:SetStage(1)
	inIntermission = false
	intermissionOver = false
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:DismountedApplied(args)
	self:SetStage(2)
	self:Message("stages", "cyan", args.spellName, 164558) -- Dismounted
	self:PlaySound("stages", "long")
	self:CDBar(227493, 8.5) -- Mortal Strike
	self:CDBar(228852, 15.8) -- Shared Suffering
	self:StopBar(227363) -- Mighty Stomp
	self:StopBar(227365) -- Spectral Charge
	-- Midnight is unattackable and recovers 2% HP per second, phase ends when Midnight reaches 100% HP
	self:Bar("stages", ceil((100 - self:GetHealth("boss2")) / 2), args.spellName, 164558) -- Dismounted
end

function mod:DismountedRemoved(args)
	if self:GetStage() == 3 then
		-- don't alert here if Dismounted is removed after Attumen's defeat
		return
	end
	self:SetStage(1)
	self:Message("stages", "cyan", 227584, 244457) -- Mounted
	self:PlaySound("stages", "long")
	self:StopBar(228852) -- Shared Suffering
	self:StopBar(227493) -- Mortal Strike
	if intermissionOver then
		self:Bar(227365, 12.3) -- Spectral Charge
		self:CDBar(227363, 17.2) -- Mighty Stomp
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 227601 then -- Intermission, starts Spectral Charges
		inIntermission = true
		self:Message("stages", "cyan", CL.intermission, 227365) -- Spectral Charge icon
		self:CDBar("stages", 13.3, CL.intermission, 227365) -- Spectral Charge icon
	elseif spellId == 227603 then -- Intermission End
		intermissionOver = true
		-- if you push Attumen really fast in the first phase he will never enter an Intermission
		-- but the Intermission End spell will still be cast
		if inIntermission then
			inIntermission = false
			self:StopBar(CL.intermission)
			self:Message("stages", "cyan", CL.over:format(CL.intermission), 227365) -- Intermission Over, Spectral Charge icon
			self:PlaySound("stages", "info")
			self:Bar(227365, 12.3) -- Spectral Charge
			self:CDBar(227363, 17.2) -- Mighty Stomp
		end
	end
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) == 114262 then -- Attumen
		if self:GetHealth(unit) < 20 then
			-- no longer remounts below 20%
			self:StopBar(227474) -- Dismounted
			self:UnregisterUnitEvent(event, unit)
		end
	end
end

-- Attumen

function mod:MortalStrike(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 9.7)
end

function mod:MortalStrikeApplied(args)
	if self:Tank(args.destName) then
		self:TargetBar(args.spellId, 10, args.destName)
	end
end

function mod:MortalStrikeRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

function mod:SharedSuffering(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
end

function mod:SharedSufferingSuccess(args)
	self:Bar(args.spellId, 18) -- 21.8s - 3.8s cast time to next start
end

-- Midnight

function mod:SpectralCharge(args)
	-- Spectral Charge is spammed during Intermission, don't alert for those
	if not inIntermission then
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
		self:Bar(args.spellId, 21.8)
	end
end

function mod:Enrage(args)
	self:SetStage(3)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

function mod:MightyStomp(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	if self:GetStage() == 3 then
		self:CDBar(args.spellId, 10.9) -- shorter CD in stage 3
	else
		self:CDBar(args.spellId, 18.2)
	end
end
