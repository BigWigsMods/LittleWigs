------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Pathaleon the Calculator"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Pathaleon",

	summon = "Summoned Wraiths",
	summon_desc = "Warn when Nether Wraiths are summoned",
	summon_trigger = "casts Summon Nether Wraith",
	summon_warn = "Nether Wraiths Summoned!",
	
	despawn = "Despawned Wraiths",
	despawn_desc = "Warn when Nether Wraiths are about to despawn",
	despawn_warn = "Nether Wraiths Despawning Soon!",

	mc = "Mind Control",
	mc_desc = "Warn for Mind Control",
	mc_trigger = "^([^%s]+) ([^%s]+) afflicted by Domination.",
	mc_warn = " is Mind Controlled!",
} end )

L:RegisterTranslations("koKR", function() return {
	summon = "망령 소환",
	summon_desc = "황천의 망령 소환 시 경고",
	summon_trigger = "날 위해 일해 줘야겠다!", -- "casts Summon Nether Wraith",
	summon_warn = "황천의 망령 소환!",

	mc = "정신 지배",
	mc_desc = "정신 지배에 대한 경고",
	mc_trigger = "^([^|;%s]*)(.*)지배에 걸렸습니다.", -- check
	mc_warn = " 정신 지배!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Mechanar"]
mod.enabletrigger = boss 
mod.toggleoptions = {"summon", "despawn", -1, "mc", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	summon_time = 0
	self:RegisterEvent("UNIT_HEALTH")	
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF(msg)
	if ( (time() - summon_time) < 3) then return end
	if self.db.profile.summon and msg:find(L["summon_trigger"]) then
		self:Message(L["summon_warn"], "Important")
		summon_time = time()
	end
end

function mod:CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE(msg)
	local player, type = select(3, msg:find(L["mc_trigger"]))
	if player and type then
		if player == L2["you"] and type == L2["are"] then
			player = UnitName("player")
		end
		if self.db.profile.mc then self:Message(player .. L["mc_warn"], "Important") end
	end	
end

function mod:UNIT_HEALTH(arg1)
	if not self.db.profile.despawn then return end
	if UnitName(arg1) == boss then
		local health = UnitHealth(arg1)
		if health > 20 and health <= 25 then
			self:Message(L["despawn_warn"], "Important")
		end
	end
end
