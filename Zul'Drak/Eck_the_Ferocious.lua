------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Eck the Ferocious"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local pName = UnitName("player")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Eck",

	residue = "Eck Residue (Achievement)",
	residue_desc = "Announce when you have the Eck Residue debuff.",
	residue_message = "Eck Residue on You",
} end )

L:RegisterTranslations("koKR", function() return {
	residue = "엑크 잔류물 (업적)",
	residue_desc = "엑크 잔류뮬 디버프 획득에 대해 알립니다.",
	residue_message = "당신은 엑크 잔류물",
} end )

L:RegisterTranslations("frFR", function() return {
} end )

L:RegisterTranslations("zhTW", function() return {
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
} end )

L:RegisterTranslations("ruRU", function() return {
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod.zonename = BZ["Gundrak"]
mod.enabletrigger = boss 
mod.guid = 29932
mod.toggleoptions = {"residue", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Residue", 55817)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Residue(player, spellId)
	if self.db.profile.residue and player == pName then
		self:LocalMessage(L["residue_message"], "Positive", spellId, "Info")
	end
end
