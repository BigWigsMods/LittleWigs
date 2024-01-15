--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Domina Venomblade", 2289, 2423)
if not mod then return end
mod:RegisterEnableMob(164266) -- Domina Venomblade
mod:SetEncounterID(2385)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		332313, -- Brood Assassins
		{325552, "DISPEL"}, -- Cytotoxic Slash
		{325245, "SAY", "SAY_COUNTDOWN"}, -- Shadow Ambush
		336258, -- Solitary Prey
		336301, -- Web Wrap
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BroodAssassins", 332313)
	self:Log("SPELL_CAST_SUCCESS", "CytotoxicSlash", 325552)
	self:Log("SPELL_AURA_APPLIED", "CytotoxicSlashApplied", 325552)
	self:Log("SPELL_AURA_APPLIED", "ShadowwhirlApplied", 333353) -- Shadowwhirl, Shadow Ambush target debuff
	self:Log("SPELL_AURA_REMOVED", "ShadowwhirlRemoved", 333353) -- Shadowwhirl, Shadow Ambush target debuff
	self:Log("SPELL_AURA_APPLIED", "SolitaryPreyApplied", 336258)
	self:Log("SPELL_AURA_REMOVED", "SolitaryPreyRemoved", 336258)
	self:Log("SPELL_AURA_APPLIED", "WebWrapApplied", 336301)
	self:Log("SPELL_AURA_REMOVED", "WebWrapRemoved", 336301)
end

function mod:OnEngage()
	self:Bar(325552, 6) -- Cytotoxic Slash
	self:Bar(325245, 11.2) -- Shadow Ambush
	self:Bar(332313, 11.2) -- Brood Assassins
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BroodAssassins(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 36)
end

function mod:CytotoxicSlash(args)
	self:Bar(args.spellId, 22)
end

function mod:CytotoxicSlashApplied(args)
	if self:Me(args.destGUID) or self:Healer() or self:Dispeller("poison", nil, args.spellId) then
		self:TargetMessage(args.spellId, "purple", args.destName)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:ShadowwhirlApplied(args)
	self:TargetMessage(325245, "yellow", args.destName)
	self:Bar(325245, 22)
	if self:Me(args.destGUID) then
		self:PlaySound(325245, "warning")
		self:Say(325245, nil, nil, "Shadow Ambush")
		self:SayCountdown(325245, 6)
	end
end

function mod:ShadowwhirlRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(325245)
	end
end

function mod:SolitaryPreyApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm")
		self:TargetBar(args.spellId, 6, args.destName)
	end
end

function mod:SolitaryPreyRemoved(args)
	if self:Me(args.destGUID) then
		self:StopBar(args.spellId, args.destName)
	end
end

function mod:WebWrapApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alarm")
end

function mod:WebWrapRemoved(args)
	self:Message(args.spellId, "green", CL.removed_from:format(args.spellName, args.destName))
	self:PlaySound(args.spellId, "info")
end
