------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Quagmirran"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Quagmirran",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod.zonename = BZ["The Slave Pens"]
mod.enabletrigger = boss
mod.toggleoptions = {"bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------
