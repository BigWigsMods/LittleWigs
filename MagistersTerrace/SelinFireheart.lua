------------------------------
--      Are you local?      --
------------------------------

if not GetSpellInfo then return end

local boss = BB["Selin Fireheart"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Selin",

	channel = "Channel Mana",
	channel_desc = "Warn when Selin Fireheart is channeling mana from a Fel Crystal",
	channel_message = "Channeling Mana!",
	channel_trigger = "channel from the nearby Fel Crystal",
} end )

--[[
	Magister's Terrace modules are PTR beta, as so localization is not
	supported in any way. This gives the authors the freedom to change the
	modules in way that	can potentially break localization.  Feel free to
	localize, just be aware that you may need to change it frequently.
]]--

L:RegisterTranslations("koKR", function() return {
	channel = "분노의 마나",
	channel_desc = "셀린 파이어하트가 지옥 수정에서 마력 흡수에 대해 알립니다.",
	channel_message = "분노의 마나!",
	channel_trigger = "근처의 지옥 수정에서 힘을 끌어냅니다...",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.zonename = BZ["Magisters' Terrace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"channel","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE","Channel")

	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Channel(msg)
	if db.channel and msg:find(L["channel_trigger"]) then
		self:Message(channel_message, "Important")
	end
end
