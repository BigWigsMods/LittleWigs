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
-- Locals
--

local gashFrenzyCount = 1
local markedForButcheryCount = 1
local greaterHealingRapidsCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

local savageChargeMarker = mod:AddMarkerOption(true, "player", 1, 381444, 1) -- Savage Charge
local totemMarker = mod:AddMarkerOption(true, "npc", 8, 381470, 8) -- Hextrick Totem
function mod:GetOptions()
	return {
		-- Rira Hackclaw
		{381444, "SAY"}, -- Savage Charge
		savageChargeMarker,
		{377827, "SAY"}, -- Bladestorm
		-- Gashtooth
		381694, -- Decayed Senses
		378029, -- Gash Frenzy
		{378208, "ME_ONLY"}, -- Marked for Butchery (Mythic-only)
		-- Tricktotem
		381470, -- Hextrick Totem
		totemMarker,
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
	self:Log("SPELL_CAST_SUCCESS", "SavageChargeRemoved", 381416)
	self:Log("SPELL_AURA_APPLIED", "BladestormStarting", 381835)
	self:Log("SPELL_AURA_APPLIED", "BladestormFixateApplied", 377844)
	self:Death("RiraHackclawDeath", 186122)

	-- Gashtooth
	self:Log("SPELL_CAST_START", "DecayedSenses", 381694)
	self:Log("SPELL_AURA_APPLIED", "DecayedSensesApplied", 381379)
	self:Log("SPELL_AURA_REMOVED", "DecayedSensesRemoved", 381379)
	self:Log("SPELL_CAST_START", "GashFrenzy", 378029)
	self:Log("SPELL_CAST_START", "MarkedForButchery", 378208)
	self:Death("GashtoothDeath", 186124)

	-- Tricktotem
	self:Log("SPELL_CAST_START", "HextrickTotem", 381470)
	self:Log("SPELL_SUMMON", "HextrickTotemSummon", 381470)
	self:Log("SPELL_CAST_START", "GreaterHealingRapids", 377950)
	self:Log("SPELL_CAST_SUCCESS", "Bloodfrenzy", 377965)
	self:Death("TricktotemDeath", 186125)
end

function mod:OnEngage()
	gashFrenzyCount = 1
	markedForButcheryCount = 1
	greaterHealingRapidsCount = 1
	self:CDBar(378029, 3.5, CL.count:format(self:SpellName(378029), gashFrenzyCount)) -- Gash Frenzy
	self:CDBar(377950, 12.1) -- Greater Healing Rapids
	if self:Mythic() then
		self:CDBar(378208, 13.3, CL.count:format(self:SpellName(378208), markedForButcheryCount)) -- Marked For Butchery
	end
	self:CDBar(377827, 20.3) -- Bladestorm
	if not self:Solo() then
		self:CDBar(381470, 45.8) -- Hextrick Totem
	end
	self:CDBar(381694, 46.8) -- Decayed Senses
	self:CDBar(381444, 49.6) -- Savage Charge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Rira Hackclaw

function mod:SavageChargeApplied(args)
	-- charge debuff applies to a random player, boss starts variable length cast
	-- tank must intercept or target must immune
	local onMe = self:Me(args.destGUID)
	self:TargetMessage(381444, "red", args.destName)
	self:CustomIcon(savageChargeMarker, args.destName, 1)
	if self:Tank() or onMe then
		self:PlaySound(381444, "warning", nil, args.destName)
		if onMe then
			self:Say(381444, nil, nil, "Savage Charge")
		end
	else
		self:PlaySound(381444, "alert", nil, args.destName)
	end
	self:CDBar(381444, 59.5)
end

function mod:SavageChargeRemoved(args)
	self:CustomIcon(savageChargeMarker, args.destName)
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
-- gains Bloodfrenzy (30% haste)
-- 13s SPELL_AURA_REMOVED 377844 (from player)
-- 13s SPELL_CAST_START 377844 (.714s cast)
-- 13.714s UNIT_SPELLCAST_CHANNEL_START 377844 (4s channel)
-- 13.714s SPELL_AURA_APPLIED 377844 (on player)
do
	local firstChannel = true

	function mod:BladestormStarting(args)
		firstChannel = true
		-- fixate debuff applies to a random player, boss starts 3 second cast
		self:TargetMessage(377827, "orange", args.destName, CL.casting:format(args.spellName))
		self:PlaySound(377827, "long", nil, args.destName)
		self:CDBar(377827, 59.5)
		if self:Me(args.destGUID) then
			self:Say(377827)
		end
	end

	function mod:BladestormFixateApplied(args)
		-- fixate debuff applies to a random player, boss starts 5 or 4 second channel
		self:TargetMessage(377827, "orange", args.destName)
		self:PlaySound(377827, "alarm", nil, args.destName)
		if firstChannel then
			-- no need to repeat the Say on the first channel because it will be the same player as the initial target
			firstChannel = false
		elseif self:Me(args.destGUID) then
			self:Say(377827)
		end
	end
end

function mod:RiraHackclawDeath(args)
	self:StopBar(381444) -- Savage Charge
	self:StopBar(377827) -- Bladestorm
	-- Rira's death will prevent Gashtooth from casting Decayed Senses and Tricktotem from casting
	-- Hextrick Totem, since they only cast their ultimates in response to Rira's command.
	self:StopBar(381694) -- Decayed Senses
	self:StopBar(381470) -- Hextrick Totem
end

-- Gashtooth

function mod:DecayedSenses(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 59.5)
end

function mod:DecayedSensesApplied(args)
	-- can be spell reflected by Warriors
	if self:Player(args.destFlags) and self:Dispeller("magic") then
		self:TargetMessage(381694, "purple", args.destName)
		self:PlaySound(381694, "warning", nil, args.destName)
	elseif self:Hostile(args.destFlags) then -- on boss
		self:Message(381694, "green", CL.on:format(args.spellName, args.destName))
		self:PlaySound(381694, "info")
	end
end

function mod:DecayedSensesRemoved(args)
	if self:Player(args.destFlags) then
		self:Message(381694, "green", CL.removed:format(args.spellName))
		self:PlaySound(381694, "info")
	end
end

function mod:GashFrenzy(args)
	self:StopBar(CL.count:format(args.spellName, gashFrenzyCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, gashFrenzyCount))
	self:PlaySound(args.spellId, "alert")
	gashFrenzyCount = gashFrenzyCount + 1
	self:CDBar(args.spellId, 59.5, CL.count:format(args.spellName, gashFrenzyCount))
end

do
	local function printTarget(self, name, guid)
		if self:Healer() and not self:Me(guid) then -- always show an alert for healers
			self:Message(378208, "red", CL.other:format(CL.count:format(self:SpellName(378208), markedForButcheryCount - 1), self:ColorName(name)))
			self:PlaySound(378208, "alarm")
		else -- this has ME_ONLY scope by default
			self:TargetMessage(378208, "red", name, CL.count:format(self:SpellName(378208), markedForButcheryCount - 1))
			self:PlaySound(378208, "alarm", nil, name)
		end
	end

	function mod:MarkedForButchery(args)
		self:StopBar(CL.count:format(args.spellName, markedForButcheryCount))
		markedForButcheryCount = markedForButcheryCount + 1
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 59.5, CL.count:format(args.spellName, markedForButcheryCount))
	end
end

function mod:GashtoothDeath(args)
	self:StopBar(381694) -- Decayed Senses
	self:StopBar(CL.count:format(self:SpellName(378029), gashFrenzyCount)) -- Gash Frenzy
	if self:Mythic() then
		self:StopBar(CL.count:format(self:SpellName(378208), markedForButcheryCount)) -- Marked For Butchery
	end
end

-- Tricktotem

function mod:HextrickTotem(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 59.5)
end

do
	local totemGUID = nil

	function mod:HextrickTotemSummon(args)
		-- register events to auto-mark totem
		if self:GetOption(totemMarker) then
			totemGUID = args.destGUID
			self:RegisterTargetEvents("MarkTotem")
		end
	end

	function mod:MarkTotem(_, unit, guid)
		if totemGUID == guid then
			totemGUID = nil
			self:CustomIcon(totemMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end
end

function mod:GreaterHealingRapids(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
	greaterHealingRapidsCount = greaterHealingRapidsCount + 1
	-- 59.5s cycle: pull:12.2, [21.8, 21.8, 15.8]
	if greaterHealingRapidsCount % 3 ~= 1 then -- 2, 3, 5, 6, etc
		self:CDBar(args.spellId, 21.8)
	else -- 4, 7, etc
		self:CDBar(args.spellId, 15.8)
	end
end

function mod:Bloodfrenzy(args)
	self:Message(args.spellId, "red", CL.percent:format(15, args.spellName))
	self:PlaySound(args.spellId, "long")
end

function mod:TricktotemDeath(args)
	self:StopBar(381470) -- Hextrick Totem
	self:StopBar(377950) -- Greater Healing Rapids
end
