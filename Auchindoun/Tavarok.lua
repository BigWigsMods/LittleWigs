------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Tavarok"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Tavarok",

	prison = "Crystal Prison",
	prison_desc = "Warn when someone is put in a Crystal Prison",
	prison_message = "Crystal Prison: %s",

	icon = "Raid Icon",
	icon_desc = "Place a Raid Icon on the player in a Crystal Prison(requires leader).",
} end )

L:RegisterTranslations("zhCN", function() return {
	prison = "水晶监牢",
	prison_desc = "当队友中了水晶监牢时发出警报。",
	prison_message = "水晶监牢：>%s<！",

	icon = "团队标记",
	icon_desc = "为中了水晶监牢的队友打上团队标记。（需要权限）",
} end )

L:RegisterTranslations("koKR", function() return {
	prison = "수정 감옥",
	prison_desc = "수정 감옥에 걸린 플레이어를 알립니다.",
	prison_message = "수정 감옥: %s",

	icon = "공격대 아이콘",
	icon_desc = "수정 감옥에 걸린 플레이어에게 전술 표시를 지정합니다. (승급자 이상 권한 요구)",
} end )

L:RegisterTranslations("frFR", function() return {
	prison = "Prison de cristal",
	prison_desc = "Prévient quand un joueur subit les effets de la Prison de cristal.",
	prison_message = "Prison de cristal : %s",

	icon = "Icône",
	icon_desc = "Place une icône de raid sur le dernier joueur affecté par la Prison de cristal (nécessite d'être promu ou mieux).",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = BZ["Mana-Tombs"]
mod.enabletrigger = boss 
mod.guid = 18343
mod.toggleoptions = {"prison", "icon", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Prison", 32361)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Prison(player, spellId)
	if self.db.profile.prison then
		self:IfMessage(L["prison_message"]:format(player), "Important", 32361)
	end
	self:Icon(player, "icon")
end
