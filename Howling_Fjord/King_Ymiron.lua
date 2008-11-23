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

	banebar = "Bane Bar",
	banebar_desc = "Display a bar for the duration of the Bane buff.",

	rot = "Fetid Rot",
	rot_desc = "Warn when some recieves the Fetid Rot debuff.",
	rot_message = "%s: %s",

	rotbar = "Fetid Rot Bar",
	rotbar_desc = "Show a bar for the duration of Fetid Rot.",
} end )

L:RegisterTranslations("koKR", function() return {
	bane = "파멸",
	bane_desc = "파멸 시전을 알립니다.",
	bane_message = "파멸 시전",
	bane_ended = "파멸 사라짐",

	banebar = "파멸 바",
	banebar_desc = "파멸 버프의 지속 시간바를 표시합니다.",

	rot = "악취나는 부패",
	rot_desc = "악취나는 부패 디버프에 걸린 플레이어를 알립니다.",
	rot_message = "%s: %s",

	rotbar = "악취나는 부패 바",
	rotbar_desc = "악취나는 부패의 지속 시간바를 표시합니다.",
} end )

L:RegisterTranslations("frFR", function() return {
	bane = "Fléau",
	bane_desc = "Prévient quand Ymiron incante Fléau.",
	bane_message = "Fléau en incantation",

	banebar = "Fléau - Barre",
	banebar_desc = "Affiche une barre indiquant la durée du buff Fléau.",
} end )

L:RegisterTranslations("zhTW", function() return {
	bane = "災禍",
	bane_desc = "當施放災禍時發出警報。",
	bane_message = "正在施放 災禍！",

	banebar = "災禍計時條",
	banebar_desc = "當災禍持續時顯示計時條。",
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
	bane = "灾祸",
	bane_desc = "当施放灾祸时发出警报。",
	bane_message = "正在施放 灾祸！",

	banebar = "灾祸计时条",
	banebar_desc = "当灾祸持续是显示计时条。",
} end )

L:RegisterTranslations("ruRU", function() return {
	bane = "Погибель",
	bane_desc = "Предепреждать о применении погибели.",
	bane_message = "Применение погибели",

	banebar = "Полоса погибели",
	banebar_desc = "Отображать полосу продолжительности баффа погибели.",
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
mod.toggleoptions = {"bane", "banebar", -1, "rot", "rotbat", "bosskill"}
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
	if self.db.profile.banebar then
		self:Bar(spellName, 5, spellId)
	end
end

function mod:BaneAuraRemoved(player, spellId, _, _, spellName)
	if player ~= boss then return end
	if self.db.profile.bane then
		self:IfMessage(L["bane_ended"], "Positive", spellId)
	end
	if self.db.profile.banebar then
		self:TriggerEvent("BigWigs_StopBar", self, spellName)
	end
end

function mod:Rot(player, spellId, _, _, spellName)
	if self.db.profile.rot then
		self:IfMessage(L["rot_message"]:format(spellName, player), "Urgent", spellId)
	end
	if self.db.profile.rotbar then
		self:Bar(L["rot_message"]:format(spellName, player), 9, spellId)
	end
end

function mod:RotRemoved(player, _, _, _, spellName)
	if self.db.profile.rotbar then
		self:TriggerEvent("BigWigs_StopBar", self, L["rot_message"]:format(spellName, player))
	end
end
