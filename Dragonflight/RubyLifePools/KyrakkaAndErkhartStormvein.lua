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
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss2")
	self:Death("BossDeath", 190484, 190485)
	self:Log("SPELL_CAST_START", "RoaringFirebreath", 381525)
	self:Log("SPELL_CAST_START", "WindsOfChange", 381517)
	self:Log("SPELL_CAST_START", "Stormslam", 381512)
	self:Log("SPELL_AURA_APPLIED", "StormslamApplied", 381515)
	self:Log("SPELL_AURA_APPLIED_DOSE", "StormslamApplied", 381515)
end

function mod:OnEngage()
	self:SetStage(1)
	self:Bar(381525, 1.6) -- Roaring Firebreath
	self:Bar(381517, 2) -- Winds of Change
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 382521 then -- Kyrakka
		self:SetStage(2)
		self:Message("stages", "cyan", CL.stage:format(2), false)
		self:PlaySound("stages", "long")
		-- TODO stopbars?
	end
end

function mod:BossDeath(args)
	self:SetStage(3)
	self:Message("stages", "cyan", CL.stage:format(3), false)
	self:PlaySound("stages", "long")
end

function mod:RoaringFirebreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 31.2)
end

function mod:WindsOfChange(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 18.6)
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
