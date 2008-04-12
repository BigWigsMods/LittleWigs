------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Blackheart the Inciter"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Blackheart",

	chaos = "Incite Chaos Bar",
	chaos_desc = "Display a bar for the duration of the Incite Chaos",
} end )

L:RegisterTranslations("zhCN", function() return {
	chaos = "煽动混乱计时条",
	chaos_desc = "显示煽动混乱计时条。",
} end )

L:RegisterTranslations("koKR", function() return {
	chaos = "혼돈 유발 바",
	chaos_desc = "혼돈 유발의 지속 시간에 대한 바를 표시합니다.",
} end )

L:RegisterTranslations("frFR", function() return {
	chaos = "Barre Provoquer le chaos",
	chaos_desc = "Affiche une barre indiquant la durée de Provoquer le chaos.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = BZ["Shadow Labyrinth"]
mod.enabletrigger = boss 
mod.toggleoptions = {"chaos", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Chaos", 33676)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Chaos(_, spellId, _, _, spellName)
	if self.db.profile.chaos then
		self:Bar(spellName, 15, spellId)
	end
end
