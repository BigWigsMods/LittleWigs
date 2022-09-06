--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("So'leah", 2441, 2455)
if not mod then return end
mod:RegisterEnableMob(177269) -- So'leah
mod:SetEncounterID(2442)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		351124, -- Summon Assassins
		353635, -- Collapsing Star
		350804, -- Collapsing Energy
		350796, -- Hyperlight Spark
		351086, -- Power Overwhelming
		351096, -- Energy Fragmentation
		351119, -- Shuriken Blitz
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_CAST_SUCCESS", "SummonAssassins", 351124)
	self:Log("SPELL_CAST_START", "CollapsingStar", 353635)
	self:Log("SPELL_CAST_SUCCESS", "CollapsingStarSummoned", 353635)
	self:Log("SPELL_AURA_APPLIED", "CollapsingEnergyApplied", 350804)
	self:Log("SPELL_AURA_APPLIED_DOSE", "CollapsingEnergyApplied", 350804)
	self:Log("SPELL_AURA_REMOVED", "CollapsingEnergyRemoved", 350804)
	self:Log("SPELL_CAST_START", "HyperlightSpark", 350796)
	self:Log("SPELL_CAST_SUCCESS", "PowerOverwhelming", 351086)
	self:Log("SPELL_AURA_REMOVED", "PowerOverwhelmingRemoved", 351086)
	self:Log("SPELL_CAST_SUCCESS", "EnergyFragmentation", 351096)
	self:Log("SPELL_CAST_START", "ShurikenBlitz", 351119)
end

function mod:OnEngage()
	self:SetStage(1)
	self:Bar(351124, 6.6) -- Summon Assassins
	self:Bar(350796, 12.2) -- Hyperlight Spark
	self:Bar(353635, 20.3) -- Collapsing Star
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 351104 then -- Phase Transition
		self:SetStage(2)
		self:Message("stages", "cyan", CL.stage:format(2), false)
		self:PlaySound("stages", "long")
		self:StopBar(350796) -- Hyperlight Spark
		self:StopBar(351124) -- Summon Assassins
		self:StopBar(353635) -- Collapsing Star
	end
end

function mod:SummonAssassins(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 42)
end

function mod:CollapsingStar(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	if self:GetStage() == 1 then
		self:Bar(args.spellId, 61)
	else
		self:StopBar(args.spellId)
	end
end

do
	local starCount = 4

	function mod:CollapsingStarSummoned()
		starCount = 4
		self:Bar(350804, 30, CL.count:format(CL.explosion, starCount))
	end

	function mod:CollapsingEnergyApplied(args)
		if self:Me(args.destGUID) then
			self:StackMessage(args.spellId, "blue", args.destName, args.amount, 2)

			local barTimeLeft = self:BarTimeLeft(CL.count:format(CL.explosion, starCount))
			self:StopBar(CL.count:format(CL.explosion, starCount))
			starCount = starCount - 1
			if starCount > 0 then
				self:Bar(args.spellId, barTimeLeft, CL.count:format(CL.explosion, starCount))
			end
		end
	end
end

function mod:CollapsingEnergyRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:HyperlightSpark(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 15.8)
end

function mod:PowerOverwhelming(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:StopBar(args.spellId)
end

function mod:PowerOverwhelmingRemoved(args)
	self:Message(args.spellId, "yellow", CL.removed:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 65)
	self:Bar(353635, 25) -- Collapsing Star
end

function mod:EnergyFragmentation(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:ShurikenBlitz(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end
