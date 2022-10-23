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
		-- Kyrakka
		381862, -- Infernocore
		381525, -- Roaring Firebreath
		-- Erkhart Stormvein
		381517, -- Winds of Change
		381516, -- Interrupting Cloudburst
		{381512, "TANK_HEALER"}, -- Stormslam
	}, {
		[381862] = -25365, -- Kyrakka
		[381517] = -25369, -- Erkhart Stormvein
	}
end

function mod:OnBossEnable()
	-- Stages
	self:Log("SPELL_AURA_APPLIED", "EncounterEvent", 181089)
	self:Death("BossDeath", 190484, 190485)

	-- Kyrakka
	self:Log("SPELL_AURA_APPLIED", "InfernocoreApplied", 381862)
	self:Log("SPELL_AURA_APPLIED_DOSE", "InfernocoreApplied", 381862)
	self:Log("SPELL_CAST_START", "RoaringFirebreath", 381525)

	-- Erkhart Stormvein
	self:Log("SPELL_CAST_START", "WindsOfChange", 381517)
	self:Log("SPELL_CAST_START", "InterruptingCloudburst", 381516)
	self:Log("SPELL_CAST_START", "Stormslam", 381512)
	self:Log("SPELL_AURA_APPLIED", "StormslamApplied", 381515)
	self:Log("SPELL_AURA_APPLIED_DOSE", "StormslamApplied", 381515)
end

function mod:OnEngage()
	self:SetStage(1)
	self:Bar(381525, 1.6) -- Roaring Firebreath
	self:Bar(381512, 6.1) -- Stormslam
	if self:Mythic() then
		self:Bar(381516, 9.7) -- Interrupting Cloudburst
	end
	self:Bar(381517, 17) -- Winds of Change
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:EncounterEvent()
	-- when either boss reaches 50%, Kyrakka lands so Erkhart can remount
	self:SetStage(2)
	self:Message("stages", "cyan", CL.stage:format(2), false)
	self:PlaySound("stages", "long")
end

function mod:BossDeath(args)
	if self:GetStage() ~= 3 then
		self:SetStage(3)
		self:Message("stages", "cyan", CL.stage:format(3), false)
		self:PlaySound("stages", "long")
		
		if args.mobId == 190484 then -- Kyrakka
			self:StopBar(381525) -- Roaring Firebreath
		else -- Erkhart Stormvein
			self:StopBar(381517) -- Winds of Change
			self:StopBar(381516) -- Interrupting Cloudburst
			self:StopBar(381512) -- Stormslam
		end
	end
end

-- Kyrakka

do
	local prev = 0

	function mod:InfernocoreApplied(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1 then
				prev = t
				self:StackMessage(args.spellId, "blue", args.destName, args.amount, 2)
				self:PlaySound(args.spellId, "alert")
			end
			self:TargetBar(args.spellId, 3, args.destName)
		end
	end
end

function mod:RoaringFirebreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 19.1)
end

-- Erkhart Stormvein

function mod:WindsOfChange(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 17)
end

function mod:InterruptingCloudburst(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:Bar(args.spellId, 17)
	self:CastBar(args.spellId, 3)
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
