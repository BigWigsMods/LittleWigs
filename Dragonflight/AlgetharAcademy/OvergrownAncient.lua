if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Overgrown Ancient", 2526, 2512)
if not mod then return end
mod:RegisterEnableMob(196482) -- Overgrown Ancient
mod:SetEncounterID(2563)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local germinateCount = 0
local barkbreakerCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Overgrown Ancient
		388796, -- Germinate
		388923, -- Burst Forth
		388623, -- Branch Out
		{388544, "TANK_HEALER"}, -- Barkbreaker
		-- Hungry Lasher
		{389033, "DISPEL"}, -- Lasher Toxin (Mythic only)
		-- Ancient Branch
		396640, -- Healing Touch
		396721, -- Abundance
	}, {
		[388796] = self.displayName,
		[389033] = -25730, -- Hungry Lasher
		[396640] = -25688, -- Ancient Branch
	}
end

function mod:OnBossEnable()
	-- Overgrown Ancient
	self:Log("SPELL_CAST_SUCCESS", "Germinate", 388796)
	self:Log("SPELL_CAST_START", "BurstForth", 388923)
	self:Log("SPELL_CAST_START", "BranchOut", 388623)
	self:Log("SPELL_CAST_START", "Barkbreaker", 388544)
	self:Log("SPELL_AURA_APPLIED", "BarkbreakerApplied", 388544)

	-- Hungry Lasher
	self:Log("SPELL_AURA_APPLIED_DOSE", "LasherToxinApplied", 389033)

	-- Ancient Branch
	self:Log("SPELL_CAST_START", "HealingTouch", 396640)
	self:Death("AncientBranchDeath", 196548)
end

function mod:OnEngage()
	germinateCount = 0
	barkbreakerCount = 0
	self:CDBar(388544, 4.6) -- Barkbreaker
	self:Bar(388796, 13.3) -- Germinate
	self:Bar(388623, 30.3) -- Branch Out
	self:Bar(388923, 47.4) -- Burst Forth
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Overgrown Ancient

function mod:Germinate(args)
	germinateCount = germinateCount + 1
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	-- 13.3, 29.1, 20.6, 29.1, 20.6 pattern
	self:Bar(args.spellId, germinateCount % 2 == 0 and 20.6 or 29.1)
end

function mod:BurstForth(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	-- cast at 100 energy, 2s cast + 45s energy gain + delay
	self:Bar(args.spellId, 49.8)
end

function mod:BranchOut(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 49.8)
end

function mod:Barkbreaker(args)
	barkbreakerCount = barkbreakerCount + 1
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	-- 4.6, 29.2, 19.5, 29.2, 20.6 pattern
	self:CDBar(args.spellId, barkbreakerCount % 2 == 0 and 19.5 or 29.2)
end

function mod:BarkbreakerApplied(args)
	self:TargetBar(args.spellId, 9, args.destName)
end

-- Hungry Lasher

do
	local prev = 0
	function mod:LasherToxinApplied(args)
		if args.amount >= 5 and args.amount % 5 == 0 and self:Dispeller("poison", nil, args.spellId) then
			-- this can sometimes apply rapidly or to more than one person, so add a short throttle.
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:StackMessage(args.spellId, "red", args.destName, args.amount, 10)
				self:PlaySound(args.spellId, "alert", nil, args.destName)
			end
		end
	end
end

-- Ancient Branch

function mod:HealingTouch(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:AncientBranchDeath(args)
	self:Message(396721, "green") -- Abundance
	self:PlaySound(396721, "info")
	self:Bar(396721, 3)
end
