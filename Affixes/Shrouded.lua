--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewDungeonAffix("Shrouded", 131, {1195, 1208, 1651, 2097, 2441})
if not mod then return end
mod:RegisterEnableMob(
	189910, -- Ta'ilh
	190128, -- Zul'gamux
	189878 -- Nathrezim Infiltrator
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.tailh = "Ta'ilh"
	L.zulgamux = "Zul'gamux"
	L.nathrezim_infiltrator = "Nathrezim Infiltrator"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Ta'ilh
		373121, -- Bounty: Versatility
		373108, -- Bounty: Critical Strike
		373113, -- Bounty: Haste
		373116, -- Bounty: Mastery
		-- Shared
		373370, -- Nightmare Cloud
		{373391, "DISPEL"}, -- Nightmare
		-- Zul'gamux
		373513, -- Shadow Eruption
		373724, -- Blood Barrier
		373552, -- Hypnosis Bat
		373570, -- Hypnosis
		-- Nathrezim Infiltrator
		{373364, "TANK"}, -- Vampiric Claws
		373429, -- Carrion Swarm

	}, {
		[373121] = L.tailh,
		[373370] = CL.general,
		[373513] = L.zulgamux,
		[373364] = L.nathrezim_infiltrator,
	}
end

function mod:OnBossEnable()
	-- Ta'ilh
	-- TODO reminder to choose buff? [CHAT_MSG_MONSTER_SAY] Excellent! I see you are here to help me with my problem. Let us talk more about how I can lend you additonal aid.#Ta'ilh#####0#0##0#218#nil#0#false#false#false#false",
	self:Log("SPELL_AURA_APPLIED", "BountyApplied", 373121, 373108, 373113, 373116) -- Bounty: various

	-- Shared
	self:Log("SPELL_CAST_SUCCESS", "NightmareCloud", 373370) -- Nightmare Cloud
	self:Log("SPELL_AURA_APPLIED", "NightmareApplied", 373391) -- Nightmare

	-- Zul'gamux
	self:Log("SPELL_CAST_START", "ShadowEruption", 373513) -- Shadow Eruption
	self:Log("SPELL_AURA_APPLIED", "BloodBarrierApplied", 373724) -- Blood Barrier
	self:Log("SPELL_AURA_REMOVED", "BloodBarrierRemoved", 373724) -- Blood Barrier
	self:Log("SPELL_CAST_SUCCESS", "HypnosisBat", 373552) -- Hypnosis Bat
	-- TODO Hypnosis Bat cast (Hypnosis 373618) stopped?
	self:Log("SPELL_AURA_APPLIED", "HypnosisApplied", 373570) -- Hypnosis
	self:Death("ZulgamuxDeath", 190128)

	-- Nathrezim Infiltrator
	self:Log("SPELL_CAST_START", "VampiricClaws", 373364) -- Vampiric Claws
	self:Log("SPELL_CAST_START", "CarrionSwarm", 373429) -- Carrion Swarm
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Ta'ilh

function mod:BountyApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green")
		self:PlaySound(args.spellId, "info")
	end
end

-- Shared

function mod:NightmareCloud(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:NightmareApplied(args)
	if self:Dispeller("magic", nil, args.spellId) or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Zul'gamux

function mod:ShadowEruption(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 24.3)
end

do
	local appliedAt = 0

	function mod:BloodBarrierApplied(args)
		appliedAt = args.time
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 24.3)
	end

	function mod:BloodBarrierRemoved(args)
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, args.time - appliedAt))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:HypnosisBat(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 18.2)
end

function mod:HypnosisApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "warning", nil, args.destName)
end

function mod:ZulgamuxDeath()
	self:StopBar(373513) -- Shadow Eruption
	self:StopBar(373724) -- Blood Barrier
	self:StopBar(373552) -- Hypnosis Bat
end

-- Nathrezim Infiltrator

function mod:VampiricClaws(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
end

function mod:CarrionSwarm(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end
