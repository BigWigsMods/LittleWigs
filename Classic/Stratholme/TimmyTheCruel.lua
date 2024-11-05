--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Timmy the Cruel", 329, 445)
if not mod then return end
mod:RegisterEnableMob(10808) -- Timmy the Cruel
mod:SetEncounterID(474)
--mod:SetRespawnTime(0) resets, doesn't respawn
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		17470, -- Ravenous Claw
		8599, -- Enrage
		12021, -- Fixate
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "RavenousClaw", 17470) -- no SPELL_CAST_START
	self:Log("SPELL_CAST_SUCCESS", "Enrage", 8599)
	if self:Retail() then
		self:Log("SPELL_CAST_SUCCESS", "Fixate", 12021)
	end
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	end
	if self:Heroic() or self:Classic() then -- no encounter events in Timewalking, ENCOUNTER_END missing in Classic
		self:Death("Win", 10808)
	end
end

function mod:OnEngage()
	self:SetStage(1)
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			17470, -- Ravenous Claw
			8599, -- Enrage
		}
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RavenousClaw(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 5.5)
	self:PlaySound(args.spellId, "alert")
end

function mod:Enrage(args)
	if self:MobId(args.sourceGUID) == 10808 then -- Timmy the Cruel
		self:SetStage(2)
		self:Message(args.spellId, "cyan", CL.percent:format(50, args.spellName))
		self:CDBar(17470, 2.0) -- Ravenous Claw
		self:PlaySound(args.spellId, "long")
	end
end

function mod:Fixate(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:CDBar(args.spellId, 21.8)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "alarm")
	end
end
