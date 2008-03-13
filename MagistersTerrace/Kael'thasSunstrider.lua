------------------------------
--      Are you local?      --
------------------------------

if not GetSpellInfo then return end

local boss = BB["Kael'thas Sunstrider"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss.."MT")
local db = nil
local glapseannounced = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Kael'thas",

	glapse = "Gravity Lapse",
	glapse_desc = "Warn for Gravity Lapse",
	glapse_message = "Gravity Lapse Soon!",
	glapse_bar = "Gravity Lapse",

	phoenix = "Summon Phoenix",
	phoenix_desc = "Warn when a Phoenix is summoned",
	phoenix_message = "Phoenix summoned!",

	flamestrike = "Flame Strike",
	flamestrike_desc = "Warn when a Flame Strike is cast",
	flamestrike_message = "Flame Strike!",

	barrier = "Shock Barrier (Heroic)",
	barrier_desc = "Warn when Kael'thas gains Shock Barrier",
	barrier_message = "Shock Barrier Up!",
} end )

--[[
	Magister's Terrace modules are PTR beta, as so localization is not
	supported in any way. This gives the authors the freedom to change the
	modules in way that	can potentially break localization.  Feel free to
	localize, just be aware that you may need to change it frequently.
]]--

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

	barrier = "Shock Barrier (영웅)",
	barrier_desc = "캘타스가 Shock Barrier 획득에 대해 알립니다.",
	barrier_message = "Shock Barrier Up!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.zonename = BZ["Magisters' Terrace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"glapse","phoenix","flamestrike",-1,"barrier","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	glapseannounce = nil
	self:RegisterEvent("UNIT_HEALTH")

	self:AddCombatListener("SPELL_CAST_START", "Lapse", 44224)
	self:AddCombatListener("SPELL_SUMMON", "Phoenix", 44194)
	self:AddCombatListener("SPELL_SUMMON", "FlameStrike", 44192)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:UNIT_HEALTH(arg1)
	if not db.glapse then return end
	if UnitName(arg1) == boss then
		local health = UnitHealth(arg1)
		if health > 48 and health <= 52 and not glapseannounced then
			glapseannounced = true
			self:Message(L["glapse_message"], "Important", nil, nil, nil, 44224)
		elseif health > 30 and glapseannounced then
			glapseannounced = nil
		end
	end
end

function mod:Lapse()
	if db.glapse then 
		self:Bar(L["glapse_bar"], 35, 44224)
	end
end

function mod:Phoenix()
	if db.phoenix then
		self:Message(L["phoenix_message"], "Important", nil, nil, nil, 44194)
	end
end

function mod:FlameStrike()
	if db.flamestrike then
		self:Message(L["flamestrike_message"], "Important", nil, nil, nil, 44192)
	end
end
