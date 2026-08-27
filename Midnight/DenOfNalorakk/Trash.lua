--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Den of Nalorakk Trash", 2825)
if not mod then return end
mod:SetTrashModule(true)
mod:SetAuraData({
	{1239428}, -- Carrying Supplies
	{1238439, soundOnAppliedDose = "none"}, -- Razor Dive
	{1238801}, -- Insatiable Hunger
	{1238687}, -- Feast of Misery
	{1297701, soundOnApplied = "underyou", note = CL.debuffUnderYouNote}, -- Rotten Ground
	{1241217, soundOnAppliedDose = "none"}, -- Shredding Claws
	{1252825}, -- Harsh Winds
	{1233904, soundOnApplied = "info"}, -- Sheltered
	{1266193}, -- Snowdrift
	{1241464}, -- Glacial Tomb
	{1309919}, -- Frigid Roar
	{1309964}, -- Harsh Winter
	{1246957}, -- Primal Echo
	{1247367, soundOnApplied = "underyou", note = CL.debuffUnderYouNote}, -- Earthquake
})

--------------------------------------------------------------------------------
-- Localization
--

mod:SetDefaultLocale({
	offerings_acquired = "Offerings Acquired",
	offerings_acquired_desc = "Show an alert when an offering has been acquired.",
	offerings_acquired_icon = "inv_misc_coinbag09",
})

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1271545] = {CL.casting:format(CL.on_group:format(mod:SpellName(1271545))), original = {CL.casting:format(CL.on_group:format(mod:SpellName(1271545)))}}, -- Warding Incense
})

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(true)
function mod:GetOptions()
	return {
		autotalk,
		1271545, -- Warding Incense
		"offerings_acquired",
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Offerings Acquired
	self:RegisterWidgetEvent(7092, "OfferingsAcquired")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(135009) then -- Interact with Ethereal Pyre to start the dungeon.
			-- 135009:<Meditate on the sound of the flames.>
			self:SelectGossipID(135009)
		elseif self:GetGossipID(135010) then -- Interact with Ethereal Pyre to continue the dungeon.
			-- 135010:<Meditate on the sound of the flames.>
			self:SelectGossipID(135010)
		elseif self:GetGossipID(137694) then -- Warding Incense (Versatility buff)
			-- 137694:<You light the incense, its aroma fortifying the resolve of nearby allies.>\r\n\r\n[Requires at least 25 skill in Midnight Alchemy or Druid Bear Form.]
			self:SelectGossipID(137694)
			self:Message(1271545, "green", self:GetRename(1271545))
			self:PlaySound(1271545, "info")
		end
	end
end

function mod:OfferingsAcquired(_, text)
	-- [UPDATE_UI_WIDGET] widgetID:7092, widgetType:8, text:|TInterface\\ICONS\\inv_misc_coinbag09.blp:20|t Offerings Acquired: 1/6
	local acquired = text:match("(%d+)/%d+")
	if acquired and tonumber(acquired) > 0 then
		self:Message("offerings_acquired", "green", text, false)
		self:PlaySound("offerings_acquired", "info")
	end
end
