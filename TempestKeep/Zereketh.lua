------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Zereketh the Unbound"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Zereketh",

	nova = "Shadow Nova",
	nova_desc = "Warn for Shadow Nova",
	nova_trigger = "begins to cast Shadow Nova.$",
	nova_warning = "Shadow Nova in 2 seconds!",

	void = "Void Zone",
	void_desc = "Warns for new Void Zones",
	void_trigger = "casts Void Zone.$",
	void_warning = "Void Zone incomimg!",

	seed = "Seed of Corruption",
	seed_desc = "Warn for who gets Seed of Corruption",
	seed_trigger = "^([^%s]+) ([^%s]+) afflicted by Seed of Corruption.",
	seed_warning = "Seed of Corruption on %s!",
	seed_bar = "~Detonation",

	icon = "Seed of Corruption Raid Icon",
	icon_desc = "Put a Raid Icon on the person who has Seed of Corruption. (Requires promoted or higher)",
} end )

L:RegisterTranslations("koKR", function() return {
	nova = "암흑 회오리",
	nova_desc = "암흑 회오리에 대한 경고",
	nova_trigger = "암흑 회오리 시전을 시작합니다.$",
	nova_warning = "2초 이내 암흑 회오리!",

	void = "공허의 지대",
	void_desc = "새로운 공허의 지대에 대한 경고",
	void_trigger = "공허의 지대|1을;를; 시전합니다.$", -- check
	void_warning = "잠시 후 공허의 지대!",

	seed = "부패의 씨앗",
	seed_desc = "부패의 씨앗에 걸린 사람에 대한 경고",
	seed_trigger = "^([^|;%s]*)(.*)부패의 씨앗에 걸렸습니다.",
	seed_warning = "%s에 부패의 씨앗!",
	seed_bar = "~폭발",

	icon = "전술 표시",
	icon_desc = "부패의 씨앗에 걸린 사람에 전술 표시를 지정합니다. (승급자 이상의 권한 요구)",
} end )

L:RegisterTranslations("zhTW", function() return {
	cmd = "Zereketh",

	nova = "Shadow Nova",
	nova_desc = "Warn for Shadow Nova",
	nova_trigger = "begins to cast Shadow Nova.$",
	nova_warning = "Shadow Nova in 2 seconds!",

	void = "Void Zone",
	void_desc = "Warns for new Void Zones",
	void_trigger = "casts Void Zone.$",
	void_warning = "Void Zone incomimg!",

	seed = "Seed of Corruption",
	seed_desc = "Warn for who get's Seed of Corruption",
	seed_trigger = "^([^%s]+) ([^%s]+) afflicted by Gift of the Doomsayer.",
	seed_warning = "Seed of Corruption is on %s!",
	seed_bar = "~Detonation",

	icon = "Seed of Corruption Raid Icon",
	icon_desc = "Put a Raid Icon on the person who has Seed of Corruption. (Requires promoted or higher)",
} end )

L:RegisterTranslations("frFR", function() return {
	nova = "Nova de l'ombre",
	nova_desc = "Préviens de l'arrivée des Novas de l'ombre.",
	nova_trigger = "commence à lancer Nova de l'ombre.$",
	nova_warning = "Nova de l'ombre dans 2 sec. !",

	void = "Zone de vide",
	void_desc = "Préviens quand de nouvelles Zones de vide apparaissent.",
	void_trigger = "lance Zone de vide.$",
	void_warning = "Arrivée d'une Zone de vie !",

	seed = "Graine de Corruption",
	seed_desc = "Préviens quand un joueur est affecté par la Graine de Corruption.",
	seed_trigger = "^([^%s]+) ([^%s]+) subit les effets .* Graine de Corruption.",
	seed_warning = "Graine de Corruption sur %s !",
	seed_bar = "~Détonation",

	icon = "Icône Graine de Corruption",
	icon_desc = "Place une icône de raid sur la personne affecté par la Graine de Corruption (nécessite d'être promu ou mieux).",
} end )

L:RegisterTranslations("zhTW", function() return {
	nova = "暗影新星",
	nova_desc = "暗影新星警報",
	nova_trigger = "%s開始施放暗影新星。",
	nova_warning = "2 秒後暗影新星！",

	void = "虛空地區",
	void_desc = "虛空地區警報",
	void_trigger = "%s施放了虛空地區。",
	void_warning = "虛空地區來臨！",

	seed = "腐蝕種子",
	seed_desc = "隊友受到腐蝕種子的傷害時發出警報",
	seed_trigger = "^(.+)受到(.*)腐蝕種子的傷害。",
	seed_warning = "%s 受到腐蝕種子的傷害！",
	seed_bar = "引爆",

	icon = "腐蝕種子團隊標記",
	icon_desc = "在受到腐蝕種子的隊友頭上標記（需要助理或領隊權限）",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Arcatraz"]
mod.enabletrigger = boss 
mod.toggleoptions = {"nova", "void", "seed", "icon", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE(msg)
	if self.db.profile.nova and msg:find(L["nova_trigger"]) then
		self:Message(L["nova_warning"], "Important")
	end
	if self.db.profile.void and msg:find(L["void_trigger"]) then
		self:Message(L["void_warning"], "Important")
	end
end

function mod:CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE(msg)
	if not self.db.profile.seed then return end
	local player, type = select(3, msg:find(L["seed_trigger"]))
	if player and type then
		if player == L2["you"] and type == L2["are"] then
			player = UnitName("player")
		end
		self:Message(L["seed_warning"]:format(player), "Urgent")
		self:Bar(L["seed_bar"]:format(player), 18, "Spell_Shadow_SeedOfDestruction")
		if self.db.profile.icon then
			self:Icon(player)
		end
	end
end
