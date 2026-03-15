--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("L'ura", 1753, 1982)
if not mod then return end
mod:RegisterEnableMob(124729) -- L'ura
mod:SetEncounterID(2068)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1265426, sound = "alarm"}, -- Discordant Beam
	{1265650, sound = "alert"}, -- Anguish
})

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_text = "L'ura Active"
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
	self:Log("SPELL_CAST_START", "CalltotheVoid", 247795)
	self:Log("SPELL_AURA_APPLIED", "NaarusLament", 248535)
	self:Log("SPELL_CAST_SUCCESS", "UmbralCadence", 247930)
	self:Log("SPELL_CAST_SUCCESS", "FragmentofDespair", 245164)
	self:Log("SPELL_AURA_APPLIED", "Backlash", 247816)

	--[[ Mythic ]]--
	self:Log("SPELL_CAST_START", "GrandShift", 249009)
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			"warmup",
			{1265426, "PRIVATE"}, -- Discordant Beam
			{1265650, "PRIVATE"}, -- Anguish
		}
	end

	function mod:OnBossEnable()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:WarmupEarly() -- Called from trash module
	self:Bar("warmup", 30.2, L.warmup_text, "spell_priest_divinestar_shadow")
end

function mod:WarmupLate() -- Called from trash module
	self:Bar("warmup", 8.47, L.warmup_text, "spell_priest_divinestar_shadow")
end

function mod:CalltotheVoid(args)
	self:Message(args.spellId, "red")
	self:CDBar(245164, 11) -- Fragment of Despair
	self:PlaySound(args.spellId, "warning")
end

function mod:NaarusLament(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

function mod:UmbralCadence(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 10.5)
	self:PlaySound(args.spellId, "alert")
end

function mod:FragmentofDespair(args)
	self:Message(args.spellId, "red", CL.incoming:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:Backlash(args)
	self:Message(args.spellId, "green")
	self:Bar(args.spellId, 12.5)
	self:PlaySound(args.spellId, "long")
end

function mod:GrandShift(args)
	self:Message(args.spellId, "orange")
	self:Bar(args.spellId, 14.5)
	self:PlaySound(args.spellId, "alarm")
end
