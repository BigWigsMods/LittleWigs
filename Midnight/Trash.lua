--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Common Trash", {2813, 2825, 2859, 2923, 2993, 2521, 1877, 1762}) -- S2 dungeons
if not mod then return end
mod:SetTrashModule(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.common_trash = "Common Trash"
	L.trash_cast = "Cast"
	L.trash_cast_desc = "Alert when a standard trash mob casts a spell."
	L.lieutenant_cast = "Cast (Lieutenant)"
	L.lieutenant_cast_desc = "Alert when a Lieutenant trash mob casts a spell."
	L.trash_channel = "Channel"
	L.trash_channel_desc = "Alert when any trash mob channels a spell."
	L.customization = "Customization"
	L.all_units = "All units show messages and play sounds"
	L.messages_all_sounds_target = "All units show messages, but only your target plays sounds"
	L.target_only = "Only your target shows messages and plays sounds"
	L.custom_select_unit_standard = "Standard mobs"
	L.custom_select_unit_standard_desc = "Select which standard trash mobs should show messages and play sounds."
	L.custom_select_unit_standard_value1 = L.target_only
	L.custom_select_unit_standard_value2 = L.messages_all_sounds_target
	L.custom_select_unit_standard_value3 = L.all_units
	L.custom_select_unit_lieutenant = "Lieutenants"
	L.custom_select_unit_lieutenant_desc = "Select which Lieutenant trash mobs should show messages and play sounds."
	L.custom_select_unit_lieutenant_value1 = L.all_units
	L.custom_select_unit_lieutenant_value2 = L.messages_all_sounds_target
	L.custom_select_unit_lieutenant_value3 = L.target_only
	L.custom_select_throttle_type = "Throttle type"
	L.custom_select_throttle_type_desc = "What features should be throttled"
	L.custom_select_throttle_type_value1 = "Both messages and sounds"
	L.custom_select_throttle_type_value2 = "Sounds only"
	L.custom_select_throttle_duration = "Throttle duration"
	L.custom_select_throttle_duration_desc = "How long to wait between alerts. Your target is never throttled."
	L.custom_select_throttle_duration_value1 = "2 seconds"
	L.custom_select_throttle_duration_value2 = "1 second"
	L.custom_select_throttle_duration_value3 = "3 seconds"
end

--------------------------------------------------------------------------------
-- Locals
--

local castsPerUnit = {}
local STANDARD_LEVEL, LIEUTENANT_LEVEL, BOSS_LEVEL, QUESTION_LEVEL = 90, 91, 92, -1 -- Midnight-specific
local UNIT_FILTER_ALL, UNIT_FILTER_TARGET_SOUND_ONLY, UNIT_FILTER_TARGET_ONLY = 1, 2, 3
local STANDARD_FILTER_VALUES = { -- the standard option lists "target only" first (default), so we re-map here
	[1] = UNIT_FILTER_TARGET_ONLY,
	[2] = UNIT_FILTER_TARGET_SOUND_ONLY,
	[3] = UNIT_FILTER_ALL,
}
local THROTTLE_TYPE_SOUNDS_ONLY = 2
local THROTTLE_DURATIONS = { 2, 1, 3 } -- custom_select_throttle_duration values -> seconds (default 2s)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.common_trash
end

function mod:GetOptions()
	return {
		"trash_cast",
		"lieutenant_cast",
		"trash_channel",
		"custom_select_unit_standard",
		"custom_select_unit_lieutenant",
		"custom_select_throttle_type",
		"custom_select_throttle_duration",
	}, {
		["custom_select_unit_standard"] = L.customization,
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
	self:RegisterEvent("UNIT_SPELLCAST_START", "UNIT_SPELLCAST")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "UNIT_SPELLCAST")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", "UNIT_SPELLCAST")
end

function mod:OnBossDisable()
	castsPerUnit = {}
end

--------------------------------------------------------------------------------
-- Cast Alert Handler
--

function mod:NAME_PLATE_UNIT_REMOVED(_, unit)
	-- clear the list of seen casts per unit, so when the unit token is reused we won't filter
	castsPerUnit[unit] = nil
end

do
	local function ResolveUnitFilter(self, isLieutenant)
		local option = self:GetOption(isLieutenant and "custom_select_unit_lieutenant" or "custom_select_unit_standard")
		if isLieutenant then
			return option
		end
		return STANDARD_FILTER_VALUES[option] or UNIT_FILTER_ALL
	end

	function mod:UNIT_SPELLCAST(event, unit, _, spellID, castBarID)
		local level = BigWigsLoader.UnitLevel(unit)
		local isLieutenant = level == LIEUTENANT_LEVEL or level == BOSS_LEVEL or level == QUESTION_LEVEL
		local unitFilterOption = ResolveUnitFilter(self, isLieutenant)
		if unitFilterOption == UNIT_FILTER_TARGET_ONLY then -- target only
			if unit ~= "target" then return end
		else -- only nameplate units (trash mobs)
			if not unit:find("^nameplate") then return end
		end
		local allEventsPlaySounds = unitFilterOption ~= UNIT_FILTER_TARGET_SOUND_ONLY

		-- once per cast (don't alert on SUCCEEDED if we saw the START)
		if event == "UNIT_SPELLCAST_SUCCEEDED" and castBarID and castsPerUnit[unit] and castsPerUnit[unit][castBarID] then
			return
		elseif castBarID then
			if not castsPerUnit[unit] then
				castsPerUnit[unit] = {}
			end
			castsPerUnit[unit][castBarID] = true
		end

		-- basic filters
		if level ~= STANDARD_LEVEL and not isLieutenant then return end -- skip low-level mobs
		if not UnitIsEnemy("player", unit) then return end -- skip friendly/neutral
		if BigWigsLoader.UnitClassification(unit) ~= "elite" then return end -- elite only
		if not self:UnitWithinRange(unit, 45) then return end -- range check
		if self:IsAnyEncounterInProgress() then return end -- don't alert during boss fights
		if not UnitAffectingCombat(unit) then
			-- check again on the next frame - some mobs cast immediately on entering combat.
			self:SimpleTimer(function()
				if UnitAffectingCombat(unit) then
					self:ShowAlert(unit, spellID, event, allEventsPlaySounds, isLieutenant)
				end
			end, 0.05)
			return
		end

		self:ShowAlert(unit, spellID, event, allEventsPlaySounds, isLieutenant)
	end
end

do
	local prevChannel, prevLieutenant, prevCast = 0, 0, 0

	local function GetThrottleDuration(unitIsTarget, throttleIndex)
		if unitIsTarget then
			return 0 -- don't throttle target
		end
		return THROTTLE_DURATIONS[throttleIndex] or THROTTLE_DURATIONS[1]
	end

	function mod:ShowAlert(unit, spellID, event, allEventsPlaySounds, isLieutenant)
		local t = GetTime()
		local unitIsTarget = UnitIsUnit("target", unit)
		local throttleDuration = GetThrottleDuration(unitIsTarget, self:GetOption("custom_select_throttle_duration"))
		local throttleSoundsOnly = self:GetOption("custom_select_throttle_type") == THROTTLE_TYPE_SOUNDS_ONLY
		if event == "UNIT_SPELLCAST_CHANNEL_START" then -- channels
			local shouldAlert = t - prevChannel > throttleDuration
			if throttleSoundsOnly or shouldAlert then
				self:SecretMessage("trash_channel", "yellow", spellID)
			end
			if shouldAlert then
				prevChannel = t
				if unitIsTarget or allEventsPlaySounds then
					self:PlaySound("trash_channel", "info")
				end
			end
		elseif isLieutenant then -- lieutenant casts
			local shouldAlert = t - prevLieutenant > throttleDuration
			if throttleSoundsOnly or shouldAlert then
				self:SecretMessage("lieutenant_cast", "orange", spellID)
			end
			if shouldAlert then
				prevLieutenant = t
				if unitIsTarget or allEventsPlaySounds then
					self:PlaySound("lieutenant_cast", "alarm")
				end
			end
		else -- standard casts
			local shouldAlert = t - prevCast > throttleDuration
			if throttleSoundsOnly or shouldAlert then
				self:SecretMessage("trash_cast", "red", spellID)
			end
			if shouldAlert then
				prevCast = t
				if unitIsTarget or allEventsPlaySounds then
					self:PlaySound("trash_cast", "alert")
				end
			end
		end
	end
end
