
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Opera Hall: Wikket", 1115, 1820)
if not mod then return end
mod:RegisterEnableMob(
	114339, -- Barnes
	114251, -- Galindre
	114284  -- Elfyra
)
--mod.engageId = 1957 -- Same for every opera event. So it's basically useless.

--------------------------------------------------------------------------------
-- Locals
--

local L = mod:NewLocale("enUS", true)
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter."
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_autotalk", -- Barnes
		227447, -- Defy Gravity
		227410, -- Wondrous Radiance
		227776, -- Magic Magnificent
		227477, -- Summon Assistants
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Log("SPELL_CAST_START", "DefyGravity", 227447)
	self:Log("SPELL_CAST_SUCCESS", "WondrousRadiance", 227410)
	self:Log("SPELL_CAST_START", "MagicMagnificent", 227776)
	self:Log("SPELL_CAST_SUCCESS", "SummonAssistants", 227477)

	self:RegisterEvent("GOSSIP_SHOW")

	self:RegisterEvent("BOSS_KILL")
end

function mod:OnEngage()
	self:Bar(227410, 8.5) -- Wondrous Radiance
	self:Bar(227447, 10.5) -- Defy Gravity
	self:Bar(227477, 32) -- Summon Assistants
	self:Bar(227776, 48.5) -- Magic Magnificent
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DefyGravity(args)
	self:Message(args.spellId, "Attention", "Info")
	self:CDBar(args.spellId, 17)
end

function mod:WondrousRadiance(args)
	self:Message(args.spellId, "Urgent", self:Tank() and "Warning")
	self:CDBar(args.spellId, 11)
end

function mod:MagicMagnificent(args)
	self:Message(args.spellId, "Important", "Long")
	self:Bar(args.spellId, 5, CL.cast:format(args.spellName))
end

function mod:SummonAssistants(args)
	self:Message(args.spellId, "Urgent", "Alert")
	self:CDBar(args.spellId, 32.5)
end

function mod:BOSS_KILL(_, id)
	if id == 1957 then
		self:Win()
	end
end

-- Barnes
function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") and self:MobId(UnitGUID("npc")) == 114339 then
		if GetGossipOptions() then
			SelectGossipOption(1, "", true) -- auto confirm it
		end
	end
end