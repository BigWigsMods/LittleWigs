--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Lost Dwarves", 2451, 2475)
if not mod then return end
mod:RegisterEnableMob(
	184581, -- Baelog
	184582, -- Eric "The Swift"
	184580  -- Olaf
)
mod:SetEncounterID(2555)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Baelog
		369573, -- Heavy Arrow
		369563, -- Wild Cleave
		-- Eric "The Swift"
		369791, -- Skullcracker
		-- Olaf
		{369677, "SAY"}, -- Ricocheting Shield
		369602, -- Defensive Bulwark
		-- Longboat Raid!
		375924, -- Longboat Raid!
		{375286, "DISPEL"}, -- Searing Cannonfire
	}, {
		[369573] = -24740, -- Baelog
		[369791] = -24781, -- Eric "The Swift"
		[369677] = -24782, -- Olaf
		[375924] = -24783, -- Longboat Raid!
	}
end

function mod:OnBossEnable()
	-- Baelog
	self:Log("SPELL_CAST_START", "HeavyArrow", 369573)
	self:Log("SPELL_CAST_START", "WildCleave", 369563)

	-- Eric "The Swift"
	self:Log("SPELL_CAST_START", "Skullcracker", 369791)

	-- Olaf
	self:Log("SPELL_CAST_START", "RicochetingShield", 369677)
	self:Log("SPELL_AURA_APPLIED", "DefensiveBulwark", 369602)

	-- Longboat Raid!
	self:Log("SPELL_CAST_START", "LongboatRaid", 375924)
	self:Log("SPELL_AURA_APPLIED", "SearingCannonfireApplied", 375286)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SearingCannonfireApplied", 375286)
end

function mod:OnEngage()
	self:CDBar(369791, 6.1) -- Skullcracker
	self:CDBar(369563, 8.5) -- Wild Cleave
	self:Bar(369677, 12.1) -- Ricocheting Shield
	self:Bar(369602, 17.2) -- Defensive Bulwark
	self:CDBar(369573, 20.6) -- Heavy Arrow
	self:Bar(375924, 24.8) -- Longboat Raid
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Baelog

function mod:HeavyArrow(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 20.7)
end

function mod:WildCleave(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 17)
end

-- Eric "The Swift"

function mod:Skullcracker(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 26.7)
end

-- Olaf

do
	local function printTarget(self, name, guid)
		self:TargetMessage(369677, "yellow", name)
		self:PlaySound(369677, "alert", nil, name)
		if self:Me(guid) then
			self:Say(369677)
		end
	end

	function mod:RicochetingShield(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 17)
	end
end

function mod:DefensiveBulwark(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 34)
end

-- Longboat Raid!

do
	local prev = 0
	function mod:LongboatRaid(args)
		-- throttle because all 3 bosses cast this, usually around the same time
		local t = args.time
		if t - prev > 6 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "long")
			-- 50s energy gain + 2s cast
			self:CDBar(args.spellId, 52.1)
		end
	end
end

function mod:SearingCannonfireApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:StackMessage(args.spellId, "red", args.destName, args.amount, 1)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end
