--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Xav the Unfallen", 2293, 2390)
if not mod then return end
mod:RegisterEnableMob(162329) -- Xav the Unfallen
mod:SetEncounterID(2366)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local bloodAndGloryCount = 1
local oppressiveBannerCount = 1
local nextBloodAndGlory = 0
local nextOppressiveBanner = 0
local nextMightOfMaldraxxus = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.defeated = "%s has defeated %s"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		320114, -- Blood and Glory
		331618, -- Oppressive Banner
		{320644, "TANK_HEALER"}, -- Brutal Combo
		320050, -- Might of Maldraxxus
		320729, -- Massive Cleave
		317231, -- Crushing Slam
		-- Mythic
		339415, -- Deafening Crash
	}, {
		[339415] = "mythic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BloodAndGlory", 320114)
	self:Log("SPELL_AURA_APPLIED", "BloodAndGloryApplied", 320102)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER") -- Blood and Glory over
	self:Log("SPELL_CAST_SUCCESS", "OppressiveBanner", 331618)
	self:Log("SPELL_AURA_REMOVED", "OppressiveBannerRemoved", 331606)
	self:Log("SPELL_CAST_START", "BrutalCombo", 320644)
	self:Log("SPELL_CAST_SUCCESS", "MightOfMaldraxxus", 320050)
	self:Log("SPELL_CAST_START", "MassiveCleave", 320729)
	self:Log("SPELL_CAST_START", "CrushingSlam", 317231)
	self:Log("SPELL_CAST_START", "DeafeningCrash", 339415) -- Mythic only
end

function mod:OnEngage()
	local t = GetTime()
	bloodAndGloryCount = 1
	oppressiveBannerCount = 1
	self:CDBar(320644, 5.7) -- Brutal Combo
	nextOppressiveBanner = t + 10.6
	self:CDBar(331618, 10.6, CL.count:format(self:SpellName(331618), oppressiveBannerCount)) -- Oppressive Banner
	nextMightOfMaldraxxus = t + 16.5
	self:CDBar(320050, 16.5) -- Might of Maldraxxus
	if not self:Solo() then
		nextBloodAndGlory = t + 31.2
		self:CDBar(320114, 31.2, CL.count:format(self:SpellName(320114), bloodAndGloryCount)) -- Blood and Glory
	end
end

function mod:VerifyEnable(unit)
	-- boss is targetable at the beginning of the wing
	return UnitCanAttack("player", unit)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local playerList = {}

	function mod:BloodAndGlory(args)
		local t = GetTime()
		playerList = {}
		self:StopBar(CL.count:format(args.spellName, bloodAndGloryCount))
		bloodAndGloryCount = bloodAndGloryCount + 1
		local mightOfMaldraxxusTimeLeft = nextMightOfMaldraxxus - t
		if mightOfMaldraxxusTimeLeft < 20.6 then
			nextMightOfMaldraxxus = t + 20.6
			self:CDBar(320050, {20.6, 30.3}) -- Might of Maldraxxus
		end
		nextBloodAndGlory = t + 65.5
		self:CDBar(args.spellId, 65.5, CL.count:format(args.spellName, bloodAndGloryCount))
	end

	function mod:BloodAndGloryApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(320114, "cyan", playerList, 2, CL.count:format(self:SpellName(320114), bloodAndGloryCount - 1), nil, 1) -- 1s wait time as it can be a little delayed sometimes
		self:PlaySound(320114, "long", nil, playerList)
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(_, text, winner, _, _, loser)
	if text:find("Ability_PVP_GladiatorMedallion") then
		self:Message(320114, "cyan", L.defeated:format(self:ColorName(winner), self:ColorName(loser))) -- Blood and Glory
		self:PlaySound(320114, "info") -- Blood and Glory
	end
end

function mod:OppressiveBanner(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, oppressiveBannerCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, oppressiveBannerCount))
	oppressiveBannerCount = oppressiveBannerCount + 1
	if not self:Solo() then
		nextOppressiveBanner = t + 30.3
		self:CDBar(args.spellId, 30.3, CL.count:format(args.spellName, oppressiveBannerCount))
	else -- Solo
		if oppressiveBannerCount == 2 then
			nextOppressiveBanner = t + 25.5
			self:CDBar(args.spellId, 25.5, CL.count:format(args.spellName, oppressiveBannerCount))
		else
			nextOppressiveBanner = t + 30.3
			self:CDBar(args.spellId, 30.3, CL.count:format(args.spellName, oppressiveBannerCount))
		end
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:OppressiveBannerRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(331618, "green", CL.removed:format(args.spellName))
		self:PlaySound(331618, "info")
	end
end

function mod:BrutalCombo(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 15.8)
	self:PlaySound(args.spellId, "alert")
end

do
	local mightOfMaldraxxusCount = 1

	function mod:MightOfMaldraxxus(args)
		local t = GetTime()
		mightOfMaldraxxusCount = 1
		-- in a group: 14.6 to Blood and Glory, 19.4 to Oppressive Banner, 19.4 or 21.8 until Brutal Combo
		-- solo: 18.2 to Oppressive Banner, 18.2 or 20.7 to Brutal Combo
		if not self:Solo() then
			local bloodAndGloryTimeLeft = nextBloodAndGlory - t
			if bloodAndGloryTimeLeft < 14.6 then
				nextBloodAndGlory = t + 14.6
				self:CDBar(320114, {14.6, 65.5}, CL.count:format(self:SpellName(320114), bloodAndGloryCount)) -- Blood and Glory
			end
			local oppressiveBannerTimeLeft = nextOppressiveBanner - t
			if oppressiveBannerTimeLeft < 19.4 then
				nextOppressiveBanner = t + 19.4
				self:CDBar(331618, {19.4, 30.3}, CL.count:format(self:SpellName(331618), oppressiveBannerCount)) -- Oppressive Banner
			end
			-- if possible, Oppressive Banner will always happen before Brutal Combo, which adds 2.4s to Brutal Combo
			if oppressiveBannerTimeLeft < 21.8 then
				self:CDBar(320644, 21.8) -- Brutal Combo
			else
				self:CDBar(320644, 19.4) -- Brutal Combo
			end
		else -- Solo
			local oppressiveBannerTimeLeft = nextOppressiveBanner - t
			if oppressiveBannerTimeLeft < 18.2 then
				nextOppressiveBanner = t + 18.2
				self:CDBar(331618, {18.2, 30.3}, CL.count:format(self:SpellName(331618), oppressiveBannerCount)) -- Oppressive Banner
			end
			-- if possible, Oppressive Banner will always happen before Brutal Combo, which adds 2.5s to Brutal Combo
			if oppressiveBannerTimeLeft < 20.7 then
				self:CDBar(320644, 20.7) -- Brutal Combo
			else
				self:CDBar(320644, 18.2) -- Brutal Combo
			end
		end
		nextMightOfMaldraxxus = t + 30.3
		self:CDBar(args.spellId, 30.3)
	end

	-- possible combos (in Mythic):
	--- Massive Cleave, Crushing Slam, Deafening Crash
	--- Massive Cleave, Deafening Crash, Crushing Slam
	--- Crushing Slam, Deafening Crash, Massive Cleave
	--- Crushing Slam, Massive Cleave, Deafening Crash
	--- Deafening Crash, Massive Cleave, Massive Cleave

	function mod:CrushingSlam(args)
		self:Message(args.spellId, "red", CL.count_amount:format(args.spellName, mightOfMaldraxxusCount, 3))
		mightOfMaldraxxusCount = mightOfMaldraxxusCount + 1
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:MassiveCleave(args)
		self:Message(args.spellId, "orange", CL.count_amount:format(args.spellName, mightOfMaldraxxusCount, 3))
		mightOfMaldraxxusCount = mightOfMaldraxxusCount + 1
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:DeafeningCrash(args)
		self:Message(args.spellId, "yellow", CL.count_amount:format(args.spellName, mightOfMaldraxxusCount, 3))
		mightOfMaldraxxusCount = mightOfMaldraxxusCount + 1
		self:PlaySound(args.spellId, "warning")
	end
end
