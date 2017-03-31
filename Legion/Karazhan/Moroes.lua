
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Moroes", 1115, 1837)
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
		{227851, "TANK"}, -- Coat Check
		227872, -- Ghastly Purge

		--[[ Baroness Dorothea Millstripe ]]--
		227545, -- Mana Drain

		--[[ Lady Catriona Von'Indi ]]--
		-- Healing Stream? wasn't in any of my logs

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
		--[] = -14369, -- Lady Catriona Von'Indi
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
	self:Log("SPELL_AURA_APPLIED", "CoatCheck", 227851)
	self:Log("SPELL_CAST_START", "GhastlyPurge", 227872)

	--[[ Baroness Dorothea Millstripe ]]--
	self:Log("SPELL_AURA_APPLIED", "ManaDrain", 227545)

	--[[ Lady Catriona Von'Indi ]]--

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
	wipe(mobCollector)
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
		local guid = UnitGUID(("boss%d"):format(i))
		if guid and not mobCollector[guid] then
			mobCollector[guid] = true
			local mobId = self:MobId(guid)
			if mobId == 114316 then -- Baroness Dorothea Millstripe
				self:CDBar(227545, 9) -- Mana Drain applied
			--elseif mobId == 114317 then -- Lady Catriona Von'Indi
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
	self:Message(args.spellId, "Attention")
	self:Bar(args.spellId, 20.5)
end

function mod:Garrote(args)
	local amount = args.amount or 1
	self:StackMessage(args.spellId, args.destName, amount, "Urgent", "Info")
end

function mod:CoatCheck(args)
	self:Message(args.spellId, "Urgent", "Alarm", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 34)
end

function mod:GhastlyPurge(args)
	self:Message(args.spellId, "Neutral")
end

function mod:ManaDrain(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Warning", nil, nil, self:Dispeller("magic"))
	self:CDBar(args.spellId, 18)
end

function mod:IronWhirlwind(args)
	self:Message(args.spellId, "Attention", "Long")
	self:Bar(args.spellId, 10.5)
end

do
	local prev = 0
	function mod:IronWhirlwindDamage(args)
		local t = GetTime()
		if t-prev > 2 and self:Me(args.destGUID) then
			prev = t
			self:Message(227646, "Personal", "Alarm", CL.underyou:format(args.spellName))
		end
	end
end

function mod:EmpoweredArms(args)
	self:Message(args.spellId, "Important", self:Tank() and "Info", CL.on:format(args.spellName, args.destName))
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(227463)
		end
		self:TargetMessage(227463, player, "Urgent", "Warning")
	end

	function mod:WhirlingEdge(args)
		self:GetBossTarget(printTarget, 1.5, args.sourceGUID)
	end
end

function mod:WillBreaker(args)
	self:Message(args.spellId, "Important", "Long")
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
