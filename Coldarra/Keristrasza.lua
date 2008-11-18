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
	chains = "수정 결계",
	chains_desc = "수정 결계가 걸린 플레이어를 알립니다.",
	chains_message = "%s: %s",

	chainsbar = "수정 결계 바",
	chainsbar_desc = "파티원의 수정 결계 바를 표시합니다.",

	enrage = "분노",
	enrage_desc = "케리스트라자의 분노를 알립니다.",
	enrage_message = "케리스트라자 분노",
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
	chains = "水晶之鍊",
	chains_desc = "當玩家中了水晶之鍊時發出警報。",
	chains_message = "%s：%s！",

	chainsbar = "水晶之鍊計時條",
	chainsbar_desc = "當玩家中了水晶之鍊時顯示計時條。",

	enrage = "狂怒",
	enrage_desc = "當凱瑞史卓莎狂怒時發出警報。",
	enrage_message = "凱瑞史卓莎 - 狂怒！",
} end )

L:RegisterTranslations("deDE", function() return {
	chains = "Kristallketten",
	chains_desc = "Warnt, wenn jemand in den Kristallketten ist.",
	chains_message = "%s: %s",

	chainsbar = "Kristallketten Bar",
	chainsbar_desc = "Display a bar when a party member is in Cystal Chains.",

	enrage = "Wutanfall",
	enrage_desc = "Warnt wenn Keristrasza Wutanfall bekommt.",
	enrage_message = "Keristrasza ist wütend",
} end )

L:RegisterTranslations("zhCN", function() return {
	chains = "水晶锁链",
	chains_desc = "当玩家中了水晶锁链时发出警报。",
	chains_message = "%s：%s！",

	chainsbar = "水晶锁链计时条",
	chainsbar_desc = "当玩家中了水晶锁链时显示计时条。",

	enrage = "激怒",
	enrage_desc = "当克莉斯塔萨激怒时发出警报。",
	enrage_message = "克莉斯塔萨 - 激怒！",
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

