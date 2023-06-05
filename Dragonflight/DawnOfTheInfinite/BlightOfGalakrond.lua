if select(4, GetBuildInfo()) < 100105 then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Blight of Galakrond", 2579, 2535)
if not mod then return end
mod:RegisterEnableMob(
	198997, -- Blight of Galakrond
	201792, -- Ahnzon
	201790, -- Loszkeleth
	201788  -- Dazhak
)
mod:SetEncounterID(2668)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"stages",
		-- Blight of Galakrond
		406886, -- Corrosive Infusion
		{407406, "SAY"}, -- Corrosion
		407159, -- Blight Reclamation
		407147, -- Blight Seep
		-- Ahnzon
		407978, -- Necrotic Winds
		-- Loszkeleth
		408029, -- Necrofrost
		-- Dazhak
		408141, -- Incinerating Blightbreath
	}, {
		["stages"] = CL.general,
		[406886] = -26547, -- Blight of Galakrond
		[407978] = -26556, -- Ahnzon
		[408029] = -26557, -- Loszkeleth
		[408141] = -26558, -- Dazhak
	}
end

function mod:OnBossEnable()
	-- Stages
	self:Log("SPELL_AURA_APPLIED", "MalignantTransferal", 415097, 415114) -- Stage 2, Stage 3

	-- Blight of Galakrond
	self:Log("SPELL_CAST_START", "CorrosiveInfusion", 406886)
	self:Log("SPELL_AURA_APPLIED", "CorrosionApplied", 407406)
	self:Log("SPELL_CAST_START", "BlightReclamation", 407159)
	self:Log("SPELL_AURA_APPLIED", "BlightSeepDamage", 407147)

	-- Ahnzon
	self:Log("SPELL_CAST_SUCCESS", "NecroticWinds", 407978)

	-- Loszkeleth
	self:Log("SPELL_CAST_START", "Necrofrost", 408029)

	-- Dazhak
	self:Log("SPELL_CAST_START", "IncineratingBlightbreath", 408141)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(406886, 4.9) -- Corrosive Infusion
	self:CDBar(407159, 14.6) -- Blight Reclamation
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:MalignantTransferal(args)
	if args.spellId == 415097 then -- Stage 2
		self:SetStage(2)
		self:Message("stages", "cyan", CL.percent:format(75, CL.stage:format(2)), args.spellId)
		self:PlaySound("stages", "long")
		-- TODO boss moves to a specific location before transforming, is it better to
		-- use StopBar here and trigger these timers off something else?
		self:CDBar(407159, 9.7) -- Blight Reclamation
		self:CDBar(406886, 18.1) -- Corrosive Infusion
		self:CDBar(407978, 27.8) -- Necrotic Winds
	else -- 415114, Stage 3
		self:SetStage(3)
		self:Message("stages", "cyan", CL.percent:format(40, CL.stage:format(3)), args.spellId)
		self:PlaySound("stages", "long")
		self:StopBar(407978) -- Necrotic Winds
		self:CDBar(407159, 12.4) -- Blight Reclamation
		self:CDBar(408141, 17.2) -- Incinerating Blightbreath
		self:CDBar(406886, 24.2) -- Corrosive Infusion
		self:CDBar(408029, 41.2) -- Necrofrost
	end
end

-- Blight of Galakrond

function mod:CorrosiveInfusion(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	if self:GetStage() == 1 then
		self:CDBar(args.spellId, 15.7)
	elseif self:GetStage() == 2 then
		self:CDBar(args.spellId, 31.6)
	else -- Stage 3
		self:CDBar(args.spellId, 32.8)
	end
end

function mod:CorrosionApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

function mod:BlightReclamation(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	if self:GetStage() == 1 then
		self:CDBar(args.spellId, 15.7)
	elseif self:GetStage() == 2 then
		self:CDBar(args.spellId, 31.6)
	else -- Stage 3
		self:CDBar(args.spellId, 32.7)
	end
end

function mod:BlightSeepDamage(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId, "underyou")
		self:PlaySound(args.spellId, "underyou")
	end
end

-- Ahnzon

function mod:NecroticWinds(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 31.6)
end

-- Loszkeleth

function mod:Necrofrost(args)
	-- TODO get target, get debuff id, and show an alert for target switch / movement dispel
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 32.7)
end

-- Dazhak

function mod:IncineratingBlightbreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	-- TODO pattern? pull:227.2, 18.2, 14.7, 16.9, 15.5, 18.5, 14.4
	self:CDBar(args.spellId, 14.4)
end
