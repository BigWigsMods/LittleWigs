------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Ley-Guardian Eregos"]

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Eregos",
	
	planarshift = "Planar Shift",
	planarshift_desc = "Warns for Planar Shift",

	planarshiftbar = "Planar Shift Bar",
	planarshiftbar_desc = "Display a bar for the duration of Planar Shift.",

	planarshift_message = "Planar Shift",
	planarshift_expire_message = "Planar Shift ends in 5 sec",
	
	enragedassault = "Enraged Assault",
	enragedassault_desc = "Warns for Enraged Assault",

	enragedassultbar = "Enraged Assult Bar",
	enragedassultbar_desc = "Display a bar for the duraction of Enraged Assult.",

	enragedassault_message = "Enraged Assault",
	
	log = "|cffff0000"..boss.."|r: This boss needs data, please consider turning on your /combatlog or transcriptor and submit the logs.",
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
	log = "|cffff0000"..boss.."|r: Для этого босса необходимы правильные данные. Пожалуйста, включите запись логов (команда /combatlog) или установите аддон transcriptor, и пришлите получившийся файл (или оставьте ссылку на файл в комментариях на curse.com).",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod.zonename = BZ["The Oculus"]
mod.enabletrigger = {boss} 
mod.guid = 27656
mod.toggleoptions = {"planarshift", "planarshiftbar", -1, "enragedassault", "enragedassult", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	BigWigs:Print(L["log"])
	self:AddCombatListener("SPELL_AURA_APPLIED", "PlanarShift", 51162)
	self:AddCombatListener("SPELL_AURA_APPLIED", "EnragedAssault", 51170)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:PlanarShift(_, spellId, _, _, spellName)
	if self.db.profile.planarshift then
		self:IfMessage(L["planarshift_message"], "Important", spellId)
		self:DelayedMessage(13, L["planarshift_expire_message"], "Attention")
	end
	if self.db.profile.planarshiftbar then
		self:Bar(spellName, 18, spellId)
	end
end

function mod:EnragedAssault(player, spellId, _, _, spellName)
	if self.db.profile.enragedassult then
		self:IfMessage(L["enragedassault_message"], "Important", spellId)
	end
	if self.db.profile.enragedassultbar then
		self:Bar(spellName, 12, spellId)
	end
end
