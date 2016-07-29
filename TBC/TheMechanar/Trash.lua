------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Gatewatcher Gyro-Kill"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------



----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Mechanar"]
mod.enabletrigger = boss 
mod.guid = 19218
mod.toggleOptions = {"shadow", "shadowbar"}
mod.revision = tonumber(("$Revision: 34 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Shadow", 39193, 35322)
	self:AddCombatListener("SPELL_AURA_APPLIED", "ShadowApplied", 39193, 35322)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ShadowRemoved", 39193, 35322)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Shadow(_, spellId)
	if self.db.profile.shadow then
		self:Message(L["shadow_message"], "Important")
	end
end

function mod:ShadowApplied(_, spellId, _, _, spellName)
	if self.db.profile.shadowbar then
		self:Bar(spellName, 15, spellId)
	end
end

function mod:ShadowRemoved(_, spellId, _, _, spellName)
	if self.db.profile.shadowbar then
		self:TriggerEvent("BigWigs_StopBar", self, spellName)
	end
end

------------------------------------------------------------------------------------------------------------------------


------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Gatewatcher Iron-Hand"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Iron-Hand",

	hammer = "Jackhammer",
	hammer_desc = "Warn when Jackhammer Effect is cast",
	hammer_trigger = "raises his hammer menacingly",
	hammer_message = "Jackhammer in 3 seconds!",
	hammer_bar = "Jackhammer",

	shadow = "Shadow Power Cast",
	shadow_desc = "Warn when Iron-Hand casts Shadow Power",
	shadow_message = "Shadow Power in 2 seconds!",

	shadowbar = "Shadow Power Bar",
	shadowbar_desc = "Display a bar for Shadow Power on Iron-Hand",
} end )

L:RegisterTranslations("koKR", function() return {
	hammer = "착암기",
	hammer_desc = "착암기 효과 시전시 알립니다.",
	hammer_trigger = "자신의 망치를 위협적으로 치켜듭니다...", -- check
	hammer_message = "3초 이내 착암기!",
	hammer_bar = "착암기",

	shadow = "어둠의 힘 시전",
	shadow_desc = "무쇠주먹의 어둠의 힘 시전에 대해 알립니다.",
	shadow_message = "2초 이내 어둠의 힘!",
	
	shadowbar = "어둠의 힘 바",
	shadowbar_desc = "어둠의 힘을 바로 표시합니다.",
} end )

L:RegisterTranslations("zhTW", function() return {
	hammer = "千斤錘特效",
	hammer_desc = "當看守者鐵手發動千斤錘特效時發出警報",
	hammer_trigger = "威嚇地舉起他的錘子……",
	hammer_message = "3 秒後發動千斤錘! 近戰退後!",
	hammer_bar = "<千斤錘特效>",

	shadow = "施放暗影強化",
	shadow_desc = "當看守者蓋洛奇歐施放暗影強化時發出警報",
	shadow_message = "2 秒後施放暗影強化!",
} end )

L:RegisterTranslations("frFR", function() return {
	hammer = "Marteau-piqueur",
	hammer_desc = "Prévient quand le Marteau-piqueur est incanté.",
	hammer_trigger = "lève son marteau d'un air menaçant...",
	hammer_message = "Marteau-piqueur dans 3 sec. !",
	hammer_bar = "Marteau-piqueur",

	shadow = "Puissance de l'ombre incanté",
	shadow_desc = "Prévient quand Main-en-fer incante la Puissance de l'ombre.",
	shadow_message = "Puissance de l'ombre dans 2 sec. !",

	shadowbar = "Barre Puissance de l'ombre",
	shadowbar_desc = "Affiche une barre pour la Puissance de l'ombre de Main-en-fer.",
} end )

L:RegisterTranslations("esES", function() return {
	hammer = "Martillo",
	hammer_desc = "Avisa cuando Manoyerro alza su martillo",
	hammer_trigger = "alza su martillo amenazadoramente",
	hammer_message = "Martillo en 3 segundos!",
	hammer_bar = "Martillo",

	shadow = "Shadow Power",
	shadow_desc = "Avisa cuando Manoyerro lanza Poder de las Sombras",
	shadow_message = "Poder de las Sombras en 2 segundos!",
} end )

L:RegisterTranslations("zhCN", function() return {
	hammer = "风钻",
	hammer_desc = "当施放风钻特效时发出警报。",
	hammer_trigger = "%s阴险地举起战锤……",
	hammer_message = "3秒后，风钻！",
	hammer_bar = "<风钻>",

	shadow = "施放暗影能量",
	shadow_desc = "当埃隆汉施放暗影能量时发出警报。",
	shadow_message = "2秒后，暗影能量！",

	shadowbar = "暗影能量计时条",
	shadowbar_desc = "当盖罗基尔获得暗影能量时显示计时条。",
} end )

L:RegisterTranslations("deDE", function() return {
	hammer = "Hammer",
	hammer_desc = "Vor Hammer Warnen",
	hammer_trigger = "erhebt seinen Hammer bedrohlich",
	hammer_message = "Hammer in 3 Sekunden!",
	hammer_bar = "Hammer",

	shadow = "Schattenmacht",
	shadow_desc = "Warnen, wenn Gyrotod Schattenmacht bekommt",
	shadow_message = "Schattenmacht in 2 Sekunden!",
} end )

L:RegisterTranslations("ruRU", function() return {
	hammer = "Молотковый перфоратор",
	hammer_desc = "Предупреждать когда будет выполнении Эффекта Молоткового перфоратора",
	hammer_trigger = "raises his hammer menacingly",
	hammer_message = "Молотковый перфоратор за 3 секунды!",
	hammer_bar = "Молотковый перфоратор",

	shadow = "Мощь Тьмы",
	shadow_desc = "Предупреждать когда Железнорук выполняет Мощь Тьмы",
	shadow_message = "Мощь Тьмы за 2 секунды!",

	shadowbar = "Панель Мощи Тьмы",
	shadowbar_desc = "Отоброжать панель для Мощи Тьмы Железнорука",
} end )


----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Mechanar"]
mod.enabletrigger = boss 
mod.guid = 19710
mod.toggleOptions = {"hammer", -1, "shadow", "shadowbar"}
mod.revision = tonumber(("$Revision: 34 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:AddCombatListener("SPELL_CAST_START", "Shadow", 39193, 35322)
	self:AddCombatListener("SPELL_AURA_APPLIED", "ShadowApplied", 39193, 35322)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ShadowRemoved", 39193, 35322)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if self.db.profile.hammer and msg:find(L["hammer_trigger"]) then
		self:IfMessage(L["hammer_message"], "Important", 39194)
		self:Bar(L["hammer"], 3, 39194)
	end
end

function mod:Shadow(_, spellId)
	if self.db.profile.shadow then
		self:Message(L["shadow_message"], "Important")
	end
end

function mod:ShadowApplied(_, spellId, _, _, spellName)
	if self.db.profile.shadowbar then
		self:Bar(spellName, 15, spellId)
	end
end

function mod:ShadowRemoved(_, spellId, _, _, spellName)
	if self.db.profile.shadowbar then
		self:TriggerEvent("BigWigs_StopBar", self, spellName)
	end
end

