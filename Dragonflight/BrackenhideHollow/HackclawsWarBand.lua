if not IsTestBuild() then return end
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
		377965, -- Bloodlust
	}, {
		[381444] = -24732, -- Rira Hackclaw
		[381694] = -24733, -- Gashtooth
		[381470] = -24734, -- Tricktotem
	}
end

function mod:OnBossEnable()
	-- Rira Hackclaw
	self:Log("SPELL_AURA_APPLIED", "SavageChargeApplied", 381461)
	self:Log("SPELL_AURA_APPLIED", "BladestormFixateApplied", 377844) -- TODO and 381835?
	self:Log("SPELL_CAST_SUCCESS", "BladestormSuccess", 381834) -- TODO cast start instead? or remove + track 381835 aura

	-- Gashtooth
	self:Log("SPELL_CAST_START", "DecayedSenses", 381694)
	self:Log("SPELL_AURA_APPLIED", "DecayedSensesApplied", 381379)
	self:Log("SPELL_AURA_REMOVED", "DecayedSensesRemoved", 381379)
	self:Log("SPELL_CAST_START", "GashFrenzy", 378029)

	-- Tricktotem
	self:Log("SPELL_CAST_START", "HextrickTotem", 381470)
	self:Log("SPELL_CAST_START", "GreaterHealingRapids", 377950)
	self:Log("SPELL_CAST_SUCCESS", "Bloodlust", 377965)
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
	local onMe = self:Me(destGUID)
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

function mod:BladestormFixateApplied(args)
	-- fixate debuff applies to a random player, boss starts 3 second cast
	self:TargetMessage(377827, "red", args.destName)
	self:PlaySound(377827, "alarm", nil, args.destName)
	-- TODO unknown CD
end

function mod:BladestormSuccess(args)
	-- start of 5 second channel
	self:Message(377827, "red")
	self:PlaySound(377827, "alarm")
	self:CastBar(377827, 5)
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

function mod:Bloodlust(args)
	self:Message(args.spellId, "orange", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end
