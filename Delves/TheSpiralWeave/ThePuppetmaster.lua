--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Puppetmaster", 2688)
if not mod then return end
mod:RegisterEnableMob(
	220507, -- The Puppetmaster? (First Stage)
	220508, -- The Puppetmaster? (Second Stage)
	220509, -- The Puppetmaster? (Third Stage)
	220510 -- The Puppetmaster? (Final Stage)
)
mod:SetEncounterID(3006) -- only for final stage
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.the_puppetmaster = "The Puppetmaster"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.the_puppetmaster
	self:SetSpellRename(450197, CL.charge) -- Skitter Charge (Charge)
	self:SetSpellRename(450546, CL.shield) -- Webbed Aegis (Shield)
	self:SetSpellRename(450509, CL.frontal_cone) -- Wide Swipe (Frontal Cone)
	self:SetSpellRename(450714, CL.frontal_cone) -- Jagged Barbs (Frontal Cone)
end

function mod:GetOptions()
	return {
		-- The Puppetmaster? (First Stage)
		451913, -- Grimweave Orb
		-- The Puppetmaster? (Second Stage)
		450197, -- Skitter Charge
		-- The Puppetmaster? (Third Stage)
		{450546, "DISPEL"}, -- Webbed Aegis
		450509, -- Wide Swipe
		-- The Puppetmaster? (Final Stage)
		450714, -- Jagged Barbs
		448663, -- Stinging Swarm
	}, {
		[451913] = CL.stage:format(1),
		[450197] = CL.stage:format(2),
		[450546] = CL.stage:format(3),
		[450714] = CL.stage:format(4),
	}, {
		[450197] = CL.charge, -- Skitter Charge (Charge)
		[450546] = CL.shield, -- Webbed Aegis (Shield)
		[450509] = CL.frontal_cone, -- Wide Swipe (Frontal Cone)
		[450714] = CL.frontal_cone, -- Jagged Barbs (Frontal Cone)
	}
end

function mod:OnBossEnable()
	-- The Puppetmaster? (First Stage)
	self:Log("SPELL_CAST_START", "GrimweaveOrb", 451913)
	self:Log("SPELL_AURA_APPLIED", "GrimweaveOrbDamage", 452041)
	self:Log("SPELL_AURA_REFRESH", "GrimweaveOrbDamage", 452041)
	self:Death("Stage1Death", 220507)

	-- The Puppetmaster? (Second Stage)
	self:Log("SPELL_CAST_START", "SkitterCharge", 450197)

	-- The Puppetmaster? (Third Stage)
	self:Log("SPELL_CAST_START", "WebbedAegis", 450546)
	self:Log("SPELL_AURA_APPLIED", "WebbedAegisApplied", 450546)
	self:Log("SPELL_CAST_START", "WideSwipe", 450509)

	-- The Puppetmaster? (Final Stage)
	self:Log("SPELL_CAST_START", "JaggedBarbs", 450714)
	self:Log("SPELL_CAST_START", "StingingSwarm", 448663)
end

function mod:OnEngage()
	-- engage only fires for the final stage
	self:CDBar(450714, 3.6, CL.frontal_cone) -- Jagged Barbs
	self:CDBar(448663, 9.7) -- Stinging Swarm
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- The Puppetmaster? (First Stage)

do
	local timer

	function mod:GrimweaveOrb(args)
		-- this spellId can also be cast by trash
		if self:MobId(args.sourceGUID) == 220507 then -- The Puppetmaster?
			if timer then
				self:CancelTimer(timer)
			end
			self:Message(args.spellId, "orange")
			self:CDBar(args.spellId, 23.0)
			timer = self:ScheduleTimer("Stage1Death", 30)
			self:PlaySound(args.spellId, "alarm")
		end
	end

	do
		local prev = 0
		function mod:GrimweaveOrbDamage(args)
			-- this spellId can also be cast by trash
			if self:MobId(args.sourceGUID) == 220507 then -- The Puppetmaster?
				if self:Me(args.destGUID) and args.time - prev > 1.5 then
					prev = args.time
					self:PersonalMessage(451913, "near")
					self:PlaySound(451913, "underyou")
				end
			end
		end
	end

	function mod:Stage1Death()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(451913) -- Grimweave Orb
	end
end

-- The Puppetmaster? (Second Stage)

do
	local prev = 0
	function mod:SkitterCharge(args)
		-- this spellId can also be cast by trash
		if args.time - prev > 2 and self:MobId(args.sourceGUID) == 220508 then -- The Puppetmaster? (Second Stage)
			prev = args.time
			self:Message(args.spellId, "yellow", CL.charge)
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- The Puppetmaster? (Third Stage)

do
	local prev = 0
	function mod:WebbedAegis(args)
		-- this spellId can also be cast by trash
		if args.time - prev > 2 and self:MobId(args.sourceGUID) == 220509 then -- The Puppetmaster? (Third Stage)
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(CL.shield))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:WebbedAegisApplied(args)
		-- this spellId can also be cast by trash
		if self:Dispeller("magic", true, args.spellId) and self:MobId(args.sourceGUID) == 220509 then -- The Puppetmaster? (Third Stage)
			if self:Player(args.destFlags) then
				self:TargetMessage(args.spellId, "green", args.destName, CL.shield)
			elseif args.time - prev > 2 then
				prev = args.time
				self:Message(args.spellId, "red", CL.other:format(CL.shield, args.destName))
				self:PlaySound(args.spellId, "alert")
			end
		end
	end
end

do
	local prev = 0
	function mod:WideSwipe(args)
		-- this spellId can also be cast by trash
		if self:MobId(args.sourceGUID) == 220509 then -- The Puppetmaster? (Third Stage)
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:Message(args.spellId, "purple", CL.frontal_cone)
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end

-- The Puppetmaster? (Final Stage)

function mod:JaggedBarbs(args)
	-- this spellId can also be cast by trash
	if self:MobId(args.sourceGUID) == 220510 then -- The Puppetmaster? (Final Stage)
		self:Message(args.spellId, "orange", CL.frontal_cone)
		self:CDBar(args.spellId, 12.1, CL.frontal_cone)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:StingingSwarm(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 31.6)
	self:PlaySound(args.spellId, "warning")
end
