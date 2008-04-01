------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Zereketh the Unbound"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")

local db = nil
local fmt = string.format

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Zereketh",

	nova = "Shadow Nova",
	nova_desc = "Warn for Shadow Nova",
	nova_message = "Shadow Nova in 2 seconds!",

	void = "Void Zone",
	void_desc = "Warns for new Void Zones",
	void_message = "Void Zone incoming!",

	seed = "Seed of Corruption",
	seed_desc = "Warn for who gets Seed of Corruption",
	seed_message = "Seed of Corruption on %s!",
	seed_bar = "~Detonation",

	icon = "Seed of Corruption Raid Icon",
	icon_desc = "Put a Raid Icon on the person who has Seed of Corruption. (Requires promoted or higher)",
} end )

L:RegisterTranslations("koKR", function() return {
	nova = "암흑 회오리",
	nova_desc = "암흑 회오리에 대해 알립니다.",
	nova_message = "2초 이내 암흑 회오리!",

	void = "공허의 지대",
	void_desc = "새로운 공허의 지대에 대해 알립니다.",
	void_message = "잠시 후 공허의 지대!",

	seed = "부패의 씨앗",
	seed_desc = "부패의 씨앗에 걸린 사람에 대해 알립니다.",
	seed_message = "%s에 부패의 씨앗!",
	seed_bar = "~폭발",

	icon = "전술 표시",
	icon_desc = "부패의 씨앗에 걸린 사람에 전술 표시를 지정합니다. (승급자 이상의 권한 요구)",
} end )

L:RegisterTranslations("frFR", function() return {
	nova = "Nova de l'ombre",
	nova_desc = "Préviens de l'arrivée des Novas de l'ombre.",
	nova_message = "Nova de l'ombre dans 2 sec. !",

	void = "Zone de vide",
	void_desc = "Préviens quand de nouvelles Zones de vide apparaissent.",
	void_message = "Arrivée d'une Zone de vie !",

	seed = "Graine de Corruption",
	seed_desc = "Préviens quand un joueur est affecté par la Graine de Corruption.",
	seed_message = "Graine de Corruption sur %s !",
	seed_bar = "~Détonation",

	icon = "Icône Graine de Corruption",
	icon_desc = "Place une icône de raid sur la personne affecté par la Graine de Corruption (nécessite d'être promu ou mieux).",
} end )

L:RegisterTranslations("zhTW", function() return {
	nova = "暗影新星",
	nova_desc = "暗影新星警報",
	nova_message = "2 秒後暗影新星!",

	void = "虛無區域",
	void_desc = "虛無區域警報",
	void_message = "虛無區域來臨!",

	seed = "腐蝕種子",
	seed_desc = "隊友受到腐蝕種子的傷害時發出警報",
	seed_message = "%s 受到腐蝕種子的傷害!",
	seed_bar = "引爆",

	icon = "腐蝕種子團隊標記",
	icon_desc = "在受到腐蝕種子的隊友頭上標記（需要助理或領隊權限）",
} end )

L:RegisterTranslations("zhCN", function() return {
	nova = "暗影新星",
	nova_desc = "当暗影新星时发出警报。",
	nova_message = "2秒后，暗影新星！",

	void = "虚空领域",
	void_desc = "当虚空领域时发出警报。",
	void_message = "虚空领域 来临！",

	seed = "腐蚀之种",
	seed_desc = "当受到腐蚀伤害发出警报。",
	seed_message = "腐蚀之种：>%s<！",
	seed_bar = "<腐蚀之种 - 引爆>",

	icon = "团队标记",
	icon_desc = "为中腐蚀之种的队员打上团队标记。",
} end )

L:RegisterTranslations("deDE", function() return {
	nova = "Schattennova",
	nova_desc = "Vor Schattennova warnen",
	nova_message = "Schattennova in 2 Sekunden!",

	void = "Zone der Leere",
	void_desc = "Vor neuen Zonen der Leere warnen",
	void_message = "Zone der Leere kommt!",

	seed = "Saat der Verderbnis",
	seed_desc = "Warnen wer Saat der Verderbnis bekommt",
	seed_message = "Saat der Verderbnis auf %s!",
	seed_bar = "~Explosion",

	icon = "Saat der Verderbnis Raid Symbol",
	icon_desc = "Ein Raid Symbol auf die Person setzen, die von Saat der Verderbnis betroffen ist. (Ben\195\182tigt h\195\182heren Rang)",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Arcatraz"]
mod.enabletrigger = boss 
mod.toggleoptions = {"nova", "void", "seed", "icon", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	-- Lots of Shadow Nova spells on wowhead, need the right one
	--self:AddCombatListener("SPELL_START_CAST", "Nova", #####)
	self:AddCombatListener("SPELL_START_CAST", "VoidZone", 30533)  --Double check spellId
	self:AddCombatListener("SPELL_AURA_APPLIES", "SoC", 32863)  --Double check spellId
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Nova()
	if db.nova then
		self:Message(L["nova_message"], "Important")
	end
end

function mod:VoidZone()
	if db.void then
		self:Message(L["void_message"], "Important")
	end
end

function mod:SoC(player, spellId)
	if not player or not db.seed then return end
	self:Message(fmt(L["seed_message"], player), "Urgent")
	self:Bar(fmt(L["seed_bar"], player), 18, spellId)
	if db.icon then
		self:Icon(player)
	end
end
