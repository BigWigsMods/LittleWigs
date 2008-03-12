------------------------------
--      Are you local?      --
------------------------------

if not GetSpellInfo then return end

local boss = BB["Kael'thas Sunstrider"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
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

	summon = "Summon Phoenix",
	summon_desc = "Warn when a Phoenix is summoned",
	summon_message = "Phoenix summoned!",

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

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.zonename = BZ["Magisters' Terrace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"glapse","summon",-1,"barrier","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	glapseannounce = nil
	self:RegisterEvent("UNIT_HEALTH")

	self:AddCombatListener("SPELL_CAST_START", "Lapse", 44224)
	self:AddCombatListener("SPELL_SUMMON", "Summon", 44194)
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

function mod:Summon()
	if db.summon then
		self:Message(L["summon_message"], "Important", nil, nil, nil, 44194)
	end
end
