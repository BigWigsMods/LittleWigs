--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gorechop", 2293, 2401)
if not mod then return end
mod:RegisterEnableMob(162317) -- Gorechop
mod:SetEncounterID(2365)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local meatHooksCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		322795, -- Meat Hooks
		{323515, "TANK_HEALER"}, -- Hateful Strike
		323750, -- Vile Gas
		-- Mythic
		318406, -- Tenderizing Smash
		-- Oozing Leftovers
		321447, -- Coagulating Ooze
	}, {
		[318406] = "mythic",
		[321447] = -21779, -- Oozing Leftovers
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "MeatHooks", 322795)
	self:Log("SPELL_CAST_START", "HatefulStrike", 323515)
	self:Log("SPELL_PERIODIC_DAMAGE", "VileGasDamage", 323750)
	self:Log("SPELL_PERIODIC_MISSED", "VileGasDamage", 323750)
	self:Log("SPELL_CAST_START", "TenderizingSmash", 318406)

	-- Oozing Leftovers
	self:Log("SPELL_PERIODIC_DAMAGE", "CoagulatingOozeDamage", 323130)
	self:Log("SPELL_PERIODIC_MISSED", "CoagulatingOozeDamage", 323130)
end

function mod:OnEngage()
	meatHooksCount = 1
	self:CDBar(323515, 2.6) -- Hateful Strike
	self:CDBar(322795, 10.2) -- Meat Hooks, 5.2 sec until the first cast
	if self:Mythic() then
		self:CDBar(318406, 13.1) -- Tenderizing Smash
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function warnMeatHooks()
		mod:Message(322795, "yellow")
		meatHooksCount = meatHooksCount + 1
		mod:CDBar(322795, 20.6)
		mod:PlaySound(322795, "long")
	end

	function mod:MeatHooks(args)
		-- The boss casts Meat Hooks 5 seconds before anything actually happens
		self:ScheduleTimer(warnMeatHooks, 5)
		-- correct the Meat Hooks timer
		if meatHooksCount == 1 then
			self:CDBar(args.spellId, {5, 10.2})
		else
			self:CDBar(args.spellId, {5, 20.6})
		end
	end
end

function mod:HatefulStrike(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 14.6)
end

do
	local prev = 0
	function mod:VileGasDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:TenderizingSmash(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 19.4)
	self:PlaySound(args.spellId, "alarm")
end

-- Oozing Leftovers

do
	local prev = 0
	function mod:CoagulatingOozeDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(321447, "underyou")
			self:PlaySound(321447, "underyou")
		end
	end
end
