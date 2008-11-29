------------------------------
--      Are you local?      --
------------------------------

local boss = BB["King Ymiron"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Ymiron",

	bane = "Bane",
	bane_desc = "Warn for the casting of Bane.",
	bane_message = "Casting Bane",
	bane_ended = "Bane Fades",

	baneBar = "Bane Bar",
	baneBar_desc = "Display a bar for the duration of the Bane buff.",

	rot = "Fetid Rot",
	rot_desc = "Warn when some recieves the Fetid Rot debuff.",
	rot_message = "%s: %s",

	rotBar = "Fetid Rot Bar",
	rotBar_desc = "Show a bar for the duration of Fetid Rot.",
} end )

L:RegisterTranslations("koKR", function() return {
	bane = "파멸",
	bane_desc = "파멸 시전을 알립니다.",
	bane_message = "파멸 시전",
	bane_ended = "파멸 사라짐",

	baneBar = "파멸 바",
	baneBar_desc = "파멸 버프가 지속되는 바를 표시합니다.",

	rot = "악취나는 부패",
	rot_desc = "악취나는 부패 디버프에 걸린 플레이어를 알립니다.",
	rot_message = "%s: %s",

	rotBar = "악취나는 부패 바",
	rotBar_desc = "악취나는 부패가 지속되는 바를 표시합니다.",
} end )

L:RegisterTranslations("frFR", function() return {
	bane = "Plaie",
	bane_desc = "Prévient quand Ymiron incante Plaie.",
	bane_message = "Plaie en incantation",

	baneBar = "Plaie - Barre",
	baneBar_desc = "Affiche une barre indiquant la durée de la Plaie.",

	rot = "Pourriture fétide",
	rot_desc = "Prévient quand un joueur subit les effets de la Pourriture fétide.",
	rot_message = "%s : %s",

	rotBar = "Pourriture fétide - Barre",
	rotBar_desc = "Affiche une barre indiquant la durée de la Pourriture fétide.",
} end )

L:RegisterTranslations("zhTW", function() return {
	bane = "災禍",
	bane_desc = "當施放災禍時發出警報。",
	bane_message = "正在施放 災禍！",
	bane_ended = "災禍 消失！",

	baneBar = "災禍計時條",
	baneBar_desc = "當災禍持續時顯示計時條。",

	rot = "惡臭腐氣",
	rot_desc = "當玩家中了惡臭腐氣減益時發出警報。",
	rot_message = "%s：%s！",

	rotBar = "惡臭腐氣計時條",
	rotBar_desc = "當惡臭腐氣持續時顯示計時條。",
} end )

L:RegisterTranslations("deDE", function() return {
	bane = "Dunkle Macht",
	bane_desc = "Warnt beim Zaubern von Dunkle Macht.",
	bane_message = "Zaubert Dunkle Macht",
	bane_ended = "Dunkle Macht Vorbei",

	baneBar = "Dunkle Macht Bar",
	baneBar_desc = "Zeigt eine Bar für die Dauer des Dunkle Macht Buffs.",

	rot = "Eitriges Verrotten",
	rot_desc = "Warnt wenn jemand den Eitriges Verrotten Debuff hat.",
	rot_message = "%s: %s",

	rotBar = "Eitriges Verrotten Bar",
	rotBar_desc = "Zeigt eine Bar für die Dauer von Eitriges Verrotten.",
} end )

L:RegisterTranslations("zhCN", function() return {
	bane = "灾祸",
	bane_desc = "当施放灾祸时发出警报。",
	bane_message = "正在施放 灾祸！",
	bane_ended = "灾祸 消失！",

	baneBar = "灾祸计时条",
	baneBar_desc = "当灾祸持续时显示计时条。",

	rot = "恶臭溃烂",
	rot_desc = "当玩家中了恶臭溃烂减益时发出警报。",
	rot_message = "%s：%s！",

	rotBar = "恶臭溃烂计时条",
	rotBar_desc = "当恶臭溃烂持续时显示计时条。",
} end )

L:RegisterTranslations("ruRU", function() return {
	bane = "Погибель",
	bane_desc = "Предепреждать о применении погибели.",
	bane_message = "Применение погибели",

	baneBar = "Полоса погибели",
	baneBar_desc = "Отображать полосу продолжительности баффа погибели.",
	
	rot = "Смрадная гниль",
	rot_desc = "Прендупреждать если кто получит дебафф Смрадной гнили.",
	rot_message = "%s: %s",

	rotBar = "Полоса Смрадной гнили",
	rotBar_desc = "Отображать полосу продолжительности Смрадной гнили.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod.zonename = BZ["Utgarde Pinnacle"]
mod.enabletrigger = boss 
mod.guid = 26861
mod.toggleoptions = {"bane", "baneBar", -1, "rot", "rotBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Bane", 48294, 59301)
	self:AddCombatListener("SPELL_AURA_APPLIED", "BaneAura", 48294, 59301)
	self:AddCombatListener("SPELL_AURA_REMOVED", "BaneAuraRemoved", 48294, 59301)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Rot", 48291, 59300)
	self:AddCombatListener("SPELL_AURA_REMOVED", "RotRemoved", 48291, 59300)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Bane(_, spellId, _, _, spellName)
	if self.db.profile.bane then
		self:IfMessage(L["bane_message"], "Urgent", spellId)
	end
end

function mod:BaneAura(player, spellId, _, _, spellName)
	if player ~= boss then return end
	if self.db.profile.baneBar then
		self:Bar(spellName, 5, spellId)
	end
end

function mod:BaneAuraRemoved(player, spellId, _, _, spellName)
	if player ~= boss then return end
	if self.db.profile.bane then
		self:IfMessage(L["bane_ended"], "Positive", spellId)
	end
	if self.db.profile.baneBar then
		self:TriggerEvent("BigWigs_StopBar", self, spellName)
	end
end

function mod:Rot(player, spellId, _, _, spellName)
	if self.db.profile.rot then
		self:IfMessage(L["rot_message"]:format(spellName, player), "Urgent", spellId)
	end
	if self.db.profile.rotBar then
		self:Bar(L["rot_message"]:format(spellName, player), 9, spellId)
	end
end

function mod:RotRemoved(player, _, _, _, spellName)
	if self.db.profile.rotBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["rot_message"]:format(spellName, player))
	end
end
