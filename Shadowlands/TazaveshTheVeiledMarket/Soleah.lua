
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("So'leah", 2441, 2455)
if not mod then return end
mod:RegisterEnableMob(177269) -- So'leah
mod:SetEncounterID(2442)

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
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_CAST_SUCCESS", "SummonAssassins", 351124)
	self:Log("SPELL_CAST_START", "CollapsingStar", 353635)
	self:Log("SPELL_AURA_APPLIED", "CollapsingEnergyApplied", 350804)
	self:Log("SPELL_AURA_APPLIED_DOSE", "CollapsingEnergyApplied", 350804)
	self:Log("SPELL_AURA_REMOVED", "CollapsingEnergyRemoved", 350804)
	self:Log("SPELL_CAST_START", "HyperlightSpark", 350796)
	self:Log("SPELL_CAST_SUCCESS", "PowerOverwhelming", 351086)
	self:Log("SPELL_CAST_SUCCESS", "EnergyFragmentation", 351096)
end

function mod:OnEngage()
	self:Bar(350796, 12.2) -- Hyperlight Spark
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 351104 then -- Phase Transition
		self:Message("stages", "cyan", CL.stage:format(2), false)
		self:PlaySound("stages", "long")
		self:StopBar(350796) -- Hyperlight Spark
	end
end

function mod:SummonAssassins(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:CollapsingStar(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:CollapsingEnergyApplied(args)
	if self:Me(args.destGUID) then
		self:NewStackMessage(args.spellId, "blue", args.destName, args.amount)
	end
end

function mod:CollapsingEnergyRemoved(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId, "removed")
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
end

function mod:EnergyFragmentation(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end
