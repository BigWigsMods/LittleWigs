------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Cyanigosa"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Cyanigosa",

	vacuum = "Arcane Vacuum",
	vacuum_desc = "Warns for Arcane Vacuum.",
	vacuum_soon = "Arcane Vacuum in ~5sec",
	vacuum_message = "Arcane Vacuum",

	vacuumcooldown = "Arcane Vacuum cooldown",
	vacuumcooldown_desc = "Warn when cooldown for Arcane Vacuum has passed.",
	vacuum_cooldown_bar = "Arcane Vacuum cooldown",

	blizzard = "Blizzard",
	blizzard_desc = "Warns for Blizzard.",
	blizzard_message = "Blizzard",

	destruction = "Mana Destruction",
	destruction_desc = "Warn when someone has Mana Destruction.",

	destructionBar = "Mana Destruction Bar",
	destructionBar_desc = "Display a bar for the duration of Mana Destruction.",

	destruction_message = "%s: %s",
} end )

L:RegisterTranslations("koKR", function() return {
	vacuum = "비전 진공",
	vacuum_desc = "비전 진공에 대해 알립니다.",
	vacuum_soon = "약 5초 후 비전 진공!",
	vacuum_message = "비전 진공!",

	vacuumcooldown = "비전 진공 대기시간",
	vacuumcooldown_desc = "비전 진공의 대기시간 바를 표시합니다.",
	vacuum_cooldown_bar = "비전 진공 대기시간",

	blizzard = "눈보라",
	blizzard_desc = "눈보라에 대해 알립니다.",
	blizzard_message = "눈보라!",

	destruction = "마나 파괴",
	destruction_desc = "마나 파괴에 걸린 플레이어를 알립니다.",

	destructionBar = "마나 파괴 바",
	destructionBar_desc = "마나 파괴가 지속되는 바를 표시합니다.",

	destruction_message = "%s: %s",
} end )

L:RegisterTranslations("frFR", function() return {
	vacuum = "Vide des arcanes",
	vacuum_desc = "Prévient un Vide des arcanes est incanté.",
	vacuum_soon = "Vide des arcanes dans ~5sec !",
	vacuum_message = "Vide des arcanes",

	vacuumcooldown = "Vide des arcanes - Recharge",
	vacuumcooldown_desc = "Affiche une barre indiquant le temps de recharge du Vide des arcanes.",
	vacuum_cooldown_bar = "Recharge Vide des arcanes",

	blizzard = "Blizzard",
	blizzard_desc = "Prévient quand un Blizzard est incanté.",
	blizzard_message = "Blizzard",

	destruction = "Destruction du mana",
	destruction_desc = "Prévient quand un joueur subit les effets de la Destruction du mana.",

	destructionBar = "Destruction du mana - Barre",
	destructionBar_desc = "Affiche une barre indiquant la durée de la Destruction du mana.",

	destruction_message = "%s : %s",
} end )

L:RegisterTranslations("zhTW", function() return {
	vacuum = "秘法真空",
	vacuum_desc = "當施放秘法真空時發出警報。",
	vacuum_soon = "約5秒後，秘法真空！",
	vacuum_message = "秘法真空！",

	vacuumcooldown = "秘法真空冷卻",
	vacuumcooldown_desc = "當秘法真空冷卻結束時發出警報。",
	vacuum_cooldown_bar = "<秘法真空 冷卻>",

	blizzard = "暴風雪",
	blizzard_desc = "當施放暴風雪時發出警報。",
	blizzard_message = "暴風雪！",

	destruction = "法力浩劫",
	destruction_desc = "當玩家中了法力浩劫時發出警報。",

	destructionBar = "法力浩劫計時條",
	destructionBar_desc = "當法力浩劫持續時顯示計時條。",

	destruction_message = "%s：%s！",
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
	vacuum = "奥术真空",
	vacuum_desc = "当施放奥术真空时发出警报。.",
	vacuum_soon = "约5秒后，奥术真空！",
	vacuum_message = "奥术真空！",

	vacuumcooldown = "奥术真空冷却",
	vacuumcooldown_desc = "当奥术真空冷却结束时发出警报。",
	vacuum_cooldown_bar = "<奥术真空 冷却>",

	blizzard = "暴风雪",
	blizzard_desc = "当施放暴风雪时发出警报。",
	blizzard_message = "暴风雪！",

	destruction = "法力毁灭",
	destruction_desc = "当玩家中了法力毁灭时发出警报。",

	destructionBar = "法力毁灭计时条",
	destructionBar_desc = "当法力毁灭持续时显示计时条。",

	destruction_message = "%s：%s！",
} end )

L:RegisterTranslations("ruRU", function() return {
	vacuum = "Чародейский вакуум",
	vacuum_desc = "Предупреждать о Чародейском вакууме.",
	vacuum_soon = "Чародейский вакуум через ~5сек!",
	vacuum_message = "Чародейский вакуум!",
	
	vacuumcooldown = "Перезарядка Чародейского вакуума",
	vacuumcooldown_desc = "Предупреждать о завершении перезарядки Чародейского вакуума.",
	vacuum_cooldown_bar = "Перезарядка вакуума",
	
	blizzard = "Снежная буря",
	blizzard_desc = "Предупреждать о Снежной бури.",
	blizzard_message = "Снежная буря!",
	
	destruction = "Захват маны",
	destruction_desc = "Предупреждать если кто либо получил Захват маны.",
	
	destructionBar = "Полоса Захвата маны",
	destructionBar_desc = "Отображать полосу продолжительности Захвата маны.",
	
	destruction_message = "%s: %s",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod.zonename = BZ["The Violet Hold"]
mod.enabletrigger = boss 
mod.guid = 31134
mod.toggleoptions = {"blizzard", -1, "vacuum", "vacuumcooldown", -1, "destruction", "destructionBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Vacuum", 58694)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Blizzard", 58693, 59369)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Destruction", 59374)
	self:AddCombatListener("SPELL_AURA_REMOVED", "DestructionRemoved", 59374)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
	
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("BigWigs_RecvSync")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Vacuum(_, spellId)
	if self.db.profile.vacuum then
		self:IfMessage(L["vacuum_message"], "Important", spellId)
	end
	if self.db.profile.vacuumcooldown then
		self:TriggerEvent("BigWigs_StopBar", self, L["vacuum_cooldown_bar"])
		self:CancelScheduledEvent("VacuumWarn")
		self:Bar(L["vacuum_cooldown_bar"], 30, 58694)
		self:ScheduleEvent("VacuumWarn", "BigWigs_Message", 25, L["vacuum_soon"], "Urgent")
	end
end

function mod:Blizzard(_, spellId)
	if self.db.profile.blizzard then
		self:IfMessage(L["blizzard_message"], "Important", spellId)
	end
end

function mod:Destruction(player, spellId, _, _, spellName)
	if self.db.profile.destruction then
		self:IfMessage(L["destruction_message"]:format(spellName, player), "Important", spellId)
	end
	if self.db.profile.destructionBar then
		self:Bar(L["destruction_message"]:format(spellName, player), 8, spellId)
	end
end

function mod:DestructionRemoved(player, _, _, _, spellName)
	if self.db.profile.destructionBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["destruction_message"]:format(spellName, player))
	end
end

function mod:BigWigs_RecvSync(sync, rest, nick)
	if self:ValidateEngageSync(sync, rest) and not started then
		if self:IsEventRegistered("PLAYER_REGEN_DISABLED") then
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		end
		if self.db.profile.vacuumcooldown then
			self:Bar(L["vacuum_cooldown_bar"], 30, 58694)
			self:ScheduleEvent("VacuumWarn", "BigWigs_Message", 25, L["vacuum_soon"], "Urgent")
		end
	end
end
