
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Karazhan Trash", 1115)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	114544, -- Skeletal Usher
	114339, -- Barnes
	114542, -- Ghostly Philanthropist
	114632, -- Spectral Attendant
	114636, -- Phantom Guardsman
	114783, -- Reformed Maiden
	114796 -- Wholesome Hostess
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.skeletalUsher = "Skeletal Usher"
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter."
	L.attendant = "Spectral Attendant"
	L.hostess = "Wholesome Hostess"
	L.maiden = "Reformed Maiden"
	L.philanthropist = "Ghostly Philanthropist"
	L.guardsman = "Phantom Guardsman"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		227966, -- Flashlight
		"custom_on_autotalk", -- Barnes
		228279, -- Shadow Rejuvenation
		228575, -- Alluring Aura
		228625, -- Banshee Wail
		227999, -- Pennies from Heaven
		228528, -- Heartbreaker
		241774  -- Shield Smash
	}, {
		[227966] = L.skeletalUsher,
		["custom_on_autotalk"] = "general",
		[228279] = L.attendant,
		[228575] = L.hostess,
		[227999] = L.philanthropist,
		[228528] = L.maiden,
		[241774] = L.guardsman
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:Log("SPELL_CAST_START", "Flashlight", 227966)
	self:Log("SPELL_CAST_START", "ShadowRejuvenation", 228279)
	self:Log("SPELL_CAST_START", "AlluringAura", 228575)
	self:Log("SPELL_CAST_START", "BansheeWail", 228625)
	self:Log("SPELL_CAST_START", "PenniesFromHeaven", 227999)
	self:Log("SPELL_CAST_START", "Heartbreaker", 228528)
	self:Log("SPELL_CAST_START", "ShieldSmash", 241774)

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

-- Spectral Attendant
function mod:ShadowRejuvenation(args)
	self:Message(args.spellId, "Attention", "Warning", CL.casting:format(args.spellName))
end

-- Wholesome Hostess
function mod:AlluringAura(args)
	self:Message(args.spellId, "Important", "Alert", CL.casting:format(args.spellName))
end

function mod:BansheeWail(args)
	self:Message(args.spellId, "Attention", "Warning", CL.casting:format(args.spellName))
end

-- Ghostly Philanthropist
function mod:PenniesFromHeaven(args)
	self:Message(args.spellId, "Info", "Alert", CL.casting:format(args.spellName))
end

-- Reformed Maiden
function mod:Heartbreaker(args)
	self:Message(args.spellId, "Info", "Warning", CL.casting:format(args.spellName))
end

-- Phantom Guardsman
function mod:ShieldSmash(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end
