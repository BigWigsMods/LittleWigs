
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("An Affront of Challengers", 2293, 2397)
if not mod then return end
mod:RegisterEnableMob(
	164451, -- Dessia the Decapitator
	164463, -- Paceran the Virulent
	164461, -- Sathel the Accursed
	164464  -- Xira the Underhanded
)
mod.engageId = 2391
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Dessia the Decapitator
		320063, -- Slam
		320069, -- Mortal Strike
		326892, -- Fixate
		324085, -- Enrage
		-- Paceran the Virulent
		320248, -- Genetic Alteration
		-- Sathel the Accursed
		{333231, "SAY", "FLASH"}, -- Searing Death
		320293, -- One with Death
		320272, -- Spectral Transference
		-- Xira the Underhanded
		333540, -- Opportunity Strikes
	}, {
		[320063] = -21582, -- Dessia the Decapitator
		[320182] = -21581, -- Paceran the Virulent
		[333231] = -21591, -- Sathel the Accursed
		[333540] = -22272, -- Xira the Underhanded
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Slam", 320063)
	self:Log("SPELL_CAST_START", "MortalStrike", 320069)
	self:Log("SPELL_AURA_APPLIED", "EnrageApplied", 324085)
	self:Log("SPELL_CAST_SUCCESS", "GeneticAlteration", 320248)
	self:Log("SPELL_CAST_START", "SearingDeath", 333231)
	self:Log("SPELL_AURA_APPLIED", "SearingDeathApplied", 333231)
	self:Log("SPELL_CAST_SUCCESS", "OneWithDeath", 320293)
	self:Log("SPELL_AURA_APPLIED", "SpectralTransference", 320272)
	self:Log("SPELL_AURA_APPLIED", "AmbushApplied", 333540)
end

function mod:OnEngage()
	self:Bar(320063, 8.5) -- SLam
	self:Bar(320069, 21) -- Mortal Strike
	self:Bar(333231, 9.7) -- Searing Death
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Slam(args)
	self:Message2(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 8.5) -- Will be delayed if nobody is in melee range
end

function mod:MortalStrike(args)
	self:Message2(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(21)
end

function mod:Enrage(args)
	self:Message2(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
	self:PlaySound(args.spellId, "long")
end

function mod:GeneticAlteration(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:SearingDeath(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 12.2)
end

function mod:SearingDeathApplied(args)
	local isOnMe = self:Me(args.destGUID)
	self:TargetMessage2(args.spellId, isOnMe and "red" or "yellow", args.destName)
	self:PlaySound(args.spellId, isOnMe and "alarm" or "info", nil, args.destName)
	if isOnMe then
		self:Say(args.spellId)
		self:Flash(args.spellId)
	end
end

function mod:OneWithDeath(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
end

function mod:SpectralTransferenceApplied(args)
	if self:Dispeller("magic", true, args.spellId) then
		self:Message2(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:AmbushApplied(args)
	self:TargetMessage2(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end
