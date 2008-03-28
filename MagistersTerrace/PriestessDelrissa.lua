------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Priestess Delrissa"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil
local fmt = string.format

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Delrissa",

	pri_flashheal = "Priestess Delrissa - Flash Heal",
	pri_flashheal_desc = "Warn for casting heals",
	pri_flashheal_message = "Priestess casting Flash Heal!",
	pri_renew = "Priestess Delrissa - Renew",
	pri_renew_desc = "Warn for who she casts renew on",
	pri_renew_message = "Renew on %s!",
	pri_shield = "Priestess Delrissa - Power Word: Shield",
	pri_shield_desc = "Warn for application of Power Word: Shield",
	pri_shield_message = "Power Word: Shield on %s!",

	Apoko = "Apoko", --need the add name translated, maybe we'll add it to BabbleBoss
	apoko_lhw = "Apoko - Lesser Healing Wave",
	apoko_lhw_desc = "Warn for casting heals",
	apoko_lhw_message = "Apoko Healing!",
	apoko_wf = "Apoko - Windfury Totem",
	apoko_wf_desc = "Warn when a Windfury Totem is dropped",
	apoko_wf_message = "Windfury Totem dropped!",

	Ellyrs = "Ellrys Duskhallow", --need the add name translated, maybe we'll add it to BabbleBoss
	ellrys_soc = "Ellrys - Seed of Corruption",
	ellrys_soc_desc = "",
	ellrys_soc_message = "",

	Yazzai = "Yazzai", --need the add name translated, maybe we'll add it to BabbleBoss
	yazzai_bliz = "Yazzai - Blizzard",
	yazzai_bliz_desc = "",
	yazzai_bliz_message = "",
	yazzai_poly = "Yazzai - Polymorph",
	yazzai_poly_desc = "",
	yazzai_poly_message = "",
} end )

L:RegisterTranslations("koKR", function() return {
	pri_flashheal = "여사제 델리사 - 순간 치유",
	pri_flashheal_desc = "치유 시전에 대해 알립니다.",
	pri_flashheal_message = "델리사 치유 시전!",
	pri_shield = "여사제 델리사 - 신의 권능: 보호막",
	pri_shield_desc = "신의 권능: 보호막의 사용에 대해 알립니다.",
	pri_shield_message = "%s: 보호막!",

	Apoko = "아포코", --need the add name translated, maybe we'll add it to BabbleBoss
	apoko_lhw = "아포코 - 하급 치유의 물결",
	apoko_lhw_desc = "치유 시전에 대해 알립니다.",
	apoko_lhw_message = "아포코 치유 시전!",
	apoko_wf = "아포코 - 질풍의 토템",
	apoko_wf_desc = "",
	apoko_wf_message = "",

	Ellyrs = "엘리스 더스크할로우", --need the add name translated, maybe we'll add it to BabbleBoss
	ellrys_soc = "엘리스 - 부패의 씨앗",
	ellrys_soc_desc = "",
	ellrys_soc_message = "",

	Yazzai = "야자이", --need the add name translated, maybe we'll add it to BabbleBoss
	yazzai_bliz = "야자이 - 눈보라",
	yazzai_bliz_desc = "",
	yazzai_bliz_message = "",
	yazzai_poly = "야자이 - 변이",
	yazzai_poly_desc = "",
	yazzai_poly_message = "",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.zonename = BZ["Magisters' Terrace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"pri_flashheal", "pri_renew", "pri_shield", -1, "apoko_lhw", "apoko_wf", -1, "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
	self:AddCombatListener("SPELL_AURA_APPLIED", "PriShield", "44175")
	self:AddCombatListener("SPELL_CAST_START", "PriHeal", "17843")
	self:AddCombatListener("SPELL_CAST_SUCCESS", "PriRenew", "44174")
	self:AddCombatListener("SPELL_CAST_START", "ApokoHeal", "44256")
	self:AddCombatListener("SPELL_CAST_SUCCESS", "ApokoWF", "27621")
	self:AddCombatListener("SPELL_AURA_APPLIED", "EllrysSoC", "44141")
	--self:AddCombatListener("SPELL_AURA_APPLIED", "YazzaiPoly", "#####")
	--self:AddCombatListener("SPELL_CAST_START", "YazzaiBliz", "#####")

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")	

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:PriShield(player)
	if db.pri_shield and source == boss then
		self:Message(fmt(L["pri_shield_message"], player), "Attention", nil, nil, nil, 44175)
	end
end

-- 
function mod:PriHeal(source)
	if db.pri_heal and source == boss then
		self:Message(L["pri_heal_message"], "Attention", nil, nil, nil, 17843)
	end
end

function mod:PriRenew(source, player)
	if db.pri_renew and source == boss then
		self:Message(fmt(L["pri_renew_message"], player), "Attention", nil, nil, nil, 44174)
	end
end

function mod:ApokoHeal(source)
	if db.apoko_heal and source == L["Apoko"] then
		self:Message(L["apoko_heal_message"], "Attention", nil, nil, nil, 44256)
	end	
end

function mod:ApokoWF(source)
	if db.apoko_wf and source == L["Apoko"] then
		self:Message(L["apoko_wf_message"], "Attention", nil, nil, nil, 27621)
	end	
end

function mod:EllrysSoC(player, spellId)
end

--[[function mod:YazzaiPoly(player, spellId)
end

function mod:YazzaiBliz(source)
end]]--
