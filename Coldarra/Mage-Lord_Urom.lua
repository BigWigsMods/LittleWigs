------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Mage-Lord Urom"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local pName = UnitName("player")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Urom",

	timeBomb = "Time Bomb",
	timeBomb_desc = "Warning for who has the Time Bomb.",
	timeBomb_message = "%s: Time Bomb",

	timeBombWhisper = "Time Bomb Whisper",
	timeBombWhisper_desc = "Send a whisper to the person with the Time Bomb.",
	timeBombWhisper_message = "You have the Time Bomb!",

	timeBombBar = "Time Bomb Bar",
	timeBombBar_desc = "Show a bar until the Time Bomb explodes.",

	arcaneExplosion = "Empowered Arcane Explosion",
	arcaneExplosion_desc = "Warn when Mage-Lord Urom begins to cast Empowered Arcane Explosion.",

	arcaneExplosionBar = "Empowered Arcane Explosion Bar",
	arcaneExplosionBar_desc = "Show a bar for the cast time of Empowered Arcane Explosion.",
} end )

L:RegisterTranslations("koKR", function() return {
} end )

L:RegisterTranslations("frFR", function() return {
	timeBomb = "Bombe à retardement",
	timeBomb_desc = "révient quand un joueur subit les effets de la Bombe à retardement.",
	timeBomb_message = "%s : Bombe à retardement",

	timeBombWhisper = "Bombe à retardement - Chuchotement",
	timeBombWhisper_desc = "Prévient par chuchotement la personne affectée par la Bombe à retardement.",
	timeBombWhisper_message = "Vous avez la Bombe à retardement !",

	timeBombBar = "Bombe à retardement - Barre",
	timeBombBar_desc = "Affiche une barre indiquant le temps restant avant l'explosion de la Bombe à retardement.",

	arcaneExplosion = "Explosion des arcanes surpuissante",
	arcaneExplosion_desc = "Prévient quand le Seigneur-mage Urom commence à incanter son Explosion des arcanes surpuissante.",

	arcaneExplosionBar = "Explosion des arcanes surpuissante - Barre",
	arcaneExplosionBar_desc = "Affiche une barre indiquant la durée de l'incantation de l'Explosion des arcanes surpuissante.",
} end )

L:RegisterTranslations("zhTW", function() return {
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod.zonename = BZ["The Oculus"]
mod.enabletrigger = {boss} 
mod.guid = 27655
mod.toggleoptions = {"timeBomb","timeBombWhisper","timeBombBar",-1,"arcaneExplosion","arcaneExplosionBar","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "TimeBomb", 51121)
	self:AddCombatListener("SPELL_CAST_START", "ArcaneExposion", 51110)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:TimeBomb(player, spellId, _, _, spellName)
	if self.db.profile.timeBomb then
		self:IfMessage(L["timeBomb_message"]:format(player), "Attention", spellId)
	end
	if self.db.profile.timeBombWhisper and (pName ~= player) then
		self:Whisper(player, L["timeBombWhisper_message"])
	end
	if self.db.profile.timeBombBar then
		self:Bar(L["timeBomb_message"]:format(player), 6, spellId)
	end
end

function mod:ArcaneExplosion(_, spellId, _, _, spellName)
	if self.db.profile.arcaneExplosion then
		self:IfMessage(L["arcaneExplosion_message"], "Attention", spellId)
	end
	if self.db.profile.arcaneExplosionBar then
		self:Bar(spellName, 8, spellId)
	end
end
