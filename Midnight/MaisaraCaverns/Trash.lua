--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Maisara Caverns Trash", 2874)
if not mod then return end
mod:SetTrashModule(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.prisoners_freed = "Prisoners Freed"
	L.prisoners_freed_desc = "Show an alert when a prisoner has been freed."
	L.prisoners_freed_icon = "achievement_character_troll_female"
	L.custom_on_cooking_pot_autotalk = CL.autotalk
	L.custom_on_cooking_pot_autotalk_desc = "Automatically select the NPC dialog option to grant the 'Hearty Vilebranch Stew' buff.\n\n|T4659336:16|tHearty Vilebranch Stew\n{1269056}"
	L.custom_on_cooking_pot_autotalk_icon = mod:GetMenuIcon("SAY")
	L.custom_on_ritual_cauldron_autotalk = CL.autotalk
	L.custom_on_ritual_cauldron_autotalk_desc = "Automatically select the NPC dialog option to grant the 'Ritual Concoction' buff.\n\n|T236271:16|tRitual Concoction\n{1271300}"
	L.custom_on_ritual_cauldron_autotalk_icon = mod:GetMenuIcon("SAY")

	L.cooking_pot = "Cooking Pot"
	L.ritual_cauldron = "Ritual Cauldron"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"prisoners_freed",
		"custom_on_cooking_pot_autotalk",
		"custom_on_ritual_cauldron_autotalk",
	}, nil, {
		["custom_on_cooking_pot_autotalk"] = L.cooking_pot,
		["custom_on_ritual_cauldron_autotalk"] = L.ritual_cauldron,
	}
end

function mod:OnBossEnable()
	-- Prisoners Freed
	self:RegisterWidgetEvent(7550, "PrisonersFreed", true)

	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PrisonersFreed(_, text)
	-- [UPDATE_UI_WIDGET] widgetID:7550, widgetType:8, text:Prisoners Freed: 2/8
	local freed, total = text:match("(%d+)/(%d+)")
	if freed and total and tonumber(freed) <= tonumber(total) then
		self:Message("prisoners_freed", "green", text, L.prisoners_freed_icon)
		self:PlaySound("prisoners_freed", "info")
	end
end

function mod:GOSSIP_SHOW()
	if self:GetGossipID(137387) and self:GetOption("custom_on_cooking_pot_autotalk") then -- Cooking Pot: Hearty Vilebranch Stew (1269056)
		-- 137387:Have some stew!
		self:SelectGossipID(137387)
	elseif self:GetGossipID(137428) and self:GetOption("custom_on_ritual_cauldron_autotalk") then -- Ritual Cauldron: Ritual Concoction (1271300)
		-- 137428:<Dip your weapon in the fluid.>
		self:SelectGossipID(137428)
	end
end
