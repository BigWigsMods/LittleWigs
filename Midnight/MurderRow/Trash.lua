--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Murder Row Trash", 2813)
if not mod then return end
mod:SetTrashModule(true)

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
-- Renames
--

mod:SetRenames({
	[1218508] = {1218508}, -- Disguised
})

--------------------------------------------------------------------------------
-- Auras
--

mod:SetAuraData({
	{1216300, header = 236073, dispel = "bleed", mechanic = "bleeding", tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1216300))}, -- Cutpurse (Row Hooligan)
	{1216529, header = 252529, soundOnAppliedDose = "none", tip = CL.debuffTankAfterCastNote:format(mod:SpellName(1216529))}, -- Shield Bash (Bribed Captain)
	{1295035, dispel = "bleed", tip = CL.debuffTankAfterCastNote:format(mod:SpellName(1295035))}, -- Glaive Toss (Bribed Captain)
	{1216590, header = 236091, dispel = "poison", soundOnAppliedDose = "none", tip = CL.debuffTankAfterCastNote:format(mod:SpellName(1216590))}, -- Heartstop Poison (Street Sneak)
	{1217633, header = 236902, dispel = "magic", soundOnAppliedDose = "none", tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1217633))}, -- Corroding Spittle (Massive Felwyrm)
	{1218508, header = 263940, soundOnApplied = "info"}, -- Disguised (Belath Dawnblade)
	{1311136, header = 236893, dispel = "bleed", soundOnAppliedDose = "none", tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1311136))}, -- Sharp Nail (Warehouse Worker)
	{1217973, header = 235265, dispel = "curse", soundOnApplied = "alarm", tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1217973))}, -- Curse of Doom (Corrupted Warlock)
	{1295427, header = 235267, dispel = "bleed", tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1295427))}, -- Flay (Wrathguard Flayer)
	{1218187, header = 235322, tip = CL.debuffGroupAfterCastNote:format(mod:SpellName(1218187))}, -- Fel Beam (Defiled Golem)
	{1215985, tip = CL.debuffUnderYouNote}, -- Fel Beam (Defiled Golem)
	{1294870, soundOnApplied = "underyou", tip = CL.debuffUnderYouNote}, -- Fel-Scarred Earth (Defiled Golem)
})

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(true)
function mod:GetOptions()
	return {
		autotalk,
		"snitches_interrogated",
		1218508, -- Disguised
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
		if self:GetGossipID(131567) then -- Get disguise (Belath Dawnblade)
			-- 131567:I'm ready for my disguise.
			self:SelectGossipID(131567)
			self:PersonalMessage(1218508) -- Disguised
			self:PlaySound(1218508, "info") -- Disguised
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
