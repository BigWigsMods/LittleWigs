------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Meathook"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Meathook",
	chains = "Constricting Chains",
	chains_desc = "Warn who is in the Constricting Chains.",

	chainsBar = "Constricting Chains Bar",
	chainsBar_desc = "Display a bar for the duration someone is in the Constricting Chains.",

	chains_message = "Chains: %s",
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
	chains = "Удушающие оковы",
	chains_desc = "Сообщать кто затачен в оковы.",

	chainsBar = "Полоса удушающих оков",
	chainsBar_desc = "Отображать полосу продолжительности удушающих оков если в них кто либо затачен.",

	chains_message = "Оковы: %s",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod.zonename = BZ["The Culling of Stratholme"]
mod.enabletrigger = boss 
mod.guid = 26529
mod.toggleoptions = {"chains", "chainsBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Chains", 52696, 58823)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Chains(player, spellId)
	if self.db.profile.chains then
		self:IfMessage(L["chains_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.chainsBar then
		self:Bar(L["chains_message"]:format(player), 5, spellId)
	end
end
