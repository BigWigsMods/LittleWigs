------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Herald Volazj"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Volazj",

	insanity = "Insanity",
	insanity_desc = "Warn when Herald Volazj begins to cast Insanity.",
	insanity_message = "Casting Insanity",
	
	shiver = "Shiver",
	shiver_desc = "Warn for who has the Shiver debuff",
	shiver_message = "Shiver: %s",
	
	shiverbar = "Shiver Bar",
	shiverbar_desc = "Show a bar for the duration of the Shiver debuff.",
} end)

L:RegisterTranslations("deDE", function() return {
	insanity = "Wahnsinn",
	insanity_desc = "Warnt wenn Herald Volazj Wahnsinn Zaubert.",
	insanity_message = "Zaubert Wahnsinn",
} end)

L:RegisterTranslations("frFR", function() return {
} end)

L:RegisterTranslations("koKR", function() return {
	insanity = "정신 이상",
	insanity_desc = "Warn when Herald Volazj begins to cast Insanity.",
	insanity_message = "Casting Insanity",
	
	shiver = "오한",
	shiver_desc = "오한 디버프에 걸린 플레이어를 알립니다.",
	shiver_message = "오한: %s",
	
	shiverbar = "오한 바",
	shiverbar_desc = "오한 디버프의 지속 바를 표시합니다.",
} end)

L:RegisterTranslations("zhCN", function() return {
} end)

L:RegisterTranslations("zhTW", function() return {
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod.zonename = BZ["Ahn'kahet: The Old Kingdom"]
mod.enabletrigger = boss
mod.guid = 29311
mod.toggleoptions = {"insantiy","shiver","shiverbar","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Insanity", 57496)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Shiver", 57949, 59978)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ShiverRemoved", 57949, 59978)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Insanity(_, spellId)
	if self.db.profile.insanity then
		self:IfMessage(L["insanity_message"], "Important", spellId)
	end
end

function mod:Shiver(player, spellId, _, _, spellName)
	if self.db.profile.shiver then
		self:IfMessage(L["shiver_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.shiverbar then
		self:Bar(L["shiver_message"]:format(player), 30, spellId)
	end
end

function mod:ShiverRemoved(player)
	if self.db.profile.shiverbar then
		self:TriggerEvent("BigWigs_StopBar", self, L["shiver_message"]:format(player))
	end
end

