
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Surgeon Stitchflesh", 2286, 2392)
if not mod then return end
mod:RegisterEnableMob(162689) -- Surgeon Stitchflesh
mod.engageId = 2389
--mod.respawnTime = 30
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
		{320376, "TANK"}, -- Mutlilate
		334476, -- Embalming Ichor
		{320200, "ME_ONLY"}, -- Stitchneedle
		{334488, "TANK"}, -- Cleave Flesh
		320359, -- Escape
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AwakenCreation", 320358)
	self:Log("SPELL_AURA_APPLIED", "MeatHookApplied", 322681) -- Aim Debuff
	self:Log("SPELL_AURA_APPLIED", "MeatHookHit", 322548) -- Surgeon Stitchflesh Pull Down
	self:Log("SPELL_CAST_START", "MutlilateStart", 320376)
	self:Log("SPELL_CAST_SUCCESS", "EmbalmingIchor", 334476)
	self:Log("SPELL_AURA_APPLIED", "StitchneedleApplied", 320200)
	self:Log("SPELL_CAST_START", "CleaveFlesh", 334488)
	self:Log("SPELL_CAST_SUCCESS", "Escape", 320359)
end

function mod:OnEngage()
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
		self:Say(args.spellId, args.spellName)
		self:SayCountdown(args.spellId, 4)
		self:Flash(args.spellId)
	end
	self:CDBar(args.spellId, 18)
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

function mod:MutlilateStart(args)
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
