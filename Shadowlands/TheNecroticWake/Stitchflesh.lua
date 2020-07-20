
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Surgeon Stitchflesh", 2286, 2392)
if not mod then return end
mod:RegisterEnableMob(162689) -- Surgeon Stitchflesh
mod.engageId = 2389
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		320358, -- Summon Creation
		{320208, "SAY", "SAY_COUNTDOWN"}, -- Meat Hook
		{320376, "TANK"}, -- Mutlilate
		320359, -- Escape
		320363, -- Embalming Ichor
		{320200, "ME_ONLY"}, -- Stitchneedle
		--323016, -- Dark Infusion
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SummonCreationStart", 320358)
	self:Log("SPELL_AURA_APPLIED", "MeatHookApplied", 322681) -- Aim Debuff
	self:Log("SPELL_AURA_APPLIED", "MeatHookHit", 322548) -- Surgeon Stitchflesh Pull Down
	self:Log("SPELL_CAST_START", "MutlilateStart", 320376)
	self:Log("SPELL_CAST_START", "Escape", 320359)
	self:Log("SPELL_CAST_SUCCESS", "EmbalmingIchorSuccess", 320363)
	self:Log("SPELL_AURA_APPLIED", "StitchneedleApplied", 320200)
	self:Log("SPELL_CAST_START", "DarkInfusionStart", 323016)
end

function mod:OnEngage()
	self:Bar(320358, 27.9) -- Summon Creation
	self:CDBar(320208, 10.5) -- Meat Hook
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SummonCreationStart(args)
	self:Message2(args.spellId, "cyan")
	--self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 27.9)
end

function mod:MeatHookApplied(args)
	self:TargetMessage2(320208, "red", args.destName)
	if self:Me(args.destGUID) then
		--self:PlaySound(320208, "warning")
		self:Say(320208, args.spellName)
		self:SayCountdown(320208, 4)
		self:Flash(320208)
	end
	self:Bar(320208, 18)
end

function mod:MeatHookHit(args)
	if self:MobId(args.sourceGUID) == 162689 then -- Surgeon Stitchflesh
		self:TargetMessage2(320208, "green", args.destName)
		--self:PlaySound(args.spellId, "long")

		self:StopBar(320358) -- Summon Creation

		self:CDBar(320359, 30.6) -- Escape
	end
end

function mod:MutlilateStart(args)
	self:Message2(args.spellId, "purple")
	--self:PlaySound(args.spellId, "alarm")
end

function mod:Escape(args)
	self:Message2(args.spellId, "cyan")
	--self:PlaySound(args.spellId, "alarm")
	self:Bar(320358, 3.6) -- Summon Creation
end

function mod:EmbalmingIchorSuccess(args)
	self:Message2(args.spellId, "yellow")
	--self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 17)
end

function mod:StitchneedleApplied(args)
	self:TargetMessage2(320200, "orange", args.destName)
	--self:PlaySound(320208, "info", nil, args.destName)
end

function mod:DarkInfusionStart(args)
	self:Message2(args.spellId, "yellow")
	--self:PlaySound(args.spellId, "info", nil, args.destName)
end
