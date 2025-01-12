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

local oppressiveBannerCount = 1

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
	self:Log("SPELL_CAST_SUCCESS", "BloodAndGlory", 320114)
	self:Log("SPELL_AURA_APPLIED", "BloodAndGloryApplied", 320102)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Blood and Glory over
	self:Log("SPELL_CAST_SUCCESS", "OppressiveBanner", 331618)
	self:Log("SPELL_AURA_REMOVED", "OppressiveBannerRemoved", 331606)
	self:Log("SPELL_CAST_START", "BrutalCombo", 320644)
	self:Log("SPELL_CAST_SUCCESS", "MightOfMaldraxxus", 320050)
	self:Log("SPELL_CAST_START", "MassiveCleave", 320729)
	self:Log("SPELL_CAST_START", "CrushingSlam", 317231)
	self:Log("SPELL_CAST_START", "DeafeningCrash", 339415) -- Mythic only
end

function mod:OnEngage()
	oppressiveBannerCount = 1
	self:CDBar(320644, 5.7) -- Brutal Combo
	self:CDBar(331618, 10.6, CL.count:format(self:SpellName(331618), oppressiveBannerCount)) -- Oppressive Banner
	self:CDBar(320050, 16.7) -- Might of Maldraxxus
	if not self:Solo() then
		self:CDBar(320114, 33.7) -- Blood and Glory
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local playerList = {}

	function mod:BloodAndGlory(args)
		playerList = {}
		self:CDBar(args.spellId, 70) -- Blood and Glory
	end

	function mod:BloodAndGloryApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(320114, "cyan", playerList, 2, nil, nil, 1) -- 1s wait time as it can be a little delayed sometimes
		self:PlaySound(320114, "long", nil, playerList)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, text, winner, _, _, loser)
	if text:find("Ability_PVP_GladiatorMedallion") then
		self:Message(320114, "cyan", L.defeated:format(self:ColorName(winner), self:ColorName(loser))) -- Blood and Glory
		self:PlaySound(320114, "info") -- Blood and Glory
	end
end

function mod:OppressiveBanner(args)
	self:StopBar(CL.count:format(args.spellName, oppressiveBannerCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, oppressiveBannerCount))
	oppressiveBannerCount = oppressiveBannerCount + 1
	if oppressiveBannerCount == 2 then
		self:CDBar(args.spellId, 25.5, CL.count:format(args.spellName, oppressiveBannerCount))
	else
		self:CDBar(args.spellId, 30.3, CL.count:format(args.spellName, oppressiveBannerCount))
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
	self:CDBar(args.spellId, 30.3)
	self:PlaySound(args.spellId, "alert")
end

do
	local mightOfMaldraxxusCount = 1

	function mod:MightOfMaldraxxus(args)
		mightOfMaldraxxusCount = 1
		self:CDBar(args.spellId, 30.3)
	end

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
