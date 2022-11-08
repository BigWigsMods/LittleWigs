--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Crawth", 2526, 2495)
if not mod then return end
mod:RegisterEnableMob(191736) -- Crawth
mod:SetEncounterID(2564)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local searingBlazeGoals = 0
local rushingWindsGoals = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
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
	-- TODO Gale Force applied? 376760? doesn't spawn as of build 46157

	-- Crawth
	self:Log("SPELL_CAST_START", "OverpoweringGust", 377034)
	self:Log("SPELL_CAST_START", "DeafeningScreech", 377004)
	self:Log("SPELL_CAST_START", "SavagePeck", 376997)
end

function mod:OnEngage()
	searingBlazeGoals = 0
	rushingWindsGoals = 0
	self:CDBar(376997, 3.7) -- Savage Peck
	self:Bar(377004, 10.9) -- Deafening Screech
	self:Bar(377034, 15.8) -- Overpowering Gust
	self:CDBar(377182, 14.0) -- Play Ball
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Lish Llrath

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("377182", nil, true) then -- Play Ball
		self:Message(377182, "cyan")
		self:PlaySound(377182, "long")
		self:CDBar(377182, 18.2)
	end
end

-- [UPDATE_UI_WIDGET] widgetID:4183, shownState:1, text:Goal of the Searing Blaze, barValue:0
function mod:GoalOfTheSearingBlaze(_, _, info)
	local shownState = info.shownState
	local barValue = info.barValue
	if shownState == 1 and barValue == 3 then
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

-- Crawth

function mod:OverpoweringGust(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 14.2)
end

function mod:DeafeningScreech(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 22.7)
end

function mod:SavagePeck(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 14.6)
end
