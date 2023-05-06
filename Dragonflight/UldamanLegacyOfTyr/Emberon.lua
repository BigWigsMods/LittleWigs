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

local purgingFlamesActive = false
local unstableEmbersRemaining = 4
local searingClapRemaining = 2

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		368990, -- Purging Flames
		369043, -- Infusion
		369110, -- Unstable Embers
		369061, -- Searing Clap
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "PurgingFlames", 368990)
	self:Log("SPELL_AURA_REMOVED", "PurgingFlamesRemoved", 368990)
	self:Log("SPELL_AURA_APPLIED", "InfusionApplied", 369043)
	self:Log("SPELL_AURA_REMOVED", "InfusionRemoved", 369043)
	self:Log("SPELL_CAST_START", "UnstableEmbers", 369110)
	self:Log("SPELL_CAST_START", "SearingClap", 369061)
end

function mod:OnEngage()
	purgingFlamesActive = false
	unstableEmbersRemaining = 2
	searingClapRemaining = 2
	self:SetStage(1)
	self:CDBar(369061, 4.5) -- Searing Clap
	self:CDBar(369110, 12.1) -- Unstable Embers
	-- 35s energy gain + ~3.5s delay
	self:CDBar(368990, 38.5) -- Purging Flames
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 369022 then -- Purging Flames
		-- this is cast when the boss runs to the center, we can clean up extra
		-- timers for skipped abilities a little early
		self:StopBar(369110) -- Unstable Embers
		self:StopBar(369061) -- Searing Clap
	end
end

function mod:PurgingFlames(args)
	-- TODO Emberon won't cast Purging Flames below a certain % HP,
	-- figure out what that % is and fix up timers when it's hit.
	-- he also resumes casting his other abilities which are normally limited
	purgingFlamesActive = true
	self:SetStage(2)
	self:StopBar(args.spellId)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
end

function mod:PurgingFlamesRemoved()
	purgingFlamesActive = false
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
		local addsNeeded = self:Normal() and 3 or 4
		addsKilled = addsKilled + 1
		if addsKilled == addsNeeded then
			unstableEmbersRemaining = 4
			searingClapRemaining = 2
			self:SetStage(1)
			self:Message(368990, "cyan", CL.over:format(self:SpellName(368990))) -- Purging Flames Over
			self:PlaySound(368990, "long")
			self:CDBar(369110, 3.6) -- Unstable Embers
			self:CDBar(369061, 6.2) -- Searing Clap
			-- 35s energy gain + ~2.7s delay
			self:CDBar(368990, 37.7) -- Purging Flames
		else
			self:Message(args.spellId, "green", CL.add_killed:format(addsKilled, addsNeeded))
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:UnstableEmbers(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	unstableEmbersRemaining = unstableEmbersRemaining - 1
	if unstableEmbersRemaining > 0 then
		self:CDBar(args.spellId, 11.7)
	else
		self:StopBar(args.spellId)
	end
end

function mod:SearingClap(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	searingClapRemaining = searingClapRemaining - 1
	if searingClapRemaining > 0 then
		self:CDBar(args.spellId, 23.0)
	else
		self:StopBar(args.spellId)
	end
end
