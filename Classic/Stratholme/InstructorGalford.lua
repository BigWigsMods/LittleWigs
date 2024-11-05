--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Instructor Galford", 329, 448)
if not mod then return end
mod:RegisterEnableMob(10811) -- Instructor Galford
mod:SetEncounterID(477)
--mod:SetRespawnTime(0)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		17366, -- Fire Nova
		33975, -- Pyroblast
		{17293, "DISPEL"}, -- Burning Winds
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "FireNova", 17366)
	if self:Retail() then
		self:Log("SPELL_CAST_START", "Pyroblast", 33975)
	else
		self:Log("SPELL_CAST_START", "Pyroblast", 17274)
	end
	self:Log("SPELL_CAST_START", "BurningWinds", 17293)
	self:Log("SPELL_AURA_APPLIED", "BurningWindsApplied", 17293)
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 10811)
	end
end

function mod:OnEngage()
	self:CDBar(17366, 3.3) -- Fire Nova
	self:CDBar(33975, 6.1) -- Pyroblast
	self:CDBar(17293, 7.3) -- Burning Winds
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			17366, -- Fire Nova
			17274, -- Pyroblast
			{17293, "DISPEL"}, -- Burning Winds
		}
	end

	function mod:OnEngage()
		self:CDBar(17366, 1.4) -- Fire Nova
		self:CDBar(17293, 7.0) -- Burning Winds
		self:CDBar(17274, 7.0) -- Pyroblast
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FireNova(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 7.3)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Pyroblast(args)
	if self:MobId(args.sourceGUID) == 10811 then -- Instructor Galford
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 9.7)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:BurningWinds(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 9.7)
	self:PlaySound(args.spellId, "alert")
end

function mod:BurningWindsApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alarm")
	end
end
