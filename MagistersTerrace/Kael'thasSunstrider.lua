------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Kael'thas Sunstrider"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss.."(MT)")

local glapseannounced = nil
local started = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Kael'thas",

	glapse = "Gravity Lapse",
	glapse_desc = "Warn for Gravity Lapse.",
	glapse_message = "Gravity Lapse Soon!",
	glapse_bar = "Gravity Lapse",

	phoenix = "Summon Phoenix",
	phoenix_desc = "Warn when a Phoenix is summoned.",
	phoenix_message = "Phoenix summoned!",

	flamestrike = "Flame Strike",
	flamestrike_desc = "Warn when a Flame Strike is cast.",
	flamestrike_message = "Flame Strike!",

	barrier = "Shock Barrier (Heroic)",
	barrier_desc = "Warn when Kael'thas gains Shock Barrier.",
	barrier_message = "Shock Barrier Up!",
	barrier_next_bar = "~ Next Shock Barrier",
	barrier_soon_message = "Shock Barrier Soon!",

	pyro = "Pyroblast (Heroic)",
	pyro_desc = "Warn when Kael'thas casts Pyroblast.",
	pyro_message = "Kael'thas casting Pyroblast!",

	tk_warning = "Please verify that the The Eye Kael'thas module has not also been enabled.",
} end )

L:RegisterTranslations("koKR", function() return {
	glapse = "중력 붕괴",
	glapse_desc = "중력 붕괴에 대해 알립니다.",
	glapse_message = "잠시후 중력 붕괴!",
	glapse_bar = "중력 붕괴",

	phoenix = "불사조 소환",
	phoenix_desc = "불사조 소환에 대해 알립니다.",
	phoenix_message = "불사조 소환!",

	flamestrike = "화염구",
	flamestrike_desc = "화염구 시전에 대해 알립니다.",
	flamestrike_message = "화염구!",

	barrier = "충격 방벽 (영웅)",
	barrier_desc = "캘타스가 충격 방벽 얻었을 때 알립니다.",
	barrier_message = "충격 방벽!",
	barrier_next_bar = "~ 다음 방어 방벽",
	barrier_soon_message = "잠시 후 방어 방벽!",

	pyro = "불덩이 작렬 (영웅)",
	pyro_desc = "캘타스의 불덩이 작렬 시전을 알립니다.",
	pyro_message = "캘타스 불덩이 작렬 시전!",

	tk_warning = "BigWigs의 폭풍우 요새 - 캘타스 모듈에서 사용시 불덩이 작렬이 제대로 작동되지 않습니다. LittleWigs을 끄고 사용하시기 바랍니다.",
} end )

L:RegisterTranslations("frFR", function() return {
	glapse = "Rupture de gravité",
	glapse_desc = "Prévient de l'arrivée des Ruptures de gravité.",
	glapse_message = "Rupture de gravité imminente !",
	glapse_bar = "Rupture de gravité",

	phoenix = "Phénix",
	phoenix_desc = "Prévient quand un phénix est invoqué.",
	phoenix_message = "Phénix invoqué !",

	flamestrike = "Frappe de flammes",
	flamestrike_desc = "Prévient quand une Frappe de flammes est incantée.",
	flamestrike_message = "Frappe de flammes !",

	barrier = "Barrière de choc (Héroïque)",
	barrier_desc = "Prévient quand Kael'thas gagne sa Barrière de choc.",
	barrier_message = "Barrière de choc !",
	barrier_next_bar = "~Prochaine Barrière",
	barrier_soon_message = "Barrière de choc imminente !",

	pyro = "Explosion pyrotechnique (Héroïque)",
	pyro_desc = "Prévient quand Kael'thas incante une Explosion pyrotechnique.",
	pyro_message = "Kael'thas incante une Explosion pyrotechnique !",

	tk_warning = "Veuillez vérifier que le module Kael'thas de L'Œil n'a pas également été activé (risque de conflit).",
} end )

L:RegisterTranslations("zhCN", function() return {
	glapse = "引力失效",
	glapse_desc = "当引力失效时发出警报。",
	glapse_message = "即将 引力失效！",
	glapse_bar = "<引力失效>",

	phoenix = "召唤凤凰",
	phoenix_desc = "当凤凰被召唤时发出警报。",
	phoenix_message = "召唤 - 凤凰！",

	flamestrike = "烈焰打击",
	flamestrike_desc = "当烈焰打击施放时发出警报。",
	flamestrike_message = "烈焰打击！",

	barrier = "震击屏障（英雄）",
	barrier_desc = "当获得震击屏障时发出警报。",
	barrier_message = "震击屏障！",
	barrier_next_bar = "<下一震击屏障>",
	barrier_soon_message = "即将 震击屏障！",

	pyro = "炎爆术（英雄）",
	pyro_desc = "当施放炎爆术时发出警报。",
	pyro_message = "正在施放 炎爆术！",

	tk_warning = "请确认 BigWigs 中的风暴要塞-凯尔萨斯模块没有被开启。",
} end )

L:RegisterTranslations("zhTW", function() return {
	glapse = "重力流逝",
	glapse_desc = "當凱爾薩斯發動重力流逝時發出警告",
	glapse_message = "即將發動重力流逝!",
	glapse_bar = "<重力流逝>",

	phoenix = "召喚鳳凰",
	phoenix_desc = "當凱爾薩斯召喚鳳凰時發出警告",
	phoenix_message = "鳳凰 - 已召喚!",

	flamestrike = "烈焰風暴",
	flamestrike_desc = "當凱爾薩斯發動烈焰風暴時發出警告",
	flamestrike_message = "烈焰風暴!",

	barrier = "震擊屏障（英雄）", -- need check
	barrier_desc = "當凱爾薩斯獲得震擊屏障時發出警告", -- need check
	barrier_message = "震擊屏障 開啟!", -- need check
	barrier_next_bar = "<下一次震擊屏障>", -- need check
	barrier_soon_message = "即將施放震擊屏障!", -- need check

	pyro = "炎爆術（英雄）",
	pyro_desc = "當凱爾薩斯施放炎爆術時發出警告",
	pyro_message = "凱爾薩斯正在施放炎爆術!",

	tk_warning = "請確認風暴要塞 - 凱爾薩斯模組沒有被開啟",
} end )

L:RegisterTranslations("ruRU", function() return {
	glapse = "Искажение гравитации",
	glapse_desc = "Предупреждать о Искажении гравитации.",
	glapse_message = "Близится Искажение гравитации!",
	glapse_bar = "Искажение гравитации",

	phoenix = "Вызов феникса",
	phoenix_desc = "Предупреждать о вызове феникса.",
	phoenix_message = "Вызван феникс!",

	flamestrike = "Поражение пламенем",
	flamestrike_desc = "Предупреждать о Поражение пламенем.",
	flamestrike_message = "Поражение пламенем!",

	barrier = "Шоковая преграда (Героик)",
	barrier_desc = "Предупреждать когда Кель получает Шоковую преграду.",
	barrier_message = "Шоковая преграда активна!",
	barrier_next_bar = "~ Следующая Шоковая преграда",
	barrier_soon_message = "Надвигается Шоковая преграда!",

	pyro = "Огненная глыба (Героик)",
	pyro_desc = "Предупреждать когда Кель выполняет заклинание Огненной глыбы.",
	pyro_message = "Кель выполняет заклинание Огненной глыбы!",

	tk_warning = "Пожалуйста проверьте не включен ли модуль Келя из Ока.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss.."(MT)")
mod.partyContent = true
mod.zonename = BZ["Magisters' Terrace"]
mod.enabletrigger = boss 
mod.guid = 24664
mod.toggleoptions = {"glapse", "phoenix", "flamestrike", -1, "barrier", "pyro", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	glapseannounce = nil
	started = nil

	self:RegisterEvent("UNIT_HEALTH")
	self:AddCombatListener("SPELL_CAST_START", "Lapse", 44224)
	self:AddCombatListener("SPELL_CAST_START", "Pyro", 36819)
	self:AddCombatListener("SPELL_SUMMON", "Phoenix", 44194)
	self:AddCombatListener("SPELL_SUMMON", "FlameStrike", 44192, 46162)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Barrier", 46165)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	self:RegisterEvent("BigWigs_RecvSync")

	BigWigs:Print(L["tk_warning"])
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:UNIT_HEALTH(arg1)
	if not self.db.profile.glapse then return end
	if UnitName(arg1) == boss then
		local health = UnitHealth(arg1)
		if health > 48 and health <= 52 and not glapseannounced then
			glapseannounced = true
			self:IfMessage(L["glapse_message"], "Important", 44224)
		elseif health > 60 and glapseannounced then
			glapseannounced = nil
		end
	end
	if glapseannounced and self.db.profile.barrier then
		self:CancelScheduledEvent("barrier")
		self:TriggerEvent("BigWigs_StopBar", self, L["barrier_next_bar"])
	end	
end

function mod:Lapse()
	if self.db.profile.glapse then 
		self:Bar(L["glapse_bar"], 35, 44224)
	end
end

function mod:Phoenix()
	if self.db.profile.phoenix then
		self:IfMessage(L["phoenix_message"], "Urgent", 44194)
	end
end

function mod:FlameStrike()
	if self.db.profile.flamestrike then
		self:IfMessage(L["flamestrike_message"], "Important", 44192)
	end
end

function mod:Barrier()
	if self.db.profile.barrier then
		self:IfMessage(L["barrier_message"], "Important", 46165)
	end
end

function mod:Pyro(_, spellId, _, _, spellName)
	if self.db.profile.pyro then
		self:Bar(spellName, 4, spellId)
		self:IfMessage(L["pyro_message"], "Important", spellId)
	end
end

function mod:BigWigs_RecvSync(sync, rest, nick)
	if self:ValidateEngageSync(sync, rest) and not started then
		started = true
		if self:IsEventRegistered("PLAYER_REGEN_DISABLED") then
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		end
		if self.db.profile.barrier and GetInstanceDifficulty() == 2 then
			self:Bar(L["barrier_next_bar"], 60, 46165)
			self:ScheduleEvent("barrier", "BigWigs_Message", 50, L["barrier_soon_message"], "Attention")
		end
	end
end
