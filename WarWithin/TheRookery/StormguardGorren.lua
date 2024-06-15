if not BigWigsLoader.isBeta then return end
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
		-- Mythic
		{424797, "ME_ONLY"}, -- Chaotic Vulnerability
	}, {
		[424797] = CL.mythic, -- Chaotic Vulnerability
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START") -- XXX no boss frames
	self:Log("SPELL_CAST_START", "ChaoticCorruption", 424737)
	self:Log("SPELL_CAST_START", "DarkGravity", 425048)
	self:Log("SPELL_CAST_START", "CrushReality", 424958)

	-- Mythic
	self:Log("SPELL_AURA_APPLIED", "ChaoticVulnerabilityApplied", 424797)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ChaoticVulnerabilityApplied", 424797)
end

function mod:OnEngage()
	self:CDBar(424958, 8.1) -- Crush Reality
	self:CDBar(425048, 22.7) -- Dark Gravity
	self:CDBar(424737, 33.7) -- Chaotic Corruption
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- XXX no boss frames
function mod:ENCOUNTER_START(_, id)
	if id == self.engageId then
		self:Engage()
	end
end

function mod:ChaoticCorruption(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 32.7)
end

function mod:DarkGravity(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 23.0)
end

function mod:CrushReality(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 23.0)
end

-- Mythic

function mod:ChaoticVulnerabilityApplied(args)
	self:StackMessage(args.spellId, "cyan", args.destName, args.amount, 1)
	self:PlaySound(args.spellId, "info")
	-- TODO needs removed message? confirm if it's possible to overlap
end
