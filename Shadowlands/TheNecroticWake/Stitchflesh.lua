--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Surgeon Stitchflesh", 2286, 2392)
if not mod then return end
mod:RegisterEnableMob(162689) -- Surgeon Stitchflesh
mod:SetEncounterID(2389)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local hooked = false

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		320358, -- Awaken Creation
		{322681, "FLASH", "SAY", "SAY_COUNTDOWN"}, -- Meat Hook
		{320376, "TANK"}, -- Mutilate
		334476, -- Embalming Ichor
		{320200, "ME_ONLY"}, -- Stitchneedle
		{334488, "TANK"}, -- Cleave Flesh
		320359, -- Escape
		{343556, "SAY"}, -- Morbid Fixation
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AwakenCreation", 320358)
	self:Log("SPELL_AURA_APPLIED", "MeatHookApplied", 322681) -- Aim Debuff
	self:Log("SPELL_AURA_REMOVED", "MeatHookRemoved", 322681)
	self:Log("SPELL_AURA_APPLIED", "MeatHookHit", 322548) -- Surgeon Stitchflesh Pull Down
	self:Log("SPELL_CAST_START", "MutilateStart", 320376)
	self:Log("SPELL_CAST_SUCCESS", "EmbalmingIchor", 334476)
	self:Log("SPELL_AURA_APPLIED", "StitchneedleApplied", 320200)
	self:Log("SPELL_CAST_START", "CleaveFlesh", 334488)
	self:Log("SPELL_CAST_SUCCESS", "Escape", 320359)
	self:Log("SPELL_CAST_START", "MorbidFixation", 343556)
	self:Log("SPELL_AURA_APPLIED", "MorbidFixationApplied", 343556)
	self:Log("SPELL_AURA_REMOVED", "MorbidFixationRemoved", 343556)
end

function mod:OnEngage()
	hooked = false
	self:Bar(322681, 10.5) -- Meat Hook
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AwakenCreation(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 27.9)
end

function mod:MeatHookApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
		self:Say(args.spellId, nil, nil, "Meat Hook")
		self:SayCountdown(args.spellId, 4)
		self:Flash(args.spellId)
	end
	self:CDBar(args.spellId, 18)
end

function mod:MeatHookRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:MeatHookHit(args)
	if self:MobId(args.destGUID) == 162689 and not hooked then -- Surgeon Stitchflesh
		hooked = true
		self:TargetMessage(322681, "green", args.destName)
		self:PlaySound(322681, "long")

		self:StopBar(320358) -- Summon Creation

		self:Bar(320359, 30) -- Escape
	end
end

function mod:MutilateStart(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
end

function mod:EmbalmingIchor(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 12.1)
end

function mod:StitchneedleApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end

function mod:CleaveFlesh(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 9.7)
end

function mod:Escape(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")

	hooked = false

	self:StopBar(334488) -- Cleave Flesh
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) then
			self:Say(343556, nil, nil, "Morbid Fixation")
			self:PlaySound(343556, "warning")
		end
		self:TargetMessage(343556, "red", name)
	end

	function mod:MorbidFixation(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

function mod:MorbidFixationApplied(args)
	if self:Me(args.destGUID) then
		self:TargetBar(args.spellId, 8, args.destName)
	end
end

function mod:MorbidFixationRemoved(args)
	if self:Me(args.destGUID) then
		self:StopBar(args.spellId, args.destName)
	end
end
