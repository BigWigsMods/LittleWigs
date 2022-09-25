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
		-- TODO Decayed Senses
		378029, -- Gash Frenzy
		-- TODO Marked for Butchery (Mythic-only)
		-- Tricktotem
		-- TODO Hextrick Totem
		377950, -- Greater Healing Rapids
		377965, -- Bloodlust
	}, {
		[377827] = -24732, -- Rira Hackclaw
		[378029] = -24733, -- Gashtooth
		[377950] = -24734, -- Tricktotem
	}
end

function mod:OnBossEnable()
	-- Rira Hackclaw
	self:Log("SPELL_AURA_APPLIED", "SavageChargeApplied", 381461)
	self:Log("SPELL_AURA_APPLIED", "BladestormFixateApplied", 381835)
	self:Log("SPELL_CAST_SUCCESS", "BladestormSuccess", 381834)

	-- Gashtooth
	self:Log("SPELL_CAST_START", "GashFrenzy", 378029)

	-- Tricktotem
	self:Log("SPELL_CAST_START", "GreaterHealingRapids", 377950)
	self:Log("SPELL_CAST_SUCCESS", "Bloodlust", 377965)
end

function mod:OnEngage()
	self:Bar(378029, 3.6) -- Gash Frenzy
	self:Bar(377950, 12.2) -- Greater Healing Rapids
	self:Bar(377827, 20.7) -- Bladestorm
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

function mod:GashFrenzy(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	-- TODO unknown CD
end

-- Tricktotem

function mod:GreaterHealingRapids(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
	-- TODO unknown CD
end

function mod:Bloodlust(args)
	self:Message(args.spellId, "orange", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end
