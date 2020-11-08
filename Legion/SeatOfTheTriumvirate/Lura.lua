
--------------------------------------------------------------------------------
-- TODO:
-- -- Improve timers, especially initial timers when entering last phase (after Naaru's Lament)
-- -- Check if any (important) abilities are missing

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("L'ura", 1753, 1982)
if not mod then return end
mod:RegisterEnableMob(124729) -- L'ura
mod.engageId = 2068

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_text = "L'ura Active"
	L.warmup_trigger = "Such chaos... such anguish. I have never sensed anything like it before."
	L.warmup_trigger_2 = "Such musings can wait, though. This entity must die."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		247795, -- Call to the Void
		248535, -- Naaru's Lament
		247930, -- Umbral Cadence
		245164, -- Fragment of Despair
		247816, -- Backlash
		249009, -- Grand Shift
	},{
		[249009] = "mythic",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY", "Warmup")
	self:Log("SPELL_CAST_START", "CalltotheVoid", 247795)
	self:Log("SPELL_AURA_APPLIED", "NaarusLament", 248535)
	self:Log("SPELL_CAST_SUCCESS", "UmbralCadence", 247930)
	self:Log("SPELL_CAST_SUCCESS", "FragmentofDespair", 245164)
	self:Log("SPELL_AURA_APPLIED", "Backlash", 247816)

	--[[ Mythic ]]--
	self:Log("SPELL_CAST_START", "GrandShift", 249009)
end

function mod:OnEngage()
	-- Nothing?
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg == L.warmup_trigger then
		self:UnregisterEvent(event)
		self:Bar("warmup", 30.2, L.warmup_text, "spell_priest_divinestar_shadow")
	elseif msg == L.warmup_trigger_2 then
		self:UnregisterEvent(event)
		self:Bar("warmup", 8.47, L.warmup_text, "spell_priest_divinestar_shadow")
	end
end

function mod:CalltotheVoid(args)
	self:MessageOld(args.spellId, "red", "warning")
	self:CDBar(245164, 11) -- Fragment of Despair
end

function mod:NaarusLament(args)
	self:MessageOld(args.spellId, "cyan", "info")
end

function mod:UmbralCadence(args)
	self:MessageOld(args.spellId, "yellow", "alert")
	self:CDBar(args.spellId, 10.5)
end

function mod:FragmentofDespair(args)
	self:MessageOld(args.spellId, "red", "warning", CL.incoming:format(args.spellName))
end

function mod:Backlash(args)
	self:MessageOld(args.spellId, "green", "long")
	self:Bar(args.spellId, 12.5)
end

function mod:GrandShift(args)
	self:MessageOld(args.spellId, "orange", "alarm")
	self:Bar(args.spellId, 14.5)
end
