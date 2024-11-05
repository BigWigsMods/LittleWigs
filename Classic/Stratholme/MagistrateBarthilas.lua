--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Magistrate Barthilas", 329, 454)
if not mod then return end
mod:RegisterEnableMob(10435) -- Magistrate Barthilas
mod:SetEncounterID(482)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		10887, -- Crowd Pummel
		455596, -- Mighty Charge
		{16791, "DISPEL"}, -- Furious Anger
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "CrowdPummel", 10887)
	if self:Retail() then
		self:Log("SPELL_CAST_START", "MightyCharge", 455596)
		self:Log("SPELL_CAST_SUCCESS", "FuriousAnger", 16791) -- stacks much faster on Classic
	else -- Classic
		self:Log("SPELL_CAST_SUCCESS", "MightyBlow", 14099)
	end
	self:Log("SPELL_AURA_APPLIED_DOSE", "FuriousAngerApplied", 16791)
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 10435)
	end
end

function mod:OnEngage()
	if self:Dispeller("enrage", true, 16791) then
		self:CDBar(16791, 5.0) -- Furious Anger
	end
	self:CDBar(455596, 5.7) -- Mighty Charge
	self:CDBar(10887, 11.8) -- Crowd Pummel
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			10887, -- Crowd Pummel
			{14099, "TANK"}, -- Mighty Blow
			{16791, "DISPEL"}, -- Furious Anger
		}
	end

	function mod:OnEngage()
		self:CDBar(14099, 10.1) -- Mighty Blow
		self:CDBar(10887, 11.8) -- Crowd Pummel
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CrowdPummel(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 15.8)
	self:PlaySound(args.spellId, "alert")
end

function mod:MightyCharge(args)
	-- only cast if players are at range
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 6.1)
	self:PlaySound(args.spellId, "alarm")
end

function mod:FuriousAnger(args)
	if self:Dispeller("enrage", true, args.spellId) then
		self:CDBar(args.spellId, 10.9)
	end
end

function mod:FuriousAngerApplied(args)
	if args.amount % 3 == 0 and self:Dispeller("enrage", true, args.spellId) then
		self:Message(args.spellId, "yellow", CL.stack:format(args.amount, CL.onboss:format(args.spellName)))
		self:PlaySound(args.spellId, "info")
	end
end

--------------------------------------------------------------------------------
-- Classic Event Handlers
--

function mod:MightyBlow(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 11.3)
	self:PlaySound(args.spellId, "alarm")
end
