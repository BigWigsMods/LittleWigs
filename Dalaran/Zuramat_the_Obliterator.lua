------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Zuramat the Obliterator"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Zuramat",

	voidShift = "Void Shift",
	voidShift_desc = "Warn when someone has Void Shift.",
	voidShift_you = "Void Shift on YOU!",
	voidShift_other = "Void Shift: %s",

	voidShiftBar = "Void Shift Bar",
	voidShiftBar_desc = "Display a bar for the duration of Void Shift.",

	darkness = "Shroud of Darkness",
	darkness_desc = "Warns for Shroud of Darkness.",
	darkness_message = "Shroud of Darkness",
} end )

L:RegisterTranslations("koKR", function() return {
	voidShift = "공허의 전환",
	voidShift_desc = "공허의 전환에 걸린 플레이어를 알립니다.",
	voidShift_you = "당신은 공허의 전환!!",
	voidShift_other = "공허의 전환: %s",

	voidShiftBar = "공허의 전환 바",
	voidShiftBar_desc = "공허의 전환이 지속되는 바를 표시합니다.",

	darkness = "어둠의 수의",
	darkness_desc = "어둠의 수의에 대해 알립니다.",
	darkness_message = "어둠의 수의 - dps 그만!",
} end )

L:RegisterTranslations("frFR", function() return {
	voidShift = "Passage dans le Vide",
	voidShift_desc = "Prévient quand un joueur subit les effets du Passage dans le Vide.",
	voidShift_you = "Passage dans le Vide sur VOUS !",
	voidShift_other = "Passage dans le Vide : %s",

	voidShiftBar = "Passage dans le Vide - Barre",
	voidShiftBar_desc = "Affiche une barre indiquant la durée du Passage dans le Vide.",

	darkness = "Voile de ténèbres",
	darkness_desc = "Prévient quand un Voile de ténèbres est incanté.",
	darkness_message = "Voile de ténèbres",
} end )

L:RegisterTranslations("zhTW", function() return {
	voidShift = "虛空移形",
	voidShift_desc = "當玩家中了虛空移形時發出警報。",
	voidShift_you = ">你< 虛空移形！",
	voidShift_other = "虛空移形：>%s<！",

	voidShiftBar = "虛空移形計時條",
	voidShiftBar_desc = "當虛空移形持續時顯示計時條。",

	darkness = "黑暗障蔽",
	darkness_desc = "當施放黑暗障蔽時發出警報。",
	darkness_message = "黑暗障蔽！",
} end )

L:RegisterTranslations("deDE", function() return {
	voidShift = "Leerenverschiebung",
	voidShift_desc = "Warnung wenn jemand von Leerenverschiebung betroffen ist.",
	voidShift_you = "Leerenverschiebung auf DIR!",
	voidShift_other = "Leerenverschiebung: %s",

	voidShiftBar = "Leerenverschiebung-Anzeige",
	voidShiftBar_desc = "Eine Leiste f\195\188r die Dauer von Leerenverschiebung anzeigen.",

	darkness = "Umh\195\188llung der Dunkelheit",
	darkness_desc = "Warnung f\195\188r Umh\195\188llung der Dunkelheit.",
	darkness_message = "Umh\195\188llung der Dunkelheit",
} end )

L:RegisterTranslations("zhCN", function() return {
	voidShift = "虚空转移",
	voidShift_desc = "当玩家中了虚空转移时发出警报。",
	voidShift_you = ">你< 虚空转移！",
	voidShift_other = "虚空转移：>%s<！",

	voidShiftBar = "虚空转移计时条",
	voidShiftBar_desc = "当虚空转移持续时显示计时条。",

	darkness = "黑暗遮蔽",
	darkness_desc = "当施放黑暗遮蔽时发出警报。",
	darkness_message = "黑暗遮蔽！",
} end )

L:RegisterTranslations("ruRU", function() return {
	voidShift = "Вхождение в Бездну",
	voidShift_desc = "Предупреждать когда ктонибуть Вхождит в Бездну.",
	voidShift_you = "Вхождение в Бездну на ВАС!",
	voidShift_other = "Вхождение в Бездну на: %s",
	
	voidShiftBar = "Полоса Вхождения в Бездну",
	voidShiftBar_desc = "Отображать полосу продолжительности Вхождения в Бездну.",
	
	darkness = "Покров Тьмы",
	darkness_desc = "Предупреждать о Покрове Тьмы.",
	darkness_message = "Покров Тьмы!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod.zonename = BZ["The Violet Hold"]
mod.enabletrigger = boss 
mod.guid = 29314
mod.toggleoptions = {"voidShift", "voidShiftBar", -1, "darkness", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "VoidShift", 54361, 59743)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Darkness", 54524, 59745)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:VoidShift(player, spellId)
	if self.db.profile.voidShift then
		local other = L["voidShift_other"]:format(player)
		if player == pName then
			self:Message(L["voidShift_you"], "Personal", true, "Alert", nil, spellId)
			self:Message(other, "Attention", nil, nil, true)
		else
			self:Message(other, "Attention", nil, nil, nil, spellId)
			self:Whisper(player, L["voidShift_you"])
		end
		self:Icon(player, "icon")
		if self.db.profile.voidShiftBar then
			self:Bar(other, 15, spellId)
		end
	end
end

function mod:Darkness(_, spellId)
	if self.db.profile.darkness then
		self:IfMessage(L["darkness_message"], "Important", spellId)
	end
end
