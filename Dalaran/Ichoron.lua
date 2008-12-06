------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Ichoron"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Ichoron",

	bubble = "Protective Bubble",
	bubble_desc = "Announce when Icharon loses the Protective Bubble",
	bubble_message = "Gained Protective Bubble",
	bubbleEnded_message = "Protective Bubble Faded",

	frenzy = "Frenzy",
	frenzy_desc = "Warn when Ichoron becomes Frenzied.",
} end )

L:RegisterTranslations("koKR", function() return {
} end )

L:RegisterTranslations("frFR", function() return {
} end )

L:RegisterTranslations("zhTW", function() return {
	bubble = "保護泡泡",
	bubble_desc = "Announce when Icharon loses the 保護泡泡",
	bubble_message = "Gained 保護泡泡",
	bubbleEnded_message = "保護泡泡 Faded",

	frenzy = "狂亂",
	frenzy_desc = "Warn when Ichoron becomes 狂亂",
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
	bubble = "保护气泡",
	bubble_desc = "Announce when Icharon loses the 保护气泡",
	bubble_message = "Gained 保护气泡",
	bubbleEnded_message = "保护气泡 Faded",

	frenzy = "狂乱",
	frenzy_desc = "Warn when Ichoron becomes 狂乱.",
} end )

L:RegisterTranslations("ruRU", function() return {
	bubble = "Защитный пузырь",
	bubble_desc = "Предупреждать о потере Защитного пузыря",
	bubble_message = "Наложен Защитный пузырь",
	bubbleEnded_message = "Защитный пузырь исчерпан",

	frenzy = "Бешенство",
	frenzy_desc = "Предупреждать когда Гнойрон впадает в Бешенство.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod.zonename = BZ["The Violet Hold"]
mod.enabletrigger = boss 
mod.guid = 29313
mod.toggleoptions = {"bubble", "frenzy", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Bubble", 54306)
	self:AddCombatListener("SPELL_AURA_REMOVED", "BubbleRemoved", 54306)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Frenzy", 54312, 59522)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Bubble(_, spellId)
	if self.db.profile.bubble then
		self:IfMessage(L["bubble_message"], "Important", spellId)
	end
end

function mod:BubbleRemoved(_, spellId)
	if self.db.profile.bubble then
		self:IfMessage(L["bubbleEnded_message"], "Positive", spellId)
	end
end

function mod:Frenzy(_, spellId, _, _, spellName)
	if self.db.profile.frenzy then
		self:IfMessage(spellName, "Important", spellId)
	end
end
