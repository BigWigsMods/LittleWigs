------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Omor the Unscarred"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Omor",

	aura = "Treacherous Aura",
	aura_desc = "Announce who has the Trecherous Aura",
	aura_trigger1 = "^([^%s]+) ([^%s]+) afflicted by Treacherous Aura.",
	aura_trigger2 = "^([^%s]+) ([^%s]+) afflicted by Bane of Treachery.",
	aura_warning = "%s has Treacherous Aura!",
	aura_bar = "%s: Treacherous Aura",

	icon = "Raid Icon",
	icon_desc = "Put a Raid Icon on the person who has the Treacherous Aura. (Requires promoted or higher)",
} end)

L:RegisterTranslations("frFR", function() return {
	aura = "Aura traîtresse",
	aura_desc = "Préviens quand un joueur subit les effets de l'Aura traîtresse.",
	aura_trigger = "^([^%s]+) ([^%s]+) les effets .* Aura traîtresse.",
	aura_warning = "%s a l'Aura traîtresse !",
	aura_bar = "%s : Aura traîtresse",

	icon = "Icône",
	icon_desc = "Place une icône de raid sur le dernier joueur affecté par l'Aura traîtresse (nécessite d'être promu ou mieux).",
} end)

L:RegisterTranslations("koKR", function() return {
	aura = "배반의 오라 ",
	aura_desc = "배반의 오라에 걸린 사람을 알립니다.",
	aura_trigger = "^([^|;%s]*)(.*)배반의 오라에 걸렸습니다%.$",
	aura_warning = "%s에게 배반의 오라!",
	aura_bar = "%s: 배반의 오라",

	icon = "전술 표시",
	icon_desc = "배반의 오라에 걸린 사람에게 전술 표시를 지정합니다. (승급자 이상 권한 요구)",
} end)
--Chinese Translation: 月色狼影@CWDG
--CWDG site: http://Cwowaddon.com
--无疤者奥摩尔
L:RegisterTranslations("zhCN", function() return {
	aura = "背叛光环",
	aura_desc = "当中了背叛光环发出警报",
	aura_trigger = "^([^%s]+)受([^%s]+)了背叛光环效果的影响",
	aura_warning = "%s 中了背叛光环!",
	aura_bar = "%s: 背叛光环",

	icon = "团队标记",
	icon_desc = "当中了背叛光环，用团队标记标上 (需要团长或助理权限)",
} end)

L:RegisterTranslations("zhTW", function() return {
	aura = "背叛之禍",
	aura_desc = "當有人中了背叛之禍時發出警報",
	aura_trigger = "^(.+)受到(.*)背叛之禍",
	aura_warning = "%s 中了背叛之禍！",
	aura_bar = "%s: 背叛之禍",

	icon = "團隊標記",
	icon_desc = "在中了背叛之禍的隊友頭上標記（需要助理或領隊權限）",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod.zonename = AceLibrary("Babble-Zone-2.2")["Hellfire Ramparts"]
mod.enabletrigger = boss
mod.toggleoptions = {"aura", "icon", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Event(msg)
	if msg:find(L["aura_trigger1"]) then
		local player, type = select(3, msg:find(L["aura_trigger1"]))
	end
	if msg:find(L["aura_trigger2"]) then
		local player, type = select(3, msg:find(L["aura_trigger2"]))
	end
	if player and type then
		if player == L2["you"] and type == L2["are"] then
			player = UnitName("player")
		end
		self:Message(L["aura_warning"]:format(player), "Attention")
		self:Bar(L["aura_bar"]:format(player), 15, "Spell_Shadow_DeadofNight", "Red")
	end
end
