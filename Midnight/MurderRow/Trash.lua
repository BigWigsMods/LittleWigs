--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Murder Row Trash", 2813)
if not mod then return end
mod:SetTrashModule(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.snitches_interrogated = "Snitches Interrogated"
	L.snitches_interrogated_desc = "Show an alert when a snitch has been interrogated."
	L.snitches_interrogated_icon = "ui_chat"
end

--------------------------------------------------------------------------------
-- Locals
--

local lastText

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"snitches_interrogated",
	}
end

function mod:OnBossEnable()
	-- Snitches Interrogated
	self:RegisterWidgetEvent(7571, "SnitchesInterrogated", true)
end

function mod:OnBossDisable()
	lastText = nil
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SnitchesInterrogated(_, text)
	-- [UPDATE_UI_WIDGET] widgetID:7571, widgetType:8, text:|TInterface\\ICONS\\UI_Chat.BLP:20|t Snitches interrogated: 1/4
	local acquired = text:match("(%d+)/%d+")
	if acquired and tonumber(acquired) > 0 and text ~= lastText then
		lastText = text
		self:Message("snitches_interrogated", "green", text, false)
		self:PlaySound("snitches_interrogated", "info")
	end
end
