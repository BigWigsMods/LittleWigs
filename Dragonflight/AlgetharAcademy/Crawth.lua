--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Crawth", 2526, 2495)
if not mod then return end
mod:RegisterEnableMob(
	191631, -- Ball
	191736  -- Crawth
)
mod:SetEncounterID(2564)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "achievement_dungeon_dragonacademy"
end

--------------------------------------------------------------------------------
-- Locals
--

local playBallCount = 0
local searingBlazeGoals = 0
local rushingWindsGoals = 0
local sonicVulnerabilityStacks = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"warmup",
		-- Lish Llrath
		377182, -- Play Ball
		389481, -- Goal of the Searing Blaze
		376448, -- Firestorm
		389483, -- Goal of the Rushing Winds
		376467, -- Gale Force
		-- Crawth
		377034, -- Overpowering Gust
		377004, -- Deafening Screech
		{376997, "TANK_HEALER"}, -- Savage Peck
	}, {
		["warmup"] = CL.general,
		[377182] = 377182, -- Play Ball
		[377034] = self.displayName,
	}
end

function mod:OnBossEnable()
	-- Lish Llrath
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:RegisterWidgetEvent(4183, "GoalOfTheSearingBlaze")
	self:Log("SPELL_AURA_APPLIED", "FirestormApplied", 376781)
	self:RegisterWidgetEvent(4184, "GoalOfTheRushingWinds")
	self:Log("SPELL_AURA_APPLIED", "GaleForceApplied", 376760)

	-- Crawth
	self:Log("SPELL_CAST_START", "OverpoweringGust", 377034)
	self:Log("SPELL_CAST_START", "DeafeningScreech", 377004)
	self:Log("SPELL_CAST_START", "SavagePeck", 376997)
end

function mod:OnEngage()
	playBallCount = 0
	searingBlazeGoals = 0
	rushingWindsGoals = 0
	sonicVulnerabilityStacks = 0
	self:StopBar(CL.active)
	self:CDBar(376997, 3.7) -- Savage Peck
	if self:Mythic() then
		self:CDBar(377004, 10.1, CL.count:format(self:SpellName(377004), 1)) -- Deafening Screech
	else
		self:CDBar(377004, 10.1) -- Deafening Screech
	end
	self:Bar(377034, 15.8) -- Overpowering Gust
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- General

function mod:Warmup() -- called from trash module
	-- this can take slightly longer depending on where Crawth is in her patrol
	self:Bar("warmup", 10.7, CL.active, L.warmup_icon)
end

-- Lish Llrath

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("377182", nil, true) then -- Play Ball
		-- cast at 75% and 45% health
		local percent = playBallCount == 0 and 75 or 45
		playBallCount = playBallCount + 1
		self:Message(377182, "cyan", CL.percent:format(percent, self:SpellName(377182)))
		self:PlaySound(377182, "long")
	end
end

-- [UPDATE_UI_WIDGET] widgetID:4183, shownState:1, text:Goal of the Searing Blaze, barValue:0
function mod:GoalOfTheSearingBlaze(_, _, info)
	local shownState = info.shownState
	local barValue = info.barValue
	if shownState == 1 and barValue == 3 then
		if self:Mythic() then
			-- reset the count in the Deafening Screech bar back to 1
			local oldBarText = CL.count:format(self:SpellName(377004), sonicVulnerabilityStacks + 1) -- Deafening Screech (n)
			local barTimeLeft = self:BarTimeLeft(oldBarText)
			if barTimeLeft > .1 then
				self:StopBar(oldBarText)
				self:CDBar(377004, {barTimeLeft, 22.7}, CL.count:format(self:SpellName(377004), 1)) -- Deafening Screech (1)
			end
		end
		sonicVulnerabilityStacks = 0
		searingBlazeGoals = barValue
		self:Message(376448, "red") -- Firestorm
		self:PlaySound(376448, "long")
	elseif shownState == 1 and barValue > 0 and barValue ~= searingBlazeGoals then
		searingBlazeGoals = barValue
		self:Message(389481, "cyan", CL.count_amount:format(info.text, barValue, 3)) -- Goal of the Searing Blaze (n/3)
		self:PlaySound(389481, "info")
	else
		searingBlazeGoals = barValue
	end
end

function mod:FirestormApplied(args)
	self:Bar(376448, 12, CL.onboss:format(args.spellName))
	self:Message(376448, "green", CL.onboss:format(args.spellName))
	self:PlaySound(376448, "info")
end

-- [UPDATE_UI_WIDGET] widgetID:4184, shownState:1, text:Goal of the Rushing Winds, barValue:0
function mod:GoalOfTheRushingWinds(_, _, info)
	local shownState = info.shownState
	local barValue = info.barValue
	if shownState == 1 and barValue == 3 then
		if self:Mythic() then
			-- reset the count in the Deafening Screech bar back to 1
			local oldBarText = CL.count:format(self:SpellName(377004), sonicVulnerabilityStacks + 1) -- Deafening Screech (n)
			local barTimeLeft = self:BarTimeLeft(oldBarText)
			if barTimeLeft > .1 then
				self:StopBar(oldBarText)
				self:CDBar(377004, {barTimeLeft, 22.7}, CL.count:format(self:SpellName(377004), 1)) -- Deafening Screech (1)
			end
		end
		sonicVulnerabilityStacks = 0
		rushingWindsGoals = barValue
		self:Message(376467, "red") -- Gale Force
		self:PlaySound(376467, "long")
	elseif shownState == 1 and barValue > 0 and barValue ~= rushingWindsGoals then
		rushingWindsGoals = barValue
		self:Message(389483, "cyan", CL.count_amount:format(info.text, barValue, 3)) -- Goal of the Rushing Winds (n/3)
		self:PlaySound(389483, "info")
	else
		rushingWindsGoals = barValue
	end
end

function mod:GaleForceApplied(args)
	if self:Me(args.destGUID) then
		self:Bar(376467, 20, CL.you:format(args.spellName), args.spellId)
		self:Message(376467, "green", CL.you:format(args.spellName), args.spellId)
		self:PlaySound(376467, "info")
	end
end

-- Crawth

function mod:OverpoweringGust(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 28.6)
end

function mod:DeafeningScreech(args)
	if self:Mythic() then
		-- in Mythic difficulty each subsequent cast does more damage, reset whenever Firestorm or Gale Force are activated
		sonicVulnerabilityStacks = sonicVulnerabilityStacks + 1
		self:Message(args.spellId, "yellow", CL.count:format(CL.casting:format(args.spellName), sonicVulnerabilityStacks))
		self:StopBar(CL.count:format(args.spellName, sonicVulnerabilityStacks))
		self:CDBar(args.spellId, 22.7, CL.count:format(args.spellName, sonicVulnerabilityStacks + 1))
	else
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 22.7)
	end
	self:PlaySound(args.spellId, "warning")
end

function mod:SavagePeck(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 14.6)
end
