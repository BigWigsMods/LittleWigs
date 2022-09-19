if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kyrakka and Erkhart Stormvein", 2521, 2503)
if not mod then return end
mod:RegisterEnableMob(
	190484, -- Kyrakka
	190485  -- Erkhart Stormvein
)
mod:SetEncounterID(2623)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		381525, -- Roaring Firebreath
		381517, -- Winds of Change
		{381512, "TANK_HEALER"}, -- Stormslam
	}, {
		[381525] = -25365, -- Kyrakka
		[381517] = -25369, -- Erkhart Stormvein
	}
end

function mod:OnBossEnable()
	-- Stages
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss2")
	--self:Log("SPELL_CAST_SUCCESS", "EncounterEvent", 181089)
	self:Death("BossDeath", 190484, 190485)

	-- Kyrakka
	self:Log("SPELL_CAST_START", "RoaringFirebreath", 381525)

	-- Erkhart Stormvein
	self:Log("SPELL_CAST_START", "WindsOfChange", 381517)
	self:Log("SPELL_CAST_START", "Stormslam", 381512)
	self:Log("SPELL_AURA_APPLIED", "StormslamApplied", 381515)
	self:Log("SPELL_AURA_APPLIED_DOSE", "StormslamApplied", 381515)
end

function mod:OnEngage()
	self:SetStage(1)
	self:Bar(381525, 1.6) -- Roaring Firebreath
	self:Bar(381512, 6.1) -- Stormslam
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 382521 then -- Kyrakka
		self:SetStage(2)
		self:Message("stages", "cyan", CL.stage:format(2), false)
		self:PlaySound("stages", "long")
		-- TODO stopbars?
	end
end

-- TODO uncomment this and delete UNIT_SPELLCAST_SUCCEEDED when this boss starts firing 181089 for the phase change
--[[function mod:EncounterEvent()
	self:SetStage(2)
	self:Message("stages", "cyan", CL.stage:format(2), false)
	self:PlaySound("stages", "long")
	-- TODO stopbars?
end]]--

function mod:BossDeath(args)
	if self:GetStage() ~= 3 then
		self:SetStage(3)
		self:Message("stages", "cyan", CL.stage:format(3), false)
		self:PlaySound("stages", "long")
		
		if args.mobId == 190484 then -- Kyrakka
			self:StopBar(381525) -- Roaring Firebreath
		else -- Erkhart Stormvein
			self:StopBar(381512) -- Stormslam
			self:StopBar(381517) -- Winds of Change
		end
	end
end

-- Kyrakka

function mod:RoaringFirebreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 18.2)
end

-- Erkhart Stormvein

function mod:WindsOfChange(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 18.2)
end

function mod:Stormslam(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 9.7)
end

function mod:StormslamApplied(args)
	self:StackMessage(381512, "purple", args.destName, args.amount, 2)
	self:PlaySound(381512, "alert")
end
