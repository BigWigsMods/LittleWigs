------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Hungarfen"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local sporesannounced = nil
local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Hungarfen",

	shroom = "Underbog Mushroom",
	shroom_desc = "Warn when an Underbog Mushroom spawns",
	shroom_message = "Underbog Mushroom spawning!",

	spores = "Foul Spores",
	spores_desc = "Warn for when Hungarfen roots himself casts Foul Spores",
	spores_message = "Foul Spores Soon!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod.zonename = BZ["The Underbog"]
mod.enabletrigger = boss
mod.toggleoptions = {"shroom", "spores", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("UNIT_HEALTH")
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Shroom", 31693)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	sporesannounced = nil
	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------
--
function mod:Shroom()
	if db.shroom then
		self:Message(L["shroom_message"], "Important", nil, nil, nil, 31693)
	end
end

function mod:UNIT_HEALTH(arg1)
	if not db.spores then
		self:UnregisterEvent("UNIT_HEALTH")
		return
	end
	if UnitName(arg1) == boss then
		local health = UnitHealth(arg1)
		if health > 18 and health <= 24 and not sporesannounced then
			sporesannounced = true
			self:Message(L["spores_message"], "Urgent", nil, nil, nil, 31673)
		elseif health > 28 and sporesannounced then
			sporesannounced = nil
		end
	end
end
