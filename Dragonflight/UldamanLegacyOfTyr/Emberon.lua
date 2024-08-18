--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Emberon", 2451, 2476)
if not mod then return end
mod:RegisterEnableMob(184422) -- Emberon
mod:SetEncounterID(2558)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local purgingFlamesDisabled = false
local purgingFlamesActive = false
local unstableEmbersRemaining = 3
local searingClapRemaining = 2
local nextUnstableEmbers = 0
local nextSearingClap = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{368990, "CASTBAR"}, -- Purging Flames
		369043, -- Infusion
		369038, -- Titanic Ward
		369110, -- Unstable Embers
		369061, -- Searing Clap
	}, nil, {
		[369043] = CL.adds,
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:Log("SPELL_CAST_SUCCESS", "PurgingFlamesPrecast", 369022)
	self:Log("SPELL_CAST_START", "PurgingFlames", 368990)
	self:Log("SPELL_CAST_SUCCESS", "HeatEngine", 369026)
	self:Log("SPELL_AURA_REMOVED", "PurgingFlamesRemoved", 368990)
	self:Log("SPELL_AURA_REMOVED", "SacredBarrierRemoved", 369031)
	self:Log("SPELL_AURA_APPLIED", "InfusionApplied", 369043)
	self:Log("SPELL_AURA_REMOVED", "InfusionRemoved", 369043)
	self:Log("SPELL_CAST_START", "UnstableEmbers", 369110)
	self:Log("SPELL_CAST_START", "SearingClap", 369061)
end

function mod:OnEngage()
	purgingFlamesDisabled = false
	purgingFlamesActive = false
	unstableEmbersRemaining = 3
	searingClapRemaining = 2
	nextUnstableEmbers = 0
	nextSearingClap = 0
	self:SetStage(1)
	self:CDBar(369061, 4.5) -- Searing Clap
	self:CDBar(369110, 12.1) -- Unstable Embers
	-- 35s energy gain + ~3.5s delay
	self:CDBar(368990, 38.5) -- Purging Flames
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_HEALTH(event, unit)
	-- Emberon won't cast Purging Flames below 10%, but he also resumes
	-- casting his other abilities which are normally limited.
	if self:GetHealth(unit) < 10 then
		purgingFlamesDisabled = true
		self:UnregisterUnitEvent(event, unit)
		self:StopBar(368990) -- Purging Flames
		-- resume timers for Unstable Embers and Searing Clap
		local t = GetTime()
		local unstableEmbersTimer = nextUnstableEmbers - t
		if unstableEmbersTimer > 0 then
			self:CDBar(369110, {unstableEmbersTimer, 11.7}) -- Unstable Embers
		end
		local searingClapTimer = nextSearingClap - t
		if searingClapTimer > 0 then
			self:CDBar(369061, {searingClapTimer, 23.0}) -- Searing Clap
		end
	end
end

function mod:PurgingFlamesPrecast(args)
	-- this is cast when the boss runs to the center, we can clean up extra
	-- timers for skipped abilities a little early
	nextUnstableEmbers = 0
	nextSearingClap = 0
	self:StopBar(369110) -- Unstable Embers
	self:StopBar(369061) -- Searing Clap
end

function mod:PurgingFlames(args)
	purgingFlamesActive = true
	self:SetStage(2)
	self:StopBar(args.spellId)
	self:Message(args.spellId, "cyan")
	if self:Normal() then
		-- Normal has a fixed cast time instead of needing to kill adds to end the stage
		self:CastBar(args.spellId, 24.3)
	end
	self:PlaySound(args.spellId, "long")
end

function mod:HeatEngine(args)
	self:Message(369038, "green", CL.removed:format(self:SpellName(369038))) -- Titanic Ward
	self:PlaySound(369038, "info")
end

function mod:PurgingFlamesRemoved()
	purgingFlamesActive = false
end

function mod:SacredBarrierRemoved()
	if self:Normal() then
		self:StopBar(CL.cast:format(self:SpellName(368990))) -- Purging Flames
	end
	self:SetStage(1)
	if self:Mythic() then
		unstableEmbersRemaining = 3 -- usually 2, rarely 3
		searingClapRemaining = 2
		self:CDBar(369061, 5.9) -- Searing Clap
		self:CDBar(369110, 13.3) -- Unstable Embers
	else
		unstableEmbersRemaining = 4 -- usually 3, rarely 4
		searingClapRemaining = 2
		self:CDBar(369110, 1.2) -- Unstable Embers
		self:CDBar(369061, 5.4) -- Searing Clap
	end
	if not purgingFlamesDisabled then
		-- 35s energy gain + ~2.7s delay
		self:CDBar(368990, 37.7) -- Purging Flames
	end
	self:Message(368990, "cyan", CL.over:format(self:SpellName(368990))) -- Purging Flames over
	self:PlaySound(368990, "long")
end

do
	local addsKilled = 0

	function mod:InfusionApplied(args)
		addsKilled = 0
	end

	function mod:InfusionRemoved(args)
		if not purgingFlamesActive then
			-- avoid spamming alerts on a Stage 2 wipe
			return
		end
		addsKilled = addsKilled + 1
		if addsKilled ~= 4 then
			self:Message(args.spellId, "green", CL.add_killed:format(addsKilled, 4))
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:UnstableEmbers(args)
	self:Message(args.spellId, "orange")
	unstableEmbersRemaining = unstableEmbersRemaining - 1
	if purgingFlamesDisabled or unstableEmbersRemaining > 0 then
		self:CDBar(args.spellId, 11.7)
	else
		nextUnstableEmbers = GetTime() + 11.7
		self:StopBar(args.spellId)
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:SearingClap(args)
	self:Message(args.spellId, "purple")
	searingClapRemaining = searingClapRemaining - 1
	if purgingFlamesDisabled or searingClapRemaining > 0 then
		self:CDBar(args.spellId, 23.0)
	else
		nextSearingClap = GetTime() + 23.0
		self:StopBar(args.spellId)
	end
	self:PlaySound(args.spellId, "alarm")
end
