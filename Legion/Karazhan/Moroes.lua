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
mod:SetEncounterID(1961)
mod:SetRespawnTime(15)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.cc = "Crowd Control"
	L.cc_desc = "Timers and alerts for crowd control on the dinner guests."
	L.cc_icon = "ability_hunter_traplauncher"
end

--------------------------------------------------------------------------------
-- Locals
--

local validCrowdControls = {227909, 9484, 115078, 3355, 20066, 10326} -- Ghost Trap, Shackle Undead, Paralysis, Freezing Trap, Repentance, Turn Evil
local mobCollector = {}
local guestDeaths = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"cc",
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
	}, {
		["cc"] = CL.general,
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
	--[[ Moroes ]]--
	self:Log("SPELL_CAST_START", "Vanish", 227736)
	self:Log("SPELL_AURA_APPLIED", "Garrote", 227742)
	self:Log("SPELL_AURA_APPLIED_DOSE", "Garrote", 227742)
	self:Log("SPELL_AURA_APPLIED", "CoatCheck", 227851) -- the debuff Moroes applies to himself at the start of his cast
	self:Log("SPELL_AURA_APPLIED", "CoatCheckDispellable", 227832) -- this debuff on tank replaces the previous one 1.5s after, can be dispelled
	self:Log("SPELL_CAST_SUCCESS", "GhastlyPurge", 227872)

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

	-- CC tracking
	self:Log("SPELL_AURA_APPLIED", "CrowdControlApplied", unpack(validCrowdControls))
	self:Log("SPELL_AURA_REFRESH", "CrowdControlApplied", unpack(validCrowdControls))
	self:Log("SPELL_AURA_REMOVED", "CrowdControlRemoved", unpack(validCrowdControls))

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
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	mobCollector = {}
	guestDeaths = 0
	self:CDBar(227736, 7) -- Vanish
	self:CDBar(227851, 30) -- Coat Check
	-- other bars are started in IEEU
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function scanCrowdControl(unitId)
		for i = 1, #validCrowdControls do
			local _, _, _, expires = mod:UnitDebuff(unitId, validCrowdControls[i])
			if expires and expires > 0 then
				local duration = expires - GetTime()
				mod:TargetBar("cc", duration, mod:UnitName(unitId), validCrowdControls[i])
			end
		end
	end

	function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
		for i = 1, 5 do
			local unitId = ("boss%d"):format(i)
			local guid = self:UnitGUID(unitId)
			if guid and not mobCollector[guid] then
				mobCollector[guid] = true
				local mobId = self:MobId(guid)
				if mobId == 114312 then -- Moroes
					self:RegisterUnitEvent("UNIT_HEALTH", nil, unitId)
				else
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
					scanCrowdControl(unitId)
				end
			end
		end
	end
end

function mod:Vanish(args)
	self:Message(args.spellId, "yellow")
	self:Bar(args.spellId, 20.5)
end

function mod:Garrote(args)
	self:StackMessage(args.spellId, "orange", args.destName, args.amount, 0)
	self:PlaySound(args.spellId, "info")
end

function mod:CoatCheck(args)
	if self:Tank() then
		self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alarm")
	end
	self:Bar(args.spellId, 34)
end

function mod:CoatCheckDispellable(args)
	if self:Dispeller("magic") then
		self:TargetMessage(227851, "orange", args.destName)
		self:PlaySound(227851, "warning")
	end
end

function mod:UNIT_HEALTH(event, unit)
	if self:GetHealth(unit) < 65 or guestDeaths == 4 then
		self:UnregisterUnitEvent(event, unit)
		if guestDeaths < 4 then
			self:Message(227872, "yellow", CL.soon:format(self:SpellName(227872))) -- Ghastly Purge Soon
			self:PlaySound(227872, "info")
		end
	end
end

function mod:GhastlyPurge(args)
	if guestDeaths < 4 then
		self:Message(args.spellId, "cyan")
	end
end

function mod:ManaDrain(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	if self:Interrupter() then
		self:PlaySound(args.spellId, "warning")
	end
	self:CDBar(args.spellId, 17)
end

function mod:HealingStream(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	if self:Interrupter() then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:IronWhirlwind(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
end

do
	local prev = 0
	function mod:IronWhirlwindDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:PersonalMessage(227646, "near")
				self:PlaySound(227646, "underyou")
			end
		end
	end
end

function mod:EmpoweredArms(args)
	self:Message(args.spellId, "red", CL.on:format(args.spellName, args.destName))
	if self:Tank() then
		self:PlaySound(args.spellId, "info")
	end
	self:CDBar(args.spellId, 19.5)
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(227463, nil, nil, "Whirling Edge")
		end
		self:TargetMessage(227463, "orange", player)
		self:PlaySound(227463, "warning", nil, player)
	end

	function mod:WhirlingEdge(args)
		self:GetUnitTarget(printTarget, 1.5, args.sourceGUID)
	end
end

function mod:WillBreaker(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 10.9)
end

function mod:CrowdControlApplied(args)
	local bossId = self:GetBossId(args.destGUID)
	if bossId then
		local _, _, duration = self:UnitDebuff(bossId, args.spellId)
		if duration then
			self:TargetBar("cc", duration, args.destName, args.spellId)
		end
	end
end

function mod:CrowdControlRemoved(args)
	if self:IsEngaged() then
		self:Message("cc", "cyan", CL.removed_from:format(args.spellName, args.destName), args.spellId)
		self:PlaySound("cc", "info")
		self:StopBar(args.spellId, args.destName)
	end
end

function mod:GuestDeath(args)
	guestDeaths = guestDeaths + 1
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
