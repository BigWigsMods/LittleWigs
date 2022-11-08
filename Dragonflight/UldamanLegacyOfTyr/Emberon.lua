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

local purgingFlameCount = 0

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
	self:Log("SPELL_CAST_START", "PurgingFlames", 368990)
	self:Log("SPELL_AURA_APPLIED", "InfusionApplied", 369043)
	self:Log("SPELL_AURA_REMOVED", "InfusionRemoved", 369043)
	self:Log("SPELL_CAST_SUCCESS", "UnstableEmbers", 369110)
	self:Log("SPELL_CAST_START", "SearingClap", 369061)
end

function mod:OnEngage()
	purgingFlameCount = 0
	self:SetStage(1)
	self:CDBar(369061, 4.6) -- Searing Clap
	self:CDBar(369110, 13.1) -- Unstable Embers
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PurgingFlames(args)
	-- cast at 70% and then 30% health
	local percent = purgingFlameCount == 0 and 70 or 30
	purgingFlameCount = purgingFlameCount + 1
	self:SetStage(2)
	self:Message(args.spellId, "cyan", CL.percent:format(percent, args.spellName))
	self:PlaySound(args.spellId, "long")
	self:StopBar(369110) -- Unstable Embers
	self:StopBar(369061) -- Searing Clap
end

do
	local addsKilled = 0

	function mod:InfusionApplied(args)
		addsKilled = 0
	end

	function mod:InfusionRemoved(args)
		local addsNeeded = self:Normal() and 3 or 4
		addsKilled = addsKilled + 1
		if addsKilled == addsNeeded then
			self:Message(368990, "cyan", CL.over:format(self:SpellName(368990))) -- Purging Flames Over
			self:PlaySound(368990, "long")
			self:SetStage(1)
		else
			self:Message(args.spellId, "green", CL.add_killed:format(addsKilled, addsNeeded))
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:UnstableEmbers(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 12.2)
end

function mod:SearingClap(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 38) -- TODO this is probably way too high
end
