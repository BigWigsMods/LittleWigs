------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Ionar"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local pName = UnitName("player")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Ionar",

	overload = "Static Overload",
	overload_desc = "Warn for who has the Static Overload.",
	overload_message = "%s: Static Overload",

	overloadWhisper = "Static Overload Whisper",
	overloadWhisper_desc = "Send a whisper to the person with the Static Overload.",
	overloadWhisper_message = "You have the Static Overload!",

	overloadBar = "Static Overload Bar",
	overloadBar_desc = "Show a bar for who has the Static Overload.",
} end)

L:RegisterTranslations("deDE", function() return {
} end)

L:RegisterTranslations("frFR", function() return {
	overload = "Surcharge statique",
	overload_desc = "Prévient quand un joueur subit les effets de la Surcharge statique.",
	overload_message = "%s : Surcharge statique",

	overloadWhisper = "Surcharge statique - Chuchotement",
	overloadWhisper_desc = "Prévient par chuchotement la personne affectée par la Surcharge statique.",
	overloadWhisper_message = "Vous avez la Surchage statique !",

	overloadBar = "Surcharge statique - Barre",
	overloadBar_desc = "Affiche une barre indiquant la durée de la Surcharge statique de la personne affectée.",
} end)

L:RegisterTranslations("koKR", function() return {
} end)

L:RegisterTranslations("zhCN", function() return {
} end)

L:RegisterTranslations("zhTW", function() return {
} end)

L:RegisterTranslations("esES", function() return {
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Ulduar"
mod.zonename = BZ["Halls of Lightning"]
mod.enabletrigger = boss
mod.guid = 28546
mod.toggleoptions = {"overload","overloadWhisper","overloadBar","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Overload", 52658, 59796)
	self:AddCombatListener("SPELL_AURA_REMOVED", "OverloadRemoved", 52658, 59796)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Overload(player, spellId)
	if self.db.profile.overload then
		self:IfMessage(L["overload_message"]:format(player), "Urgent", spellId)
	end
	if self.db.profile.overloadWhisper and (pName ~= player) then
		self:Whisper(player, L["overloadWhisper_message"])
	end	
	if self.db.profile.overloadBar then
		self:Bar(L["overload_message"]:format(player), 10, spellId)
	end
end

-- I don't have any logs for this instance yet. I suspect this is not dispellable, if it is not,
-- then we don't need the remove, please verify
function mod:OverloadRemoved(player)
	if self.db.profile.overloadBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["overload_message"]:format(player))
	end
end
