--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Den of Nalorakk Trash", 2825)
if not mod then return end
mod:SetTrashModule(true)

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
	[1252825] = {1252825, CL.cast:format(mod:SpellName(1252825)), notes = {CL.generalNote, CL.castTimerNote}, original = {1252825, CL.cast:format(mod:SpellName(1252825))}},
})

--------------------------------------------------------------------------------
-- Auras
--

mod:SetAuraData({
	{1239428, header = mod:SpellName(1239428)}, -- Carrying Supplies (environmental)
	{1238439, header = 241816, duration = 10, dispel = "bleed", mechanic = "bleeding", soundOnAppliedDose = "none", note = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1238439))}, -- Razor Dive (Keen-Eyed Striker)
	{1238801, header = 245567, duration = 25, dispel = "curse", soundOnAppliedDose = "none", note = CL.debuffGroupAfterCastNote:format(mod:SpellName(1238801))}, -- Insatiable Hunger (Starvation Effigy)
	{1238687, header = 245855, duration = 5, note = CL.debuffGroupAfterCastNote:format(mod:SpellName(1238725))}, -- Feast of Misery (Spirit of Hunger)
	{1297701, header = 241813, soundOnApplied = "underyou", note = CL.debuffUnderYouNote}, -- Rotten Ground (Thornclaw Gatherer)
	{1241217, soundOnAppliedDose = "none", note = CL.debuffTankAfterCastNote:format(mod:SpellName(1241217))}, -- Shredding Claws (Thornclaw Gatherer)
	{1252825, header = mod:SpellName(1252825), note = CL.debuffFailureSafeZoneNote}, -- Harsh Winds (environmental)
	{1233904, soundOnApplied = "info"}, -- Sheltered (environmental)
	{1266193, header = 241876, note = CL.debuffWalkIntoObjectNote:format(mod:SpellName(1235841))}, -- Snowdrift (Glacial Revenant)
	{1239860, duration = 10, dispel = "magic", note = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1239860))}, -- Cryo Surge (Glacial Revenant)
	{1241464, header = 241869, mechanic = "rooted", note = CL.debuffGroupAfterCastNote:format(mod:SpellName(1241464))}, -- Glacial Tomb (Avatar of Determination)
	{1309919, header = 241872, duration = 15, mechanic = "snared", soundOnAppliedDose = "none", note = CL.debuffFailureInterruptNote:format(mod:SpellName(1309919))}, -- Frigid Roar (Frigid Mauler)
	{1309964, header = 250478, note = CL.debuffUnderYouNote}, -- Harsh Winter (The Winter Squall)
	{1246957, header = 245146, duration = 3, soundOnAppliedDose = "none", note = CL.debuffGroupAfterCastNote:format(mod:SpellName(1246957))}, -- Primal Echo (Grizzled Warbringer)
	{1247367, header = 244889, soundOnApplied = "underyou", note = CL.debuffUnderYouNote}, -- Earthquake (Loa Speaker Nanea)
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
		{1252825, "CASTBAR"}, -- Harsh Winds
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Offerings Acquired
	self:RegisterWidgetEvent(7092, "OfferingsAcquired")

	-- Harsh Winds
	self:RegisterEvent("ENCOUNTER_WARNING")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(135009) then -- Interact with Ethereal Pyre to start the dungeon (at the very beginning).
			-- 135009:<Meditate on the sound of the flames.>
			self:SelectGossipID(135009)
		elseif self:GetGossipID(135010) then -- Interact with Ethereal Pyre to continue the dungeon (after Sentinel of Winter).
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

-- Offerings Acquired

function mod:OfferingsAcquired(_, text)
	-- [UPDATE_UI_WIDGET] widgetID:7092, widgetType:8, text:|TInterface\\ICONS\\inv_misc_coinbag09.blp:20|t Offerings Acquired: 1/6
	local acquired = text:match("(%d+)/%d+")
	if acquired and tonumber(acquired) > 0 then
		self:Message("offerings_acquired", "green", text, false)
		self:PlaySound("offerings_acquired", "info")
	end
end

-- Harsh Winds

function mod:ENCOUNTER_WARNING(_, info) -- Harsh Winds
	if info.severity == 2 and not self:IsAnyEncounterInProgress() and BigWigsLoader.GetAreaInfo(16390) == GetSubZoneText() then -- Enduring Winter
		self:CastBar(1252825, 3.9, 2) -- <Cast: Harsh Winds>
		self:ScheduleTimer(function()
			self:StopBar(self:GetRename(1252825, 2)) -- <Cast: Harsh Winds>
			self:Bar(1252825, 10.1, self:GetRename(1252825)) -- Harsh Winds
		end, 3.9)
	end
end
