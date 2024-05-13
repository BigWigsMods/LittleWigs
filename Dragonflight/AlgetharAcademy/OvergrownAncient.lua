--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Overgrown Ancient", 2526, 2512)
if not mod then return end
mod:RegisterEnableMob(196482) -- Overgrown Ancient
mod:SetEncounterID(2563)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "achievement_dungeon_dragonacademy"
end

--------------------------------------------------------------------------------
-- Locals
--

local germinateCount = 0
local burstForthCount = 0
local barkbreakerCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"warmup",
		-- Overgrown Ancient
		388796, -- Germinate
		388923, -- Burst Forth
		388623, -- Branch Out
		{388544, "TANK_HEALER"}, -- Barkbreaker
		-- Hungry Lasher
		{389033, "DISPEL"}, -- Lasher Toxin (Mythic only)
		-- Ancient Branch
		396640, -- Healing Touch
		{396721, "CASTBAR"}, -- Abundance
	}, {
		["warmup"] = CL.general,
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

	-- Hungry Lasher
	self:Log("SPELL_AURA_APPLIED_DOSE", "LasherToxinApplied", 389033)

	-- Ancient Branch
	self:Log("SPELL_CAST_START", "HealingTouch", 396640)
	self:Death("AncientBranchDeath", 196548)
end

function mod:OnEngage()
	germinateCount = 0
	burstForthCount = 0
	barkbreakerCount = 0
	self:StopBar(CL.active) -- Warmup
	self:CDBar(388544, 9.7) -- Barkbreaker
	self:CDBar(388796, 18.2) -- Germinate
	self:CDBar(388623, 30.4) -- Branch Out
	self:CDBar(388923, 56.4, CL.count:format(self:SpellName(388923), 1)) -- Burst Forth (1)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- General

function mod:Warmup() -- called from trash module
	self:Bar("warmup", 16.8, CL.active, L.warmup_icon)
end

-- Overgrown Ancient

function mod:Germinate(args)
	germinateCount = germinateCount + 1
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	-- 18.3, 34.0, 25.5, 34.0, 25.5 pattern
	self:CDBar(args.spellId, germinateCount % 2 == 0 and 25.5 or 34)
end

function mod:BurstForth(args)
	burstForthCount = burstForthCount + 1
	local burstForthMessage = CL.count:format(args.spellName, burstForthCount)
	self:StopBar(burstForthMessage)
	self:Message(args.spellId, "orange", burstForthMessage)
	self:PlaySound(args.spellId, "long")
	-- cast at 100 energy, 2s cast + 54s energy gain + delay
	self:CDBar(args.spellId, 59.5, CL.count:format(args.spellName, burstForthCount + 1))
end

function mod:BranchOut(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 59.5)
end

function mod:Barkbreaker(args)
	barkbreakerCount = barkbreakerCount + 1
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	-- 10.7, 29.1, 30.4, 29.1, 30.4, 29.1
	self:CDBar(args.spellId, barkbreakerCount % 2 == 0 and 30.4 or 29.1)
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
	if self:Mythic() then
		self:Message(396721, "green") -- Abundance
		self:PlaySound(396721, "info")
		self:CastBar(396721, 3.5)
	end
end
