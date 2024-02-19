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
-- Locals
--

local corrosiveInfusionCount = 1
local incineratingBlightbreathCount = 1
local necrofrostCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

local necrofrostMarker = mod:AddMarkerOption(true, "npc", 8, 408029, 8) -- Necrofrost
function mod:GetOptions()
	return {
		-- General
		"stages",
		-- Blight of Galakrond
		406886, -- Corrosive Infusion
		{407406, "ICON", "SAY", "SAY_COUNTDOWN"}, -- Corrosion
		418346, -- Corrupted Mind
		407159, -- Blight Reclamation
		407147, -- Blight Seep
		-- Ahnzon
		407978, -- Necrotic Winds
		-- Loszkeleth
		{408029, "SAY", "DISPEL"}, -- Necrofrost
		necrofrostMarker,
		-- Dazhak
		{408141, "SAY"}, -- Incinerating Blightbreath
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
	self:Log("SPELL_AURA_REMOVED", "MalignantTransferalOver", 415097, 415114) -- Stage 2, Stage 3

	-- Blight of Galakrond
	self:Log("SPELL_CAST_START", "CorrosiveInfusion", 406886)
	self:Log("SPELL_AURA_APPLIED", "CorrosionApplied", 407406)
	self:Log("SPELL_AURA_REMOVED", "CorrosionRemoved", 407406)
	self:Log("SPELL_AURA_APPLIED", "CorruptedMindApplied", 418346)
	self:Log("SPELL_CAST_START", "BlightReclamation", 407159)
	self:Log("SPELL_PERIODIC_DAMAGE", "BlightSeepDamage", 407147)
	self:Log("SPELL_PERIODIC_MISSED", "BlightSeepDamage", 407147)

	-- Ahnzon
	self:Log("SPELL_CAST_SUCCESS", "NecroticWinds", 407978)

	-- Loszkeleth
	self:Log("SPELL_CAST_START", "Necrofrost", 408029)
	self:Log("SPELL_AURA_APPLIED", "NecrofrostApplied", 408084)

	-- Dazhak
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss2") -- Incinerating Blightbreath
end

function mod:OnEngage()
	corrosiveInfusionCount = 1
	incineratingBlightbreathCount = 1
	necrofrostCount = 1
	self:SetStage(1)
	self:CDBar(406886, 4.8) -- Corrosive Infusion
	self:CDBar(407159, 14.6) -- Blight Reclamation
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:MalignantTransferal(args)
	if args.spellId == 415097 then -- Stage 2
		self:SetStage(2)
		self:Message("stages", "cyan", CL.percent:format(80, CL.stage:format(2)), args.spellId)
		self:PlaySound("stages", "long")
		self:StopBar(406886) -- Corrosive Infusion
		self:StopBar(407159) -- Blight Reclamation
	else -- 415114, Stage 3
		corrosiveInfusionCount = 1
		self:SetStage(3)
		self:Message("stages", "cyan", CL.percent:format(50, CL.stage:format(3)), args.spellId)
		self:PlaySound("stages", "long")
		self:StopBar(406886) -- Corrosive Infusion
		self:StopBar(407159) -- Blight Reclamation
		self:StopBar(407978) -- Necrotic Winds
	end
end

function mod:MalignantTransferalOver(args)
	if args.spellId == 415097 then -- Stage 2
		self:CDBar(407159, 30.4) -- Blight Reclamation
		self:CDBar(406886, 6.9) -- Corrosive Infusion
		self:CDBar(407978, 16.8) -- Necrotic Winds
	else -- 415114, Stage 3
		self:CDBar(407159, 63.8) -- Blight Reclamation
		self:CDBar(406886, 15.0) -- Corrosive Infusion
		self:CDBar(408141, 22.4) -- Incinerating Blightbreath
		self:CDBar(408029, 31.2) -- Necrofrost
	end
end

-- Blight of Galakrond

function mod:CorrosiveInfusion(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	if self:GetStage() == 1 then
		self:CDBar(args.spellId, 17.0)
	elseif self:GetStage() == 2 then
		corrosiveInfusionCount = corrosiveInfusionCount + 1
		if corrosiveInfusionCount == 2 then
			self:CDBar(args.spellId, 34.0)
		else
			self:CDBar(args.spellId, 31.6)
		end
	else -- Stage 3
		corrosiveInfusionCount = corrosiveInfusionCount + 1
		if corrosiveInfusionCount == 2 then
			self:CDBar(args.spellId, 62.0)
		else
			self:CDBar(args.spellId, 60.0)
		end
	end
end

function mod:CorrosionApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
	self:SecondaryIcon(args.spellId, args.destName)
	if self:Mythic() then
		self:TargetBar(args.spellId, 15, args.destName)
	end
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Corrosion")
		if self:Mythic() then
			self:YellCountdown(args.spellId, 15, nil, 5)
		end
	end
end

function mod:CorrosionRemoved(args)
	self:SecondaryIcon(args.spellId)
	if self:Mythic() then
		self:StopBar(args.spellId, args.destName)
		if self:Me(args.destGUID) then
			self:CancelYellCountdown(args.spellId)
		end
	end
end

function mod:CorruptedMindApplied(args)
	-- 20 second mind control, no way to break it
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "warning", nil, args.destName)
end

function mod:BlightReclamation(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	if self:GetStage() == 1 then
		self:CDBar(args.spellId, 17.0)
	elseif self:GetStage() == 2 then
		self:CDBar(args.spellId, 31.6)
	else -- Stage 3
		self:CDBar(args.spellId, 60.0)
	end
end

do
	local prev = 0
	function mod:BlightSeepDamage(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			if self:Me(args.destGUID) then
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

-- Ahnzon

function mod:NecroticWinds(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 31.6)
end

-- Loszkeleth

do
	local function printTarget(self, name, guid)
		self:TargetMessage(408029, "yellow", name, CL.casting:format(self:SpellName(408029)))
		self:PlaySound(408029, "alert", nil, name)
	end

	function mod:Necrofrost(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		-- pull:133.9, 19.4, 42.5
		necrofrostCount = necrofrostCount + 1
		if necrofrostCount == 3 then
			self:CDBar(args.spellId, 42.5)
		elseif necrofrostCount % 2 == 0 then
			self:CDBar(args.spellId, 19.4)
		else
			self:CDBar(args.spellId, 40.0)
		end
	end
end

do
	local necrofrostGUID = nil

	function mod:NecrofrostApplied(args)
		if self:Dispeller("movement", nil, 408029) then
			-- can be dispelled by movement dispellers, so alert on application
			self:TargetMessage(408029, "cyan", args.destName)
			self:PlaySound(408029, "info", nil, args.destName)
		end
		if self:Me(args.destGUID) then
			self:Say(408029, nil, nil, "Necrofrost")
		end
		necrofrostGUID = args.sourceGUID
		self:RegisterTargetEvents("MarkNecrofrost")
	end

	function mod:MarkNecrofrost(_, unit, guid)
		if necrofrostGUID == guid then
			necrofrostGUID = nil
			self:CustomIcon(necrofrostMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end
end

-- Dazhak

do
	local function printTarget(self, name, guid)
		self:TargetMessage(408141, "orange", name)
		self:PlaySound(408141, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(408141, nil, nil, "Incinerating Blightbreath")
		end
		incineratingBlightbreathCount = incineratingBlightbreathCount + 1
		if incineratingBlightbreathCount % 3 == 1 then -- 4, 7...
			self:CDBar(408141, 25.5)
		else -- 2, 3, 5, 6...
			self:CDBar(408141, 17.0)
		end
	end

	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
		if spellId == 413596 then -- Incinerating Blightbreath
			self:GetNextBossTarget(printTarget, self:UnitGUID(unit), 1)
		end
	end
end
