------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Keristrasza"]

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Keristrasza",

	chains = "Crystal Chains",
	chains_desc = "Warn when someone is in Crystal Chains.",
	chains_message = "%s: %s",

	chainsbar = "Crystal Chains Bar",
	chainsbar_desc = "Display a bar when a party member is in Cystal Chains.",

	enrage = "Enrage",
	enrage_desc = "Warn when Keristrasza becomes enraged.",
	enrage_message = "Keristrasza is Enraged",
} end )

L:RegisterTranslations("koKR", function() return {
	chains = "¼öÁ¤ °á°è",
	chains_desc = "¼öÁ¤ °á°è°¡ °É¸° ÇÃ·¹ÀÌ¾î¸¦ ¾Ë¸³´Ï´Ù.",
	chains_message = "%s: %s",

	chainsbar = "¼öÁ¤ °á°è ¹Ù",
	chainsbar_desc = "ÆÄÆ¼¿øÀÇ ¼öÁ¤ °á°è ¹Ù¸¦ Ç¥½ÃÇÕ´Ï´Ù.",

	enrage = "ºÐ³ë",
	enrage_desc = "ÄÉ¸®½ºÆ®¶óÀÚÀÇ ºÐ³ë¸¦ ¾Ë¸³´Ï´Ù.",
	enrage_message = "ÄÉ¸®½ºÆ®¶óÀÚ ºÐ³ë",
} end )

L:RegisterTranslations("frFR", function() return {
	chains = "Chaînes de cristal",
	chains_desc = "Prévient quand un joueur subit les effets des Chaînes de cristal.",
	chains_message = "%s : %s",

	chainsbar = "Chaînes de cristal - Barre",
	chainsbar_desc = "Affiche une barre quand un membre du groupe est prisonnier des Chaînes de cristal.",

	enrage = "Enrage",
	enrage_desc = "Prévient quand Keristrasza devient enragée.",
	enrage_message = "Keristrasza est enragée",
} end )

L:RegisterTranslations("zhTW", function() return {
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
} end )

L:RegisterTranslations("ruRU", function() return {
	chains = "Цепи",
	chains_desc = "Сообщает, когда кто-нибудь попадает в кристальные цепи.",
	chains_message = "%s: %s",

	chainsbar = "Полоса кристальных цепей",
	chainsbar_desc = "Отображать полосу, когда участник попадает в Кристальные цепи.",

	enrage = "Исступление",
	enrage_desc = "Предупреждать о стадии исступления Керистраза.",
	enrage_message = "Керистраза в исступлении",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod.zonename = BZ["The Nexus"]
mod.enabletrigger = {boss} 
mod.guid = 26723
mod.toggleoptions = {"chains", "chainsbar", "enrage", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Enrage", 8599)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Chains", 50997)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ChainsRemoved", 50997)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Chains(player, spellId, _, _, spellName)
	if self.db.profile.chains then
		self:IfMessage(L["chains_message"]:format(spellName, player), "Important", spellId)
	end
	if self.db.profile.chainsbar then
		self:Bar(L["chains_message"]:format(spellName, player), 10, spellId)
	end
end

function mod:ChainsRemoved(player, _, _, _, spellName)
	if self.db.profile.chainsbar then
		self:TriggerEvent("BigWigs_StopBar", self, L["chains_message"]:format(spellName, player))
	end
end

function mod:Enrage(_, spellId)
	if self.db.profile.enrage then
		self:IfMessage(L["enrage_message"], "Important", spellId)
	end
end

