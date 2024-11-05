--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Willey Hopebreaker", 329, 446)
if not mod then return end
mod:RegisterEnableMob(10997) -- Willey Hopebreaker
mod:SetEncounterID(475)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		17279, -- Summon Risen Rifleman
		{110762, "TANK"}, -- Knock Away
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "SummonRisenRifleman", 17279)
	if self:Retail() then
		self:Log("SPELL_CAST_SUCCESS", "KnockAway", 110762)
	else -- Classic
		self:Log("SPELL_CAST_SUCCESS", "KnockAway", 10101)
	end
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 10997)
	end
end

function mod:OnEngage()
	self:CDBar(17279, 6.1) -- Summon Risen Rifleman
	self:CDBar(110762, 8.7) -- Knock Away
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			17279, -- Summon Crimson Rifleman
			{10101, "TANK"}, -- Knock Away
		}
	end

	function mod:OnEngage()
		self:CDBar(17279, 6.4) -- Summon Crimson Rifleman
		self:CDBar(10101, 8.7) -- Knock Away
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SummonRisenRifleman(args) -- Summon Crimson Rifleman on Classic
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 6.1)
	self:PlaySound(args.spellId, "info")
end

function mod:KnockAway(args)
	if self:MobId(args.sourceGUID) == 10997 then -- Willey Hopebreaker
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 12.2)
		self:PlaySound(args.spellId, "alert")
	end
end
