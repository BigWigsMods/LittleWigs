
--------------------------------------------------------------------------------
-- TODO:
-- -- Improve timers, especially initial timers when entering last phase (after Naaru's Lament)
-- -- Check if any (important) abilities are missing

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("L'ura", 1178, 1982)
if not mod then return end
mod:RegisterEnableMob(124729) -- L'ura
mod.engageId = 2068

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
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
	self:Log("SPELL_CAST_START", "CalltotheVoid", 247795)
	self:Log("SPELL_AURA_APPLIED", "NaarusLament", 248535)
	self:Log("SPELL_CAST_SUCCESS", "UmbralCadence", 247930)
	self:Log("SPELL_CAST_START", "FragmentofDespair", 245164)
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

function mod:CalltotheVoid(args)
	self:Message(args.spellId, "Important", "Warning")
	self:CDBar(245164, 8) -- Fragment of Despair
end

function mod:NaarusLament(args)
	self:Message(args.spellId, "Neutral", "Info")
end

function mod:UmbralCadence(args)
	self:Message(args.spellId, "Attention", "Alert")
	self:CDBar(args.spellId, 13.5)
end

function mod:FragmentofDespair(args)
	self:Message(args.spellId, "Important", "Warning")
end

function mod:Backlash(args)
	self:Message(args.spellId, "Positive", "Long")
	self:Bar(args.spellId, 12.5)
end

function mod:GrandShift(args)
	self:Message(args.spellId, "Urgent", "Alarm")
	self:Bar(args.spellId, 14.5)
end
