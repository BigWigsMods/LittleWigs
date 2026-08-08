if not BigWigsLoader.isNext then return end -- XXX 12.1
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Generic Trash", {2813, 2825, 2859, 2923, 2993, 2521, 1877, 1762}) -- S2 dungeons
if not mod then return end
mod:SetTrashModule(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
    L.generic_trash = "Generic Trash"
	L.trash_cast = "Trash Cast"
	L.trash_cast_desc = "Alert when a standard trash mob casts a spell."
	L.lieutenant_cast = "Trash Cast (Lieutenant)"
	L.lieutenant_cast_desc = "Alert when a Lieutenant trash mob casts a spell."
	L.trash_channel = "Trash Channel"
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
	L.custom_select_throttle_duration_desc = "Trash alert throttle in seconds. Your target is never throttled."
	L.custom_select_throttle_duration_value1 = 2
	L.custom_select_throttle_duration_value2 = 1
	L.custom_select_throttle_duration_value3 = 3
end

--------------------------------------------------------------------------------
-- Locals
--

local castsPerUnit = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.generic_trash
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
    local customSelectUnit = self:GetOption("custom_select_unit") -- 1 = all, 2 = all message, target sound, 3 = target
    if customSelectUnit == 3 then -- target only
        if unit ~= "target" then return end
    else -- only nameplate units (trash mobs)
        if not unit:find("^nameplate") then return end
    end

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
                self:ShowAlert(unit, spellID, event, customSelectUnit)
            end
        end, 0)
        return
    end
    self:ShowAlert(unit, spellID, event, customSelectUnit)
end

function mod:ShowAlert(unit, spellID, event, customSelectUnit)
    local t = GetTime()
    local unitIsTarget = UnitIsUnit("target", unit)
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
    if event == "UNIT_SPELLCAST_CHANNEL_START" and BigWigsLoader.UnitLevel(unit) ~= 92 then
        local throttlePassed = t - prevChannel > throttleDuration
        if throttleSoundsOnly or throttlePassed then
            self:SecretMessage("trash_channel", "yellow", spellID)
        end
        if throttlePassed then
            prevChannel = t
            if unitIsTarget or customSelectUnit ~= 2 then
                self:PlaySound("trash_channel", "info")
            end
        end
    elseif BigWigsLoader.UnitLevel(unit) == 91 then
        local throttlePassed = t - prevLieutenant > throttleDuration
        if throttleSoundsOnly or throttlePassed then
            self:SecretMessage("lieutenant_cast", "orange", spellID)
        end
        if throttlePassed then
            prevLieutenant = t
            if unitIsTarget or customSelectUnit ~= 2 then
                self:PlaySound("lieutenant_cast", "alarm")
            end
        end
    elseif BigWigsLoader.UnitLevel(unit) == 90 then
        local throttlePassed = t - prevCast > throttleDuration
        if throttleSoundsOnly or throttlePassed then
            self:SecretMessage("trash_cast", "red", spellID)
        end
        if throttlePassed then
            prevCast = t
            if unitIsTarget or customSelectUnit ~= 2 then
                self:PlaySound("trash_cast", "alert")
            end
        end
    end
end
