--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Surgeon Stitchflesh", 2286, 2392)
if not mod then return end
mod:RegisterEnableMob(
	164578, -- Stitchflesh's Creation
	162689 -- Surgeon Stitchflesh
)
mod:SetEncounterID(2389)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local awakenCreationCount = 2
local stitchfleshsCreationCollector = {} -- store all the adds with their spawn order, used to manage bars

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Stage 1
		320358, -- Awaken Creation
		334476, -- Embalming Ichor
		{320200, "ME_ONLY"}, -- Stitchneedle
		327100, -- Noxious Fog
		-- Stage 2
		{334488, "TANK"}, -- Sever Flesh
		{343556, "SAY"}, -- Morbid Fixation
		320359, -- Escape
		-- Stitchflesh's Creation
		{322681, "SAY", "SAY_COUNTDOWN", "ME_ONLY_EMPHASIZE", "NAMEPLATE"}, -- Meat Hook
		{320376, "TANK"}, -- Mutilate
	}, {
		[320358] = CL.stage:format(1),
		[334488] = CL.stage:format(2),
		[322681] = -22983, -- Stitchflesh's Creation
	}
end

function mod:OnBossEnable()
	-- Stage 1
	self:Log("SPELL_CAST_START", "AwakenCreation", 320358)
	self:Log("SPELL_CAST_SUCCESS", "EmbalmingIchor", 327664, 334476) -- Stage 1, Stage 2
	self:Log("SPELL_PERIODIC_DAMAGE", "EmbalmingIchorDamage", 320366)
	self:Log("SPELL_PERIODIC_MISSED", "EmbalmingIchorDamage", 320366)
	self:Log("SPELL_AURA_APPLIED", "StitchneedleApplied", 320200)
	self:Log("SPELL_PERIODIC_DAMAGE", "NoxiousFogDamage", 327100)
	self:Log("SPELL_PERIODIC_MISSED", "NoxiousFogDamage", 327100)

	-- Stage 2
	self:Log("SPELL_CAST_START", "SeverFlesh", 334488)
	self:Log("SPELL_CAST_START", "MorbidFixation", 343556)
	self:Log("SPELL_AURA_APPLIED", "MorbidFixationApplied", 343556)
	self:Log("SPELL_AURA_REMOVED", "MorbidFixationRemoved", 343556)
	self:Log("SPELL_CAST_SUCCESS", "Escape", 320359)

	-- Stitchflesh's Creation
	self:Log("SPELL_AURA_APPLIED", "FesteringRotApplied", 334321) -- Stitchflesh's Creation spawned
	self:Log("SPELL_CAST_SUCCESS", "MeatHook", 322681)
	self:Log("SPELL_AURA_APPLIED", "MeatHookApplied", 322681) -- Player is targeted by Meat Hook
	self:Log("SPELL_AURA_REMOVED", "MeatHookRemoved", 322681)
	self:Log("SPELL_AURA_APPLIED", "MeatHookHit", 322548) -- Surgeon Stitchflesh pulled down
	self:Log("SPELL_CAST_START", "Mutilate", 320376)
	self:Death("StitchfleshsCreationDeath", 164578)
end

function mod:OnEngage()
	awakenCreationCount = 2 -- start at 2 because 1 is spawned right away
	stitchfleshsCreationCollector = {}
	self:SetStage(1)
	self:CDBar(320358, 28.1, CL.count:format(self:SpellName(320358), awakenCreationCount)) -- Awaken Creation
	local _, creationGUID = self:GetBossId(164578)
	if creationGUID then -- Stitchflesh's Creation
		stitchfleshsCreationCollector[creationGUID] = 1
		self:CDBar(322681, 10.5, CL.count:format(self:SpellName(322681), 1)) -- Meat Hook
		--self:Nameplate(320376, 6.1, creationGUID) -- Mutilate
		self:Nameplate(322681, 10.5, creationGUID) -- Meat Hook
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage 1

function mod:AwakenCreation(args)
	self:StopBar(CL.count:format(args.spellName, awakenCreationCount))
	self:Message(args.spellId, "cyan", CL.count:format(args.spellName, awakenCreationCount))
	self:PlaySound(args.spellId, "info")
	awakenCreationCount = awakenCreationCount + 1
	self:CDBar(args.spellId, 34.2, CL.count:format(args.spellName, awakenCreationCount))
end

function mod:EmbalmingIchor(args)
	self:Message(334476, "yellow")
	self:PlaySound(334476, "alarm")
	-- timer would just be noise, 18.6 in Stage 1 and 11.3 in Stage 2
end

do
	local prev = 0
	function mod:EmbalmingIchorDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.75 then
			prev = args.time
			self:PersonalMessage(334476, "underyou")
			self:PlaySound(334476, "underyou")
		end
	end
end

function mod:StitchneedleApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

do
	local prev = 0
	function mod:NoxiousFogDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

-- Stage 2

function mod:SeverFlesh(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	--self:CDBar(args.spellId, 9.7) -- timer would just be noise
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

function mod:Escape(args)
	self:StopBar(args.spellId)
	--self:StopBar(334488) -- Sever Flesh
	self:SetStage(1)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
end

-- Stitchflesh's Creation

function mod:FesteringRotApplied(args)
	-- this is applied on a new Stitchflesh's Creation when it spawns
	stitchfleshsCreationCollector[args.destGUID] = awakenCreationCount - 1
	self:CDBar(322681, 10.1, CL.count:format(self:SpellName(322681), awakenCreationCount - 1)) -- Meat Hook
	--self:Nameplate(320376, 7.4, args.destGUID) -- Mutilate
	self:Nameplate(322681, 10.1, args.destGUID) -- Meat Hook
end

function mod:MeatHook(args)
	if stitchfleshsCreationCollector[args.sourceGUID] then
		-- the mob should always be in the collector at this point unless you reload mid-fight with adds up,
		-- in which case you just won't get a bar for existing adds. the count in the Meat Hook bar corresponds
		-- to the add's spawn order.
		self:CDBar(args.spellId, 18.2, CL.count:format(args.spellName, stitchfleshsCreationCollector[args.sourceGUID]))
	end
	self:Nameplate(322681, 18.2, args.sourceGUID) -- Meat Hook
end

do
	local prevOnMe = 0
	function mod:MeatHookApplied(args)
		self:TargetMessage(args.spellId, "red", args.destName)
		local t = args.time
		if self:Me(args.destGUID) and t - prevOnMe > 4 then
			prevOnMe = t
			self:Say(args.spellId, nil, nil, "Meat Hook")
			self:SayCountdown(args.spellId, 4)
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:MeatHookRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:MeatHookHit(args)
	if self:MobId(args.destGUID) == 162689 and self:GetStage() == 1 then -- Surgeon Stitchflesh
		self:SetStage(2)
		self:Message(322681, "green", CL.stage:format(2))
		self:PlaySound(322681, "info")
		--self:CDBar(334488, 7.0) -- Sever Flesh
		self:CDBar(320359, 30.0) -- Escape
		self:CDBar(320358, 31.2, CL.count:format(self:SpellName(320358), awakenCreationCount)) -- Awaken Creation
	end
end

do
	local prev = 0
	function mod:Mutilate(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
		--self:Nameplate(args.spellId, 12.1, args.sourceGUID)
	end
end

function mod:StitchfleshsCreationDeath(args)
	if stitchfleshsCreationCollector[args.destGUID] then
		self:StopBar(CL.count:format(self:SpellName(322681), stitchfleshsCreationCollector[args.destGUID])) -- Meat Hook
		stitchfleshsCreationCollector[args.destGUID] = nil
	end
	self:ClearNameplate(args.destGUID)
end
