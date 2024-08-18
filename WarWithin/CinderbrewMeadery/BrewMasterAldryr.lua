--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Brew Master Aldryr", 2661, 2586)
if not mod then return end
mod:RegisterEnableMob(210271) -- Brew Master Aldryr
mod:SetEncounterID(2900)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local happyHourCount = 1
local blazingBelchRemaining = 2
local throwCinderbrewRemaining = 2
local kegSmashRemaining = 3

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.cinderbrew_delivered = "Cinderbrew delivered"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		442525, -- Happy Hour
		431895, -- Carrying Cinderbrew
		432198, -- Blazing Belch
		432179, -- Throw Cinderbrew
		432229, -- Keg Smash
		-- TODO Crawling Brawl (Mythic)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "HappyHour", 442525)
	self:Log("SPELL_AURA_REMOVED", "HappyHourOver", 442525)
	self:Log("SPELL_AURA_APPLIED", "CarryingCinderbrew", 431895)
	self:Log("SPELL_AURA_REMOVED", "CarryingCinderbrewRemoved", 431895)
	self:Log("SPELL_CAST_START", "BlazingBelch", 432198)
	self:Log("SPELL_CAST_START", "ThrowCinderbrew", 432179)
	self:Log("SPELL_CAST_START", "KegSmash", 432229)
end

function mod:OnEngage()
	happyHourCount = 1
	blazingBelchRemaining = 1
	throwCinderbrewRemaining = 1
	kegSmashRemaining = 2
	self:SetStage(1)
	self:CDBar(432229, 5.1) -- Keg Smash
	self:CDBar(432179, 10.7) -- Throw Cinderbrew
	self:CDBar(432198, 14.4) -- Blazing Belch
	-- cast at 100 energy, starts at 55 energy: .9s delay + 20.25s energy gain + runs to bar + 1.5s delay + 2s cast
	self:CDBar(442525, 28.7, CL.count:format(self:SpellName(442525), happyHourCount)) -- Happy Hour
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local happyHourStart = 0

	function mod:HappyHour(args)
		happyHourStart = args.time
		self:StopBar(432198) -- Blazing Belch
		self:StopBar(432179) -- Throw Cinderbrew
		self:StopBar(432229) -- Keg Smash
		self:StopBar(CL.count:format(args.spellName, happyHourCount))
		self:SetStage(2)
		self:Message(args.spellId, "cyan", CL.count:format(args.spellName, happyHourCount))
		self:PlaySound(args.spellId, "long")
		happyHourCount = happyHourCount + 1
	end

	function mod:HappyHourOver(args)
		blazingBelchRemaining = 2
		throwCinderbrewRemaining = 2
		kegSmashRemaining = 3
		self:SetStage(1)
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, args.time - happyHourStart))
		self:PlaySound(args.spellId, "info")
		self:CDBar(432229, 9.1) -- Keg Smash
		self:CDBar(432179, 14.0) -- Throw Cinderbrew
		self:CDBar(432198, 17.6) -- Blazing Belch
		-- cast at 100 energy, 2.4s delay + 45s energy gain + runs to bar + 1.5s delay + 2s cast
		self:CDBar(args.spellId, 50.9, CL.count:format(args.spellName, happyHourCount))
	end
end

function mod:CarryingCinderbrew(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:CarryingCinderbrewRemoved(args)
	if self:GetStage() == 2 and self:Me(args.destGUID) then
		self:Message(args.spellId, "green", L.cinderbrew_delivered)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:BlazingBelch(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	blazingBelchRemaining = blazingBelchRemaining - 1
	if blazingBelchRemaining > 0 then
		self:CDBar(args.spellId, 23.1)
	else
		self:StopBar(args.spellId)
	end
end

function mod:ThrowCinderbrew(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	throwCinderbrewRemaining = throwCinderbrewRemaining - 1
	if throwCinderbrewRemaining > 0 then
		self:CDBar(args.spellId, 18.2)
	else
		self:StopBar(args.spellId)
	end
end

function mod:KegSmash(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	kegSmashRemaining = kegSmashRemaining - 1
	if kegSmashRemaining > 0 then
		self:CDBar(args.spellId, 14.5)
	else
		self:StopBar(args.spellId)
	end
end
