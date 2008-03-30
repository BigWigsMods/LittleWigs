------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Kael'thas Sunstrider"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss.."(MT)")
local glapseannounced = nil

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
	barrier_soon_message = "잠시후 방어 방벽!",
} end )

L:RegisterTranslations("frFR", function() return {
	glapse = "Rupture de gravité",
	glapse_desc = "Préviens de l'arrivée des Ruptures de gravité.",
	glapse_message = "Rupture de gravité imminente !",
	glapse_bar = "Rupture de gravité",

	phoenix = "Phénix",
	phoenix_desc = "Préviens quand un phénix est invoqué.",
	phoenix_message = "Phénix invoqué !",

	flamestrike = "Frappe de flammes",
	flamestrike_desc = "Préviens quand une Frappe de flammes est incantée.",
	flamestrike_message = "Frappe de flammes !",

	barrier = "Barrière de choc (Héroïque)",
	barrier_desc = "Préviens quand Kael'thas gagne sa Barrière de choc.",
	barrier_message = "Barrière de choc !",
	barrier_next_bar = "~Prochaine Barrière",
	barrier_soon_message = "Barrière de choc imminente !",
} end )

L:RegisterTranslations("zhCN", function() return {
	glapse = "引力失效",
	glapse_desc = "当引力失效发出警报。",
	glapse_message = "即将 引力失效！",
	glapse_bar = "<引力失效>",

	phoenix = "召唤凤凰",
	phoenix_desc = "当凤凰被召唤发出警报。",
	phoenix_message = "凤凰 -> 召唤！",

	flamestrike = "烈焰打击",
	flamestrike_desc = "当烈焰打击施放时发出警报。",
	flamestrike_message = "烈焰打击！",

	barrier = "震击屏障（英雄）",
	barrier_desc = "当凯尔萨斯获得震击屏障发出警报。",
	barrier_message = "震击屏障！",
	barrier_next_bar = "<下一震击屏障>",
	barrier_soon_message = "即将 震击屏障！",
} end )

L:RegisterTranslations("zhTW", function() return {
	glapse = "引力失效",
	glapse_desc = "當凱爾薩斯發動引力失效時發出警報",
	glapse_message = "即將發動引力失效!",
	glapse_bar = "<引力失效>",

	phoenix = "召喚鳳凰",
	phoenix_desc = "當凱爾薩斯召喚鳳凰時發出警報",
	phoenix_message = "已召喚鳳凰!",

	flamestrike = "烈焰打擊",
	flamestrike_desc = "當凱爾薩斯發動烈焰打擊時發出警報",
	flamestrike_message = "烈焰打擊!",

	barrier = "震擊屏障（英雄）",
	barrier_desc = "當凱爾薩斯獲得震擊屏障發出警報",
	barrier_message = "震擊屏障 開啟!",
	barrier_next_bar = "<下一次震擊屏障>",
	barrier_soon_message = "即將施放震擊屏障!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss.."(MT)")
mod.partyContent = true
mod.zonename = BZ["Magisters' Terrace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"glapse", "phoenix", "flamestrike", -1, "barrier", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	glapseannounce = nil
	started = nil

	self:RegisterEvent("UNIT_HEALTH")
	self:AddCombatListener("SPELL_CAST_START", "Lapse", 44224)
	self:AddCombatListener("SPELL_SUMMON", "Phoenix", 44194)
	self:AddCombatListener("SPELL_SUMMON", "FlameStrike", 44192)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Barrier", 46165)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	self:RegisterEvent("BigWigs_RecvSync")
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
end

function mod:Lapse()
	if self.db.profile.glapse then 
		self:Bar(L["glapse_bar"], 35, 44224)
	end
end

function mod:Phoenix()
	if self.db.profile.phoenix then
		self:IfMessage(L["phoenix_message"], "Important", 44194)
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

function mod:BigWigs_RecvSync(sync, rest, nick)
	if self:ValidateEngageSync(sync, rest) and not started then
		started = true
		if self:IsEventRegistered("PLAYER_REGEN_DISABLED") then
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		end
		if self.db.profile.barrier and GetInstanceDifficulty() == 2 then
			self:Bar(L["barrier_next_bar"], 60, 46165)
			self:DelayedMessage(50, L["barrier_soon_message"], "Attention")
		end
	end
end

