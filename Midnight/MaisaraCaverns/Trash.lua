--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Maisara Caverns Trash", 2874)
if not mod then return end
mod.displayName = CL.trash

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.prisoners_freed = "Prisoners Freed"
	L.prisoners_freed_desc = "Show an alert when a prisoner has been freed."
	L.prisoners_freed_icon = "achievement_character_troll_female"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"prisoners_freed",
	}
end

function mod:OnBossEnable()
	-- Prisoners Freed
	self:RegisterWidgetEvent(7550, "PrisonersFreed", true)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PrisonersFreed(_, text)
	-- [UPDATE_UI_WIDGET] widgetID:7550, widgetType:8, text:Prisoners Freed: 2/8
	self:Message("prisoners_freed", "green", text, L.prisoners_freed_icon)
	self:PlaySound("prisoners_freed", "info")
end
