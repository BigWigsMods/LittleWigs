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
		-- TODO Abundance
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

	-- Hungry Lasher
	self:Log("SPELL_AURA_APPLIED_DOSE", "LasherToxinApplied", 389033)

	-- Ancient Branch
	self:Log("SPELL_CAST_START", "HealingTouch", 396640)
end

function mod:OnEngage()
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
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 29.1) -- TODO 13.1, 29.1, 20.6 pattern consistent?
end

function mod:BurstForth(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	-- cast at 100 energy, 45s energy gain + 2s cast
	self:CDBar(args.spellId, 47)
end

function mod:BranchOut(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	-- TODO unknown CD
end

function mod:Barkbreaker(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 29.1) -- TODO 4.6, 29.1, 19.4 pattern consistent?
end

-- Hungry Lasher

do
	local prev = 0
	function mod:LasherToxinApplied(args)
		if args.amount >= 3 and self:Dispeller("poison", nil, args.spellId) then
			-- this can sometimes apply rapidly or to more than one person, so add a short throttle.
			local t = args.time
			if t - prev > 1 then
				prev = t
				self:StackMessage(args.spellId, "red", args.destName, args.amount, 5)
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
