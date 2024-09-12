--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Captain Cookie", 36, 93)
if not mod then return end
mod:RegisterEnableMob(47739) -- Cookie
mod:SetEncounterID(1060)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		89263, -- Throw Food
		89267, -- Satiated
		89732, -- Nauseated
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "CauldronFire", 89252) -- Throw Food (first one only)
	self:Log("SPELL_AURA_APPLIED", "SatiatedApplied", 89267)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SatiatedApplied", 89267)
	self:Log("SPELL_AURA_REFRESH", "SatiatedRefresh", 89267)
	self:Log("SPELL_AURA_REMOVED", "SatiatedRemoved", 89267)
	self:Log("SPELL_AURA_APPLIED", "NauseatedApplied", 89732)
	self:Log("SPELL_AURA_APPLIED_DOSE", "NauseatedApplied", 89732)
	self:Log("SPELL_AURA_REMOVED", "NauseatedRemoved", 89732)
end

function mod:OnEngage()
	self:CDBar(89263, 7.2) -- Throw Food
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CauldronFire() -- Throw Food
	-- use this ability to track the very first Throw Food, which is then spammed for the entire fight.
	self:StopBar(89263)
	self:Message(89263, "cyan")
	self:PlaySound(89263, "long")
end

function mod:SatiatedApplied(args)
	if self:Me(args.destGUID) then
		-- not using StackMessage in order to preserve message color, since all alerts are just for the player
		self:Message(args.spellId, "green", CL.stackyou:format(args.amount or 1, args.spellName))
		self:PlaySound(args.spellId, "info", nil, args.destName)
		self:TargetBar(args.spellId, 30, args.destName)
	end
end

function mod:SatiatedRefresh(args)
	if self:Me(args.destGUID) then
		self:TargetBar(args.spellId, 30, args.destName)
	end
end

function mod:SatiatedRemoved(args)
	if self:Me(args.destGUID) then
		self:StopBar(args.spellName, args.destName)
	end
end

function mod:NauseatedApplied(args)
	if self:Me(args.destGUID) then
		-- not using StackMessage in order to preserve message color, since all alerts are just for the player
		self:Message(args.spellId, "red", CL.stackyou:format(args.amount or 1, args.spellName))
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
		self:TargetBar(args.spellId, 30, args.destName)
	end
end

function mod:NauseatedRemoved(args)
	if self:Me(args.destGUID) then
		self:StopBar(args.spellName, args.destName)
	end
end
