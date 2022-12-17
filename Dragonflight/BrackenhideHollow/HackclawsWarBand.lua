--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hackclaw's War-Band", 2520, 2471)
if not mod then return end
mod:RegisterEnableMob(
	186122, -- Rira Hackclaw
	186124, -- Gashtooth
	186125  -- Tricktotem
)
mod:SetEncounterID(2570)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Rira Hackclaw
		{381444, "SAY", "SAY_COUNTDOWN"}, -- Savage Charge
		377827, -- Bladestorm
		-- Gashtooth
		381694, -- Decayed Senses
		378029, -- Gash Frenzy
		-- TODO Marked for Butchery (Mythic-only)
		-- Tricktotem
		381470, -- Hextrick Totem
		377950, -- Greater Healing Rapids
		377965, -- Bloodfrenzy
	}, {
		[381444] = -24732, -- Rira Hackclaw
		[381694] = -24733, -- Gashtooth
		[381470] = -24734, -- Tricktotem
	}
end

function mod:OnBossEnable()
	-- Rira Hackclaw
	self:Log("SPELL_AURA_APPLIED", "SavageChargeApplied", 381461)
	self:Log("SPELL_AURA_REMOVED", "SavageChargeRemoved", 381461)
	self:Log("SPELL_AURA_APPLIED", "BladestormStarting", 381835)
	self:Log("SPELL_AURA_APPLIED", "BladestormFixateApplied", 377844)
	self:Log("SPELL_AURA_REMOVED", "BladestormFixateRemoved", 377844)
	self:Death("RiraHackclawDeath", 186122)

	-- Gashtooth
	self:Log("SPELL_CAST_START", "DecayedSenses", 381694)
	self:Log("SPELL_AURA_APPLIED", "DecayedSensesApplied", 381379)
	self:Log("SPELL_AURA_REMOVED", "DecayedSensesRemoved", 381379)
	self:Log("SPELL_CAST_START", "GashFrenzy", 378029)
	self:Death("GashtoothDeath", 186124)

	-- Tricktotem
	self:Log("SPELL_CAST_START", "HextrickTotem", 381470)
	self:Log("SPELL_CAST_START", "GreaterHealingRapids", 377950)
	self:Log("SPELL_CAST_SUCCESS", "Bloodfrenzy", 377965)
	self:Death("TricktotemDeath", 186125)
end

function mod:OnEngage()
	self:Bar(378029, 3.6) -- Gash Frenzy
	self:Bar(377950, 12.2) -- Greater Healing Rapids
	self:Bar(377827, 20.3) -- Bladestorm
	self:Bar(381470, 45.8) -- Hextrick Totem
	self:Bar(381694, 46.8) -- Decayed Senses
	self:Bar(381444, 49.3) -- Savage Charge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Rira Hackclaw

function mod:SavageChargeApplied(args)
	-- charge debuff applies to a random player, boss starts 10 second cast
	-- tank must intercept or target must immune
	local onMe = self:Me(args.destGUID)
	self:TargetMessage(381444, "red", args.destName)
	self:TargetBar(381444, 10, args.destName)
	if self:Tank() or onMe then
		self:PlaySound(381444, "warning", nil, args.destName)
		if onMe then
			self:Say(381444)
			self:SayCountdown(381444, 10)
		end
	else
		self:PlaySound(381444, "alert", nil, args.destName)
	end
	-- TODO unknown CD
end

function mod:SavageChargeRemoved(args)
	self:StopBar(381444, args.destName)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(381444)
	end
end

-- example Bladestorm sequence:
-- 0s SPELL_CAST_START 381834 (3s cast)
-- 0s SPELL_AURA_APPLIED 381835 (on player)
-- 3s SPELL_CAST_SUCCESS 381834
-- 3s SPELL_AURA_REMOVED 381835 (from player)
-- 3s UNIT_SPELLCAST_CHANNEL_START 377844 (5s channel)
-- 3s SPELL_AURA_APPLIED 377844 (on player)
-- 3s SPELL_DAMAGE 377830
-- 8s SPELL_AURA_REMOVED 377844 (from player)
-- 8s SPELL_CAST_START 377844 (1s cast)
-- 9s UNIT_SPELLCAST_CHANNEL_START 377844 (4s channel)
-- 9s SPELL_AURA_APPLIED 377844 (on player)
-- gains Bloodfrenzy (40% haste)
-- 13s SPELL_AURA_REMOVED 377844 (from player)
-- 13s SPELL_CAST_START 377844 (.714s cast)
-- 13.714s UNIT_SPELLCAST_CHANNEL_START 377844 (4s channel)
-- 13.714s SPELL_AURA_APPLIED 377844 (on player)
do
	local firstChannel = true

	function mod:BladestormStarting(args)
		firstChannel = true
		-- fixate debuff applies to a random player, boss starts 3 second cast
		self:TargetMessage(377827, "red", args.destName, CL.casting:format(args.spellName))
		self:PlaySound(377827, "long", nil, args.destName)
		-- TODO unknown CD
	end

	function mod:BladestormFixateApplied(args)
		-- fixate debuff applies to a random player, boss starts 5 or 4 second channel
		self:TargetMessage(377827, "red", args.destName)
		self:PlaySound(377827, "alarm", nil, args.destName)
		if firstChannel then
			firstChannel = false
			self:TargetBar(377827, 5, args.destName)
		else
			self:TargetBar(377827, 4, args.destName)
		end
	end
end

function mod:BladestormFixateRemoved(args)
	self:StopBar(377827, args.destName) -- Bladestorm
end

function mod:RiraHackclawDeath(args)
	self:StopBar(381444) -- Savage Charge
	self:StopBar(377827) -- Bladestorm
end

-- Gashtooth

function mod:DecayedSenses(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	-- TODO unknown CD
end

function mod:DecayedSensesApplied(args)
	if self:Dispeller("magic") then
		self:TargetMessage(381694, "red", args.destName)
		self:PlaySound(381694, "warning", nil, args.destName)
	end
end

function mod:DecayedSensesRemoved(args)
	self:Message(381694, "green", CL.removed:format(args.spellName))
	self:PlaySound(381694, "info")
end

function mod:GashFrenzy(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 59)
end

function mod:GashtoothDeath(args)
	self:StopBar(381694) -- Decayed Senses
	self:StopBar(378029) -- Gash Frenzy
end

-- Tricktotem

function mod:HextrickTotem(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	-- TODO unknown CD
end

function mod:GreaterHealingRapids(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
	self:Bar(args.spellId, 22.7)
end

function mod:Bloodfrenzy(args)
	self:Message(args.spellId, "orange", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end

function mod:TricktotemDeath(args)
	self:StopBar(381470) -- Hextrick Totem
	self:StopBar(377950) -- Greater Healing Rapids
end
