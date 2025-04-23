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
	self:Log("SPELL_AURA_REMOVED", "HappyHourRemoved", 442525)
	self:Log("SPELL_AURA_APPLIED", "CarryingCinderbrewApplied", 431895)
	self:Log("SPELL_AURA_REMOVED", "CarryingCinderbrewRemoved", 431895)
	self:Log("SPELL_CAST_START", "BlazingBelch", 432198)
	self:Log("SPELL_CAST_START", "ThrowCinderbrew", 432179)
	self:Log("SPELL_AURA_APPLIED", "ThrowCinderbrewApplied", 432182)
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
		self:SetStage(2)
		if happyHourCount == 1 then
			self:Message(args.spellId, "cyan", CL.percent:format(66, args.spellName))
		else
			self:Message(args.spellId, "cyan", CL.percent:format(33, args.spellName))
		end
		happyHourCount = happyHourCount + 1
		self:PlaySound(args.spellId, "long")
	end

	function mod:HappyHourRemoved(args)
		self:SetStage(1)
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, args.time - happyHourStart))
		self:CDBar(432229, 9.1) -- Keg Smash
		self:CDBar(432179, 14.0) -- Throw Cinderbrew
		self:CDBar(432198, 17.6) -- Blazing Belch
		self:PlaySound(args.spellId, "long")
	end
end

function mod:CarryingCinderbrewApplied(args)
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


do
	local playerList = {}

	function mod:ThrowCinderbrew(args)
		playerList = {}
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 18.2)
	end

	function mod:ThrowCinderbrewApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(432179, "yellow", playerList, 2)
		if self:Healer() then
			self:PlaySound(432179, "info", nil, playerList)
		elseif self:Me(args.destGUID) then
			self:PlaySound(432179, "info")
		end
	end
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
