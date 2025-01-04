--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zevrim Thornhoof", 429, 402)
if not mod then return end
mod:RegisterEnableMob(11490) -- Zevrim Thornhoof
mod:SetEncounterID(343)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		22478, -- Intense Pain
		22651, -- Sacrifice
		17228, -- Shadow Bolt Volley
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "IntensePain", 22478)
	self:Log("SPELL_CAST_SUCCESS", "Sacrifice", 22651)
	self:Log("SPELL_AURA_APPLIED", "SacrificeApplied", 22651)
	self:Log("SPELL_CAST_START", "ShadowBoltVolley", 17228)
	if self:Heroic() or (self:Classic() and not self:Vanilla()) then -- no encounter events in Timewalking or Cataclysm Classic
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 11490)
	end
end

function mod:OnEngage()
	self:CDBar(22478, 3.7) -- Intense Pain
	self:CDBar(22651, 7.1) -- Sacrifice
	self:CDBar(17228, 8.3) -- Shadow Bolt Volley
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:IntensePain(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 8.5)
	self:PlaySound(args.spellId, "alert")
end

function mod:Sacrifice(args)
	self:CDBar(args.spellId, 17.0)
end

function mod:SacrificeApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end

function mod:ShadowBoltVolley(args)
	if self:MobId(args.sourceGUID) == 11490 then -- Zevrim Thornhoof
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 17.0)
		self:PlaySound(args.spellId, "alert")
	end
end
