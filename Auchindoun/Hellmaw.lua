------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Ambassador Hellmaw"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local started=nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Hellmaw",

	fear = "Fear Cooldown",
	fear_desc = "Bar and warning for the cooldown on Ambassador Hellmaw's fear.",
	fear_message = "Fear cooldown expired!",
	fear_bar = "Fear Cooldown",
	
	enrage = "Enrage(Heroic)",
	enrage_desc = "Warnings and bar for when Ambassador Hellmaw will enrage.",
	enrage_message = "Enrage in %s seconds",
	enrage_bar = "Enrage",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = BZ["Shadow Labyrinth"]
mod.enabletrigger = boss 
mod.toggleoptions = {"fear", -1, "enrage", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	started = nil
	
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Fear", 33547)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	self:RegisterEvent("BigWigs_RecvSync")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Fear()
	if self.db.profile.fear then
		self:Bar(L["fear_bar"], 25, 33547)
		self:IfMessage(L["fear_message"], "Attention", 33547)
	end
end

function mod:BigWigs_RecvSync(sync, rest, nick)
	if self:ValidateEngageSync(sync, rest) and not started then
		started = true
		if self:IsEventRegistered("PLAYER_REGEN_DISABLED") then
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		end
		if self.db.profile.enrage and GetInstanceDifficulty() == 2 then
			self:Bar(L["enrage_bar"], 180, 32964)
			self:DelayedMessage(135, L["enrage_message"]:format("45"), "Important", nil, nil, nil, 32964)
			self:DelayedMessage(165, L["enrage_message"]:format("15"), "Important", nil, nil, nil, 32964)
		end
	end
end
