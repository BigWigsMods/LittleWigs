--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Murder Row Trash", 2813)
if not mod then return end
mod:SetTrashModule(true)
mod:SetAuraData({
	{1216300}, -- Cutpurse
	{1216529}, -- Shield Bash
	{1295035}, -- Glaive Toss
	{1217633}, -- Corroding Spittle
	{1216590}, -- Heartstop Poison
	{1311136}, -- Sharp Nail
	{1218508}, -- Disguised
	{1295427}, -- Flay
	{1217973, soundOnApplied = "alarm"}, -- Curse of Doom
	{1218187}, -- Fel Beam
	{1294870, soundOnApplied = "underyou"}, -- Fel-Scarred Earth
})

--------------------------------------------------------------------------------
-- Localization
--

mod:SetDefaultLocale({
	snitches_interrogated = "Snitches Interrogated",
	snitches_interrogated_desc = "Show an alert when a snitch has been interrogated.",
	snitches_interrogated_icon = "ui_chat",
})

--------------------------------------------------------------------------------
-- Locals
--

local lastText

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(true)
function mod:GetOptions()
	return {
		autotalk,
		"snitches_interrogated",
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Snitches Interrogated
	self:RegisterWidgetEvent(7571, "SnitchesInterrogated", true)
end

function mod:OnBossDisable()
	lastText = nil
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(131567) then -- Disguise (Belath Dawnblade)
			-- 131567:I'm ready for my disguise.
			self:SelectGossipID(131567)
		elseif self:GetGossipID(131502) then -- Clock in (Selenar Sunshy)
			-- 131502:<Clock in.>
			self:SelectGossipID(131502)
		end
	end
end

function mod:SnitchesInterrogated(_, text)
	-- [UPDATE_UI_WIDGET] widgetID:7571, widgetType:8, text:|TInterface\\ICONS\\UI_Chat.BLP:20|t Snitches interrogated: 1/4
	local acquired = text:match("(%d+)/%d+")
	if acquired and tonumber(acquired) > 0 and text ~= lastText then
		lastText = text
		self:Message("snitches_interrogated", "green", text, false)
		self:PlaySound("snitches_interrogated", "info")
	end
end
