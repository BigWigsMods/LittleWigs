------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Exarch Maladaar"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local warned = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Maladaar",

	soul = "Stolen Soul",
	soul_desc = "Warn for Stolen Souls",
	soul_message = "%s's soul stolen!",

	avatar = "Avatar of the Martyred",
	avatar_desc = "Warn for the summoning of the Avatar of the Martyred",
	avatar_message = "Avatar of the Martyred spawning!",
	avatar_soon = "Avatar of the Martyred Spawning Soon",
} end )

L:RegisterTranslations("koKR", function() return {
	soul = "잃어버린 영혼 ",
	soul_desc = "잃어버린 영혼에 대한 경고",
	soul_message = "%s에 잃어버린 영혼!",

	avatar = "순교자의 화신",
	avatar_desc = "순교자의 화신 소환 경고",
	avatar_message = "순교자의 화신 소환!",
	avatar_soon = "잠시 후 순교자의 화신 소환",
} end )

L:RegisterTranslations("zhTW", function() return {
	soul = "偷取的靈魂",
	soul_desc = "主教瑪拉達爾施放靈魂偷取時發出警報",
	soul_message = "%s 的靈魂被偷取!",

	avatar = "馬丁瑞德的化身",
	avatar_desc = "召喚馬丁瑞德的化身時發出警報",
	avatar_message = "馬丁瑞德的化身出現!",
} end )

L:RegisterTranslations("frFR", function() return {
	soul = "Âme volée",
	soul_desc = "Prévient quand une âme est volée.",
	soul_message = "L'âme de %s a été volée !",

	avatar = "Avatar du martyr",
	avatar_desc = "Prévient quand l'Avatar du martyr est invoqué.",
	avatar_message = "Avatar du martyr invoqué !",
} end )

L:RegisterTranslations("zhCN", function() return {
	soul = "灵魂偷取",
	soul_desc = "施放灵魂偷取时发出警报。",
	soul_message = "灵魂偷取：>%s<！",

	avatar = "殉难者的化身",
	avatar_desc = "当召唤殉难者的化身时发出警报。",
	avatar_message = "殉难者的化身出现！",
} end )

L:RegisterTranslations("deDE", function() return {
	soul = "Gestohlene Seele",
	soul_desc = "Warnt vor gestohlener Seele",

	avatar = "Avatar des Gemarterten",
	avatar_desc = "Warnt vor der Avatar Beschw\195\182rung",
	avatar_message = "Avatar beschworen!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = BZ["Auchenai Crypts"]
mod.enabletrigger = boss 
mod.guid = 18373
mod.toggleoptions = {"soul", "avatar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	warned = nil

	self:RegisterEvent("UNIT_HEALTH")
	self:AddCombatListener("SPELL_AURA_APPLIED", "Soul", 32346)
	self:AddCombatListener("SPELL_CAST_START", "Avatar", 32424)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Soul(player)
	if self.db.profile.soul then
		self:IfMessage(L["soul_message"]:format(player), "Attention", 32346)
	end
end

function mod:Avatar()
	if self.db.profile.avatar then
		self:Message(L["avatar_message"], "Attention")
	end
end

function mod:UNIT_HEALTH(arg1)
	if not self.db.profile.avatar then return end
	if UnitName(arg1) == boss then
		local health = UnitHealth(arg1)
		if health > 28 and health <= 33 and not warned then
			warned = true
			self:IfMessage(L["avatar_soon"], "Important", 32424)
		elseif health > 33 and warned then
			warned = nil
		end
	end
end
