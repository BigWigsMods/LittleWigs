local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
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
		432196, -- Hot Honey
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Clear the Bar
	self:Log("SPELL_CAST_SUCCESS", "HappyHour", 442525)
	self:Log("SPELL_AURA_REMOVED", "HappyHourOver", 442525)
	self:Log("SPELL_AURA_APPLIED", "CarryingCinderbrew", 431895)
	self:Log("SPELL_AURA_REMOVED", "CarryingCinderbrewRemoved", 431895)
	self:Log("SPELL_CAST_START", "BlazingBelch", 432198)
	self:Log("SPELL_CAST_START", "ThrowCinderbrew", 432179)
	self:Log("SPELL_CAST_START", "KegSmash", 432229)
	self:Log("SPELL_PERIODIC_DAMAGE", "HotHoneyDamage", 432196)
	self:Log("SPELL_PERIODIC_MISSED", "HotHoneyDamage", 432196)
end

function mod:OnEngage()
	happyHourCount = 1
	self:SetStage(1)
	self:CDBar(432229, 5.1) -- Keg Smash
	self:CDBar(432179, 10.0) -- Throw Cinderbrew
	self:CDBar(432198, 14.4) -- Blazing Belch
	if not isElevenDotOne then -- XXX remove in 11.1
		-- cast at 100 energy, starts at 55 energy: .9s delay + 20.25s energy gain + runs to bar + 1.5s delay + 2s cast
		self:CDBar(442525, 27.8) -- Happy Hour
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 454459 then -- [DNT] Clear the Bar
		-- this is cast as the boss jumps over the bar before starting Happy Hour
		self:StopBar(432198) -- Blazing Belch
		self:StopBar(432179) -- Throw Cinderbrew
		self:StopBar(432229) -- Keg Smash
	end
end

do
	local happyHourStart = 0

	function mod:HappyHour(args)
		happyHourStart = args.time
		self:StopBar(432198) -- Blazing Belch
		self:StopBar(432179) -- Throw Cinderbrew
		self:StopBar(432229) -- Keg Smash
		if not isElevenDotOne then -- XXX remove in 11.1
			self:StopBar(args.spellId)
		end
		self:SetStage(2)
		if isElevenDotOne then
			if happyHourCount == 1 then
				self:Message(args.spellId, "cyan", CL.percent:format(66, args.spellName))
			else
				self:Message(args.spellId, "cyan", CL.percent:format(33, args.spellName))
			end
		else -- XXX remove in 11.1
			self:Message(args.spellId, "cyan")
		end
		happyHourCount = happyHourCount + 1
		self:PlaySound(args.spellId, "long")
	end

	function mod:HappyHourOver(args)
		self:SetStage(1)
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, args.time - happyHourStart))
		self:CDBar(432229, 9.1) -- Keg Smash
		self:CDBar(432179, 14.0) -- Throw Cinderbrew
		self:CDBar(432198, 17.6) -- Blazing Belch
		if not isElevenDotOne then -- XXX remove in 11.1
			-- cast at 100 energy, 2.4s delay + 45s energy gain + runs to bar + 1.5s delay + 2s cast
			self:CDBar(args.spellId, 50.9)
		end
		self:PlaySound(args.spellId, "long")
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
	self:CDBar(args.spellId, 23.0)
	self:PlaySound(args.spellId, "alarm")
end

function mod:ThrowCinderbrew(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 18.2)
	self:PlaySound(args.spellId, "alert")
end

function mod:KegSmash(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 14.5)
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	function mod:HotHoneyDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end
