if not BigWigsLoader.isTestBuild then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Demolition Duo", 2773, 2649)
if not mod then return end
mod:RegisterEnableMob(
	226403, -- Keeza Quickfuse
	226402 -- Bront
)
mod:SetEncounterID(3019)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local barrelingChargeCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		470090, -- Divided Duo
		-- Keeza Quickfuse
		460867, -- Big Bada Boom
		1217653, -- B.B.B.F.G.
		{473690, "SAY"}, -- Kinetic Explosive Gel (Mythic)
		-- Bront
		{459779, "SAY"}, -- Barreling Charge
		459799, -- Wallop
	}, {
		[460867] = -30321, -- Keeza Quickfuse
		[459779] = -30322, -- Bront
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "DividedDuoApplied", 470090)

	-- Keeza Quickfuse
	self:Log("SPELL_CAST_START", "BigBadaBoom", 460867)
	self:Log("SPELL_CAST_START", "BBBFG", 1217653)
	self:Log("SPELL_CAST_START", "KineticExplosiveGel", 473690)
	self:Log("SPELL_AURA_APPLIED", "KineticExplosiveGelApplied", 473713)
	self:Log("SPELL_AURA_APPLIED_DOSE", "KineticExplosiveGelApplied", 473713)
	self:Death("KeezaQuickfuseDeath", 226403)

	-- Bront
	self:Log("SPELL_CAST_START", "BarrelingCharge", 459779)
	self:Log("SPELL_AURA_APPLIED", "BarrelingChargeApplied", 470022)
	self:Log("SPELL_AURA_REFRESH", "BarrelingChargeApplied", 470022)
	self:Log("SPELL_CAST_START", "Wallop", 459799)
	self:Death("BrontDeath", 226402)
end

function mod:OnEngage()
	barrelingChargeCount = 1
	self:SetStage(1)
	self:CDBar(459799, 6.1) -- Wallop
	self:CDBar(1217653, 6.5) -- B.B.B.F.G.
	self:CDBar(460867, 13.9) -- Big Bada Boom
	if self:Mythic() then
		self:CDBar(473690, 17.7) -- Kinetic Explosive Gel
	end
	self:CDBar(459779, 22.8) -- Barreling Charge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DividedDuoApplied(args)
	self:Message(args.spellId, "cyan", CL.on:format(args.spellName, args.destName))
	self:PlaySound(args.spellId, "long")
end

-- Keeza Quickfuse

function mod:BigBadaBoom(args)
	self:Message(args.spellId, "yellow")
	if self:Mythic() then
		self:CDBar(args.spellId, 34.2)
	else
		self:CDBar(args.spellId, 35.4)
	end
	self:PlaySound(args.spellId, "long")
end

function mod:BBBFG(args)
	self:Message(args.spellId, "orange")
	if self:Mythic() then
		self:CDBar(args.spellId, 17.7)
	else
		self:CDBar(args.spellId, 17.1)
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:KeezaQuickfuseDeath()
	self:SetStage(2)
	self:StopBar(460867) -- Big Bada Boom
	self:StopBar(1217653) -- B.B.B.F.G.
	-- Bront does not cast Barreling Charge once Keeza Quickfuse is defeated
	self:StopBar(459779) -- Barreling Charge
	-- Wallop has no CD once Keeza Quickfuse is defeated
	self:StopBar(459799) -- Wallop
	if self:Mythic() then
		self:StopBar(473690) -- Kinetic Explosive Gel
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(473690, "orange", name, CL.casting:format(self:SpellName(473690)))
		if self:Me(guid) then
			self:Say(473690, nil, nil, "Kinetic Explosive Gel")
			self:PlaySound(473690, "alarm")
		end
	end

	function mod:KineticExplosiveGel(args)
		self:GetNextBossTarget(printTarget, args.sourceGUID)
		self:CDBar(args.spellId, 17.7)
	end
end

function mod:KineticExplosiveGelApplied(args)
	if self:Dispeller("magic") then
		self:TargetMessage(473690, "orange", args.destName)
		self:PlaySound(473690, "info", nil, args.destName)
	end
end

-- Bront

function mod:BarrelingCharge(args)
	barrelingChargeCount = barrelingChargeCount % 3 + 1
	if barrelingChargeCount == 2 then
		self:CDBar(args.spellId, 4.1)
		if self:GetStage() == 1 then
			self:CDBar(459799, 19.4) -- Wallop
		end
	elseif barrelingChargeCount == 3 then
		self:CDBar(args.spellId, 4.1)
	elseif self:GetStage() == 1 then
		self:CDBar(args.spellId, 22.7)
	else -- Stage 2
		self:StopBar(args.spellId)
	end
end

function mod:BarrelingChargeApplied(args)
	self:TargetMessage(459779, "red", args.destName, CL.count_amount:format(args.spellName, (barrelingChargeCount + 1) % 3 + 1, 3))
	if self:Me(args.destGUID) then
		self:Say(459779, nil, nil, "Barreling Charge")
	end
	self:PlaySound(459779, "alarm", nil, args.destName)
end

function mod:Wallop(args)
	self:Message(args.spellId, "purple")
	if self:GetStage() == 1 then
		self:CDBar(args.spellId, 17.0)
	else
		self:StopBar(args.spellId)
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:BrontDeath()
	self:SetStage(2)
	self:StopBar(459779) -- Barreling Charge
	self:StopBar(459799) -- Wallop
	-- Keeza Quickfuse does not cast Big Bada Boom once Bront is defeated
	self:StopBar(460867) -- Big Bada Boom
end
