if not BigWigsLoader.isNext then return end -- XXX 12.1
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
    L.custom_select_unit = "Which units to track"
    L.custom_select_unit_desc = "Select which units should show messages and play sounds."
    L.custom_select_unit_value1 = "All units show messages and play sounds"
    L.custom_select_unit_value2 = "All units show messages, but only your target plays sounds"
    L.custom_select_unit_value3 = "Only your target shows messages and plays sounds"
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
local STANDARD_LEVEL, LIEUTENANT_LEVEL = 90, 91 -- Midnight-specific

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
        "custom_select_unit",
        "custom_select_throttle_type",
        "custom_select_throttle_duration",
	}, {
        ["custom_select_unit"] = L.customization,
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

local prevChannel, prevLieutenant, prevCast = 0, 0, 0
function mod:UNIT_SPELLCAST(event, unit, _, spellID, castBarID)
    local unitFilterOption = self:GetOption("custom_select_unit") -- 1 = all, 2 = all message, target sound, 3 = target
    if unitFilterOption == 3 then -- target only
        if unit ~= "target" then return end
    else -- only nameplate units (trash mobs)
        if not unit:find("^nameplate") then return end
    end
    local allEventsPlaySounds = unitFilterOption ~= 2

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
	if not UnitIsEnemy("player", unit) then return end -- skip friendly/neutral
	if BigWigsLoader.UnitClassification(unit) ~= "elite" then return end -- elite only
	if not self:UnitWithinRange(unit, 45) then return end -- range check
    if not UnitAffectingCombat(unit) then
        -- check again on the next frame - some mobs cast immediately on entering combat.
        self:SimpleTimer(function()
            if UnitAffectingCombat(unit) then
                self:ShowAlert(unit, spellID, event, allEventsPlaySounds)
            end
        end, 0.05)
        return
    end

    self:ShowAlert(unit, spellID, event, allEventsPlaySounds)
end

function mod:ShowAlert(unit, spellID, event, allEventsPlaySounds)
    local t = GetTime()
    local unitIsTarget = UnitIsUnit("target", unit)
    local level = BigWigsLoader.UnitLevel(unit)
    local throttleIndex = self:GetOption("custom_select_throttle_duration")
    local throttleDuration
    if unitIsTarget then -- don't throttle target
        throttleDuration = 0
    elseif throttleIndex == 1 then -- default (2s)
        throttleDuration = 2
    elseif throttleIndex == 2 then
        throttleDuration = 1
    else
        throttleDuration = 3
    end
    local throttleSoundsOnly = self:GetOption("custom_select_throttle_type") == 2
    if event == "UNIT_SPELLCAST_CHANNEL_START" and (level == STANDARD_LEVEL or level == LIEUTENANT_LEVEL) then -- channels
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
    elseif level == LIEUTENANT_LEVEL then -- lieutenant casts
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
    elseif level == STANDARD_LEVEL then -- standard casts
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
