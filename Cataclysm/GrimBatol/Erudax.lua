
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Erudax", 757, 134)
if not mod then return end
mod:RegisterEnableMob(40484)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.summon = "Summon Faceless Guardian"
	L.summon_desc = "Warn when Erudax summons a Faceless Guardian"
	L.summon_message = "Faceless Guardian Summoned"
	L.summon_trigger = "%s summons a"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		75664, -- Shadow Gale
		"summon",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ShadowGale", 75664)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE", "Summon")

	self:Death("Win", 40484)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ShadowGale(args)
	self:Bar(args.spellId, 5)
	self:Message(args.spellId, "Urgent", "Alert", CL.casting:format(args.spellName))
end

function mod:Summon(_, msg)
	if msg:find(L.summon_trigger) then
		self:Message("summon", "Important", nil, L["summon_message"])
	end
end

