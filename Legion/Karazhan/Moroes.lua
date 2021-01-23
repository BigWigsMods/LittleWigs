
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Moroes", 1651, 1837)
if not mod then return end
mod:RegisterEnableMob(
	114312, -- Moroes
	114316, -- Baroness Dorothea Millstripe
	114317, -- Lady Catriona Von'Indi
	114318, -- Baron Rafe Dreuger
	114319, -- Lady Keira Berrybuck
	114320, -- Lord Robin Daris
	114321  -- Lord Crispin Ference
)
mod.engageId = 1961

--------------------------------------------------------------------------------
-- Locals
--

local mobCollector = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Moroes ]]--
		227736, -- Vanish
		227742, -- Garrote
		{227851, "TANK_HEALER"}, -- Coat Check
		227872, -- Ghastly Purge

		--[[ Baroness Dorothea Millstripe ]]--
		227545, -- Mana Drain

		--[[ Lady Catriona Von'Indi ]]--
		227578, -- Healing Stream

		--[[ Baron Rafe Dreuger ]]--
		227646, -- Iron Whirlwind

		--[[ Lady Keira Berrybuck ]]--
		227616, -- Empowered Arms

		--[[ Lord Robin Daris ]]--
		{227463, "SAY"}, -- Whirling Edge

		--[[ Lord Crispin Ference ]]--
		227672, -- Will Breaker
	},{
		[227736] = -14360, -- Moroes
		[227545] = -14366, -- Baroness Dorothea Millstripe
		[227578] = -14369, -- Lady Catriona Von'Indi
		[227646] = -14372, -- Baron Rafe Dreuger
		[227616] = -14374, -- Lady Keira Berrybuck
		[227463] = -14376, -- Lord Robin Daris
		[227672] = -14378, -- Lord Crispin Ference
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	--[[ Moroes ]]--
	self:Log("SPELL_CAST_START", "Vanish", 227736)
	self:Log("SPELL_AURA_APPLIED", "Garrote", 227742)
	self:Log("SPELL_AURA_APPLIED_DOSE", "Garrote", 227742)
	self:Log("SPELL_AURA_APPLIED", "CoatCheck", 227851) -- the debuff Moroes applies at the start of his cast
	self:Log("SPELL_AURA_APPLIED", "CoatCheckDispellable", 227832) -- the debuff that replaces the previous one 1.5s after, can be dispelled
	self:Log("SPELL_CAST_START", "GhastlyPurge", 227872)

	--[[ Baroness Dorothea Millstripe ]]--
	self:Log("SPELL_CAST_START", "ManaDrain", 227545)

	--[[ Lady Catriona Von'Indi ]]--
	self:Log("SPELL_CAST_START", "HealingStream", 227578)

	--[[ Baron Rafe Dreuger ]]--
	self:Log("SPELL_CAST_START", "IronWhirlwind", 227646)
	self:Log("SPELL_DAMAGE", "IronWhirlwindDamage", 227651)
	self:Log("SPELL_MISSED", "IronWhirlwindDamage", 227651)

	--[[ Lady Keira Berrybuck ]]--
	self:Log("SPELL_AURA_APPLIED", "EmpoweredArms", 227616)

	--[[ Lord Robin Daris ]]--
	self:Log("SPELL_CAST_START", "WhirlingEdge", 227463)

	--[[ Lord Crispin Ference ]]--
	self:Log("SPELL_CAST_START", "WillBreaker", 227672)

	self:Death("GuestDeath",
		114316, -- Baroness Dorothea Millstripe
		114317, -- Lady Catriona Von'Indi
		114318, -- Baron Rafe Dreuger
		114319, -- Lady Keira Berrybuck
		114320, -- Lord Robin Daris
		114321  -- Lord Crispin Ference
	)
end

function mod:OnEngage()
	mobCollector = {}
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	self:CDBar(227736, 7) -- Vanish
	self:CDBar(227851, 30) -- Coat Check
	-- other bars are started in IEEU
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local guid = self:UnitGUID(("boss%d"):format(i))
		if guid and not mobCollector[guid] then
			mobCollector[guid] = true
			local mobId = self:MobId(guid)
			if mobId == 114316 then -- Baroness Dorothea Millstripe
				self:CDBar(227545, 9) -- Mana Drain applied
			--elseif mobId == 114317 then -- Lady Catriona Von'Indi
				-- She casts Healing Stream whenever Moroes drops below 50%
			elseif mobId == 114318 then -- Baron Rafe Dreuger
				self:CDBar(227646, 4.5) -- Iron Whirlwind
			elseif mobId == 114319 then -- Lady Keira Berrybuck
				self:CDBar(227616, 9.5) -- Empowered Arms
			--elseif mobId == 114320 then -- Lord Robin Daris
				-- Whirling Edge is cast instantly
			elseif mobId == 114321 then -- Lord Crispin Ference
				self:Bar(227672, 10.5) -- Will Breaker
			end
		end
	end
end

function mod:Vanish(args)
	self:MessageOld(args.spellId, "yellow")
	self:Bar(args.spellId, 20.5)
end

function mod:Garrote(args)
	local amount = args.amount or 1
	self:StackMessage(args.spellId, args.destName, amount, "orange", "info")
end

function mod:CoatCheck(args)
	if self:Tank() then
		self:MessageOld(args.spellId, "orange", "alarm", CL.casting:format(args.spellName))
	end
	self:Bar(args.spellId, 34)
end

function mod:CoatCheckDispellable(args)
	if not self:Tank() then
		self:TargetMessageOld(227851, args.destName, "orange", "alarm", nil, nil, true)
	end
end

function mod:GhastlyPurge(args)
	self:MessageOld(args.spellId, "cyan")
end

function mod:ManaDrain(args)
	self:MessageOld(args.spellId, "orange", self:Interrupter() and "warning", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 18)
end

function mod:HealingStream(args)
	self:MessageOld(args.spellId, "red", self:Interrupter() and "warning", CL.casting:format(args.spellName))
end

function mod:IronWhirlwind(args)
	self:MessageOld(args.spellId, "yellow", "long")
	self:Bar(args.spellId, 10.5)
end

do
	local prev = 0
	function mod:IronWhirlwindDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:MessageOld(227646, "blue", "alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end

function mod:EmpoweredArms(args)
	self:MessageOld(args.spellId, "red", self:Tank() and "info", CL.on:format(args.spellName, args.destName))
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(227463)
		end
		self:TargetMessageOld(227463, player, "orange", "warning")
	end

	function mod:WhirlingEdge(args)
		self:GetBossTarget(printTarget, 1.5, args.sourceGUID)
	end
end

function mod:WillBreaker(args)
	self:MessageOld(args.spellId, "red", "long")
	self:Bar(args.spellId, 10.9)
end

function mod:GuestDeath(args)
	local mobId = self:MobId(args.destGUID)
	if mobId == 114316 then -- Baroness Dorothea Millstripe
		self:StopBar(227545) -- Mana Drain
	--elseif mobId == 114317 then -- Lady Catriona Von'Indi
	elseif mobId == 114318 then -- Baron Rafe Dreuger
		self:StopBar(227646) -- Iron Whirlwind
	elseif mobId == 114319 then -- Lady Keira Berrybuck
		self:StopBar(227616) -- Empowered Arms
	--elseif mobId == 114320 then -- Lord Robin Daris
		-- Whirling Edge is cast instantly
	elseif mobId == 114321 then -- Lord Crispin Ference
		self:StopBar(227672) -- Will Breaker
	end
end
