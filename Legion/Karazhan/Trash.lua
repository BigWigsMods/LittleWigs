
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Karazhan Trash", 1115)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	114544, -- Skeletal Usher
	114339 -- Barnes
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.skeletalUsher = "Skeletal Usher"
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter."
	L.opera_hall_westfall_story_text = "Opera Hall: Westfall Story"
	L.opera_hall_westfall_story_trigger = "we meet two lovers" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.barnes = "Barnes"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		227966, -- Flashlight
		"custom_on_autotalk", -- Barnes
		"warmup", -- Opera Hall event timer
	}, {
		[227966] = L.skeletalUsher,
		["custom_on_autotalk"] = L.barnes,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:Log("SPELL_CAST_START", "Flashlight", 227966)

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Skeletal Usher
do
	local prev = 0
	function mod:Flashlight(args)
		local t = GetTime()
		if t-prev > 3 then
			prev = t
			self:Message(args.spellId, "Attention", "Info")
		end
		self:Bar(args.spellId, 3)
	end
end

-- Barnes
function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") and self:MobId(UnitGUID("npc")) == 114339 then
		if GetGossipOptions() then
			SelectGossipOption(1)
		end
	end
end

function mod:Warmup(_, msg)
	if msg:find(L.opera_hall_westfall_story_trigger, nil, true) then 
		self:Bar("warmup", 42, L.opera_hall_westfall_story_text, "achievement_raid_karazhan")
	end
end
