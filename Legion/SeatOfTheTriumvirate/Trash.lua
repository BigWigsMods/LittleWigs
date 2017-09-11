
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Seat of the Triumvirate Trash", 1178)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	123743, -- Alleria Windrunner
	124171, -- Shadowguard Subjugator
	122404 -- Shadowguard Voidbender
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects Alleria Winrunners gossip option."
	L.custom_on_autotalk_icon = "inv_bow_1h_artifactwindrunner_d_03"
	L.gossip_available = "Gossip available"
	L.alleria_gossip_trigger = "Follow me!" -- Allerias yell after the first boss is defeated

	L.alleria = "Alleria Windrunner"
	L.subjugator = "Shadowguard Subjugator"
	L.voidbender = "Shadowguard Voidbender"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_autotalk",
		"warmup",
		{249081, "SAY"}, -- Suppression Field
		{245510, "SAY"}, -- Corrupting Void
	}, {
		["custom_on_autotalk"] = L.alleria,
		[249081] = L.subjugator,
		[245510] = L.voidbender,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	self:Log("SPELL_AURA_APPLIED", "PersonalAurasWithSay", 249081, 245510) -- Suppression Field, Corrupting Void

	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg == L.alleria_gossip_trigger then
		self:Bar("warmup", 40, L.gossip_available, L.custom_on_autotalk_icon)
	end
end

function mod:PersonalAurasWithSay(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "Personal", "Alarm")
		self:Say(args.spellId)
	end
end

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") and self:MobId(UnitGUID("npc")) == 123743 then
		if GetGossipOptions() then
			SelectGossipOption(1)
		end
	end
end
