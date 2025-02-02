local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Stormguard Gorren", 2648, 2567)
if not mod then return end
mod:RegisterEnableMob(207205) -- Stormguard Gorren
mod:SetEncounterID(2861)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		424737, -- Chaotic Corruption
		425048, -- Dark Gravity
		424958, -- Crush Reality
		424966, -- Lingering Void
		-- Mythic
		{424797, "ME_ONLY"}, -- Chaotic Vulnerability
	}, {
		[424797] = CL.mythic, -- Chaotic Vulnerability
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ChaoticCorruption", 424737)
	self:Log("SPELL_CAST_START", "DarkGravity", 425048)
	self:Log("SPELL_CAST_START", "CrushReality", 424958)
	self:Log("SPELL_PERIODIC_DAMAGE", "LingeringVoidDamage", 424966)
	self:Log("SPELL_PERIODIC_MISSED", "LingeringVoidDamage", 424966)

	-- Mythic
	self:Log("SPELL_AURA_APPLIED", "ChaoticVulnerabilityApplied", 424797)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ChaoticVulnerabilityApplied", 424797)
end

function mod:OnEngage()
	if isElevenDotOne then
		self:CDBar(424737, 5.8) -- Chaotic Corruption
		self:CDBar(424958, 9.5) -- Crush Reality
		self:CDBar(425048, 30.1) -- Dark Gravity
	else -- XXX remove when 11.1 is live
		self:CDBar(424958, 9.3) -- Crush Reality
		self:CDBar(425048, 15.4) -- Dark Gravity
		self:CDBar(424737, 31.2) -- Chaotic Corruption
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ChaoticCorruption(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 32.7)
	self:PlaySound(args.spellId, "alert")
end

function mod:DarkGravity(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 32.7)
	self:PlaySound(args.spellId, "long")
end

function mod:CrushReality(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 15.7)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:LingeringVoidDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

-- Mythic

function mod:ChaoticVulnerabilityApplied(args)
	self:StackMessage(args.spellId, "cyan", args.destName, args.amount, 1)
	self:PlaySound(args.spellId, "info")
end
