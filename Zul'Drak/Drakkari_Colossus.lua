------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Drakkari Colossus"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Drakkari",

	emerge = "Emerge",
	emerge_desc = "Warn when the Elemental is emerging from the Colossus.",
	emerge_message = "Elemental Emerging",

	merge = "Merge",
	merge_desc = "Warn when the Elemental is merging back into the Colossus.",
	merge_message = "Merging with Colossus",
} end )

L:RegisterTranslations("koKR", function() return {
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
mod.guid = 29307
mod.toggleoptions = {"bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Emerge", 54850) -- To Elemental
	self:AddCombatListener("SPELL_CAST_START", "Merge", 54878) -- To Colossus
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Emerge(_, spellId)
	if self.db.profile.emerge then
		self:IfMessage(L["emerge_message"], "Urgent", spellId)
	end
end

function mod:Merge(_, spellId)
	if self.db.profile.merge then
		self:IfMessage(L["merge_message"], "Urgent", spellId)
	end
end
