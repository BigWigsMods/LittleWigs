--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Guard Mol'dar", 429, 411)
if not mod then return end
mod:RegisterEnableMob(14326) -- Guard Mol'dar
mod:SetEncounterID(362)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		11972, -- Shield Bash
		15749, -- Shield Charge
		{14516, "TANK"}, -- Strike
		8269, -- Frenzy
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "ShieldBash", 11972)
	self:Log("SPELL_CAST_SUCCESS", "ShieldCharge", 15749)
	self:Log("SPELL_CAST_SUCCESS", "Strike", 14516)
	self:Log("SPELL_AURA_APPLIED", "FrenzyApplied", 8269)
end

function mod:OnEngage()
	-- Shield Charge is cast immediately
	-- Shield Bash is only cast if there are casters in melee range
	self:CDBar(14516, 11.6) -- Strike
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ShieldBash(args)
	if self:MobId(args.sourceGUID) == 14326 then -- Guard Mol'dar
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:CDBar(args.spellId, 12.1)
		if self:Me(args.destGUID) then
			self:PlaySound(args.spellId, "alarm", nil, args.destName)
		end
	end
end

function mod:ShieldCharge(args)
	if self:MobId(args.sourceGUID) == 14326 then -- Guard Mol'dar
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:CDBar(args.spellId, 15.8)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:Strike(args)
	if self:MobId(args.sourceGUID) == 14326 then -- Guard Mol'dar
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 11.8)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:FrenzyApplied(args)
	if self:MobId(args.sourceGUID) == 14326 then -- Guard Mol'dar
		self:Message(args.spellId, "cyan", CL.percent:format(50, args.spellName))
		self:PlaySound(args.spellId, "long")
	end
end
