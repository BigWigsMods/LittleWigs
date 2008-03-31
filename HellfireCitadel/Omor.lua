------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Omor the Unscarred"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Omor",

	aura = "Treacherous Aura", -- needs to be exactly what it's called in game.
	aura_heroic = "Bane of Treachery",
	aura_desc = "Announce who has the Trecherous Aura",
	aura_message = "%s has %s!",
	aura_message_you = "You have %s!",
	aura_bar = "%s: %s",

	icon = "Raid Icon",
	icon_desc = "Put a Raid Icon on the person who has the Treacherous Aura. (Requires promoted or higher)",
} end)

L:RegisterTranslations("frFR", function() return {
	aura = "Aura traîtresse",
	aura_heroic = "Plaie de traîtrise",
	aura_desc = "Préviens quand un joueur subit les effets de l'Aura/Plaie traîtresse.",
	aura_message = "%s a %s !",
	aura_bar = "%s : %s",

	icon = "Icône",
	icon_desc = "Place une icône de raid sur le dernier joueur affecté par l'Aura/Plaie traîtresse (nécessite d'être promu ou mieux).",
} end)

L:RegisterTranslations("koKR", function() return {
	aura = "배반의 오라",
	aura_heroic = "배반의 파멸",
	aura_desc = "배반의 오라에 걸린 플레이어를 알립니다.",
	aura_message = "%s: %s!",
	aura_message_you = "당신은 %s!",
	aura_bar = "%s: %s",

	icon = "전술 표시",
	icon_desc = "배반의 오라/파멸에 걸린 사람에게 전술 표시를 지정합니다. (승급자 이상 권한 요구)",
} end)

L:RegisterTranslations("zhCN", function() return {
	aura = "背叛光环",
	aura_heroic = "背叛者之祸",
	aura_desc = "当中了背叛光环发出警报。",
	aura_message = ">%s< 中了 %s！",
	aura_bar = "<%s：%s>",

	icon = "团队标记",
	icon_desc = "在中了背叛光环的队友头上标记。（需要团长或助理权限）",
} end)

L:RegisterTranslations("zhTW", function() return {
	aura = "奸詐光環",
	aura_heroic = "背叛之禍",
	aura_desc = "當有人中了奸詐光環時發出警報",
	aura_message = "%s 中了 %s!",
	aura_bar = "%s: %s",

	icon = "團隊標記",
	icon_desc = "在中了奸詐光環的隊友頭上標記（需要助理或領隊權限）",
} end)

L:RegisterTranslations("deDE", function() return {
	aura = "Verr\195\164terische Aura",
	aura_heroic = "Bann des Verrats",
	aura_desc = "Ank\195\188ndigung wer die Verr\195\164terische Aura hat",
	aura_message = "%s hat %s!",
	aura_bar = "%s: %s",

	icon = "Raid Symbol",
	icon_desc = "Setzt ein Raidsymbol auf die betroffene Person der Aura (Ben\195\182tigt h\195\182heren Status)",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod.zonename = BZ["Hellfire Ramparts"]
mod.enabletrigger = boss
mod.toggleoptions = {"aura", "icon", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Curse", 30695, 37566, 37567, 39298) -- verify 37566(Bane of Treachery) on heroic 
	self:AddCombatListener("SPELL_AURA_REMOVED", "CurseRemove", 30695, 37566, 37567, 39298) -- verify 37566(Bane of Treachery) on heroic
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Curse(player, spellId, _, _, spellName)
	if player and self.db.profile.aura then
		self:Message(L["aura_message"]:format(player, spellName), "Urgent", nil, nil, nil, spellId)
		self:Bar(fmt(L["aura_bar"], player, spellName), 15, spellId)
		self:Whisper(player, L["aura_message_you"]:format(spellName))
		if self.db.profile.icon then
			self:Icon(player)
		end	
	end
end

function mod:CurseRemove(player, spellId, _, _, spellName)
	self:TriggerEvent("BigWigs_RemoveRaidIcon")
	self:TriggerEvent("BigWigs_StopBar", self, L["aura_bar"]:format(player, spellName))
end
