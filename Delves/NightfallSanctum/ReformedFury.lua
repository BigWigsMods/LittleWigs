if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Reformed Fury", 2686)
if not mod then return end
mod:RegisterEnableMob(
	218022, -- Speaker Davenruth
	218034 -- Reformed Fury
)
mod:SetEncounterID(2998)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.speaker_davenruth = "Speaker Davenruth"
	L.reformed_fury = "Reformed Fury"
	L.warmup_icon = "ability_rogue_nightblade"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.reformed_fury
end

function mod:GetOptions()
	return {
		-- Speaker Davenruth
		443837, -- Shadow Sweep
		443482, -- Blessing of Dusk
		444408, -- Speaker's Wrath
		-- Reformed Fury
		"warmup",
		444479, -- Darkfire Volley
		440205, -- Inflict Death
		434281, -- Echo of Renilash
	}, {
		[443837] = L.speaker_davenruth,
		["warmup"] = L.reformed_fury,
	}
end

function mod:OnBossEnable()
	-- Speaker Davenruth
	self:Log("SPELL_CAST_START", "ShadowSweep", 443837)
	self:Log("SPELL_CAST_START", "BlessingOfDusk", 443482)
	self:Log("SPELL_CAST_START", "SpeakersWrath", 444408)
	self:Death("SpeakerDavenruthDeath", 218022)

	-- Reformed Fury
	self:Log("SPELL_CAST_START", "DarkfireVolley", 444479)
	self:Log("SPELL_CAST_START", "InflictDeath", 440205)
	self:Log("SPELL_CAST_START", "EchoOfRenilash", 434281)
end

function mod:OnEngage()
	self:CDBar(443837, 3.6) -- Shadow Sweep
	self:CDBar(443482, 7.2) -- Blessing of Dusk
	self:CDBar(444408, 16.2) -- Speaker's Wrath
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Speaker Davenruth

function mod:ShadowSweep(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 8.5)
end

function mod:BlessingOfDusk(args)
	-- also cast by trash
	if self:MobId(args.sourceGUID) == 218022 then -- Speaker Davenruth
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 25.5)
	end
end

function mod:SpeakersWrath(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 23.1)
end

function mod:SpeakerDavenruthDeath()
	self:StopBar(443837) -- Shadow Sweep
	self:StopBar(443482) -- Blessing of Dusk
	self:StopBar(444408) -- Speaker's Wrath
	self:Bar("warmup", 4.7, CL.active, L.warmup_icon) -- time until Reformed Fury spawns
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT") -- to detect Reformed Fury engage
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	-- Reformed Fury doesn't pull right away, timers start when the boss engages
	if self:GetBossId(218034) then -- Reformed Fury
		self:UnregisterEvent(event)
		self:CDBar(444479, 6.0) -- Darkfire Volley
		self:CDBar(440205, 8.5) -- Inflict Death
		self:CDBar(434281, 13.4) -- Echo of Renilash
	end
end

-- Reformed Fury

function mod:DarkfireVolley(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 21.8)
end

function mod:InflictDeath(args)
	-- also cast by trash
	if self:MobId(args.sourceGUID) == 218034 then -- Reformed Fury
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 15.8)
	end
end

function mod:EchoOfRenilash(args)
	-- also cast by trash
	if self:MobId(args.sourceGUID) == 218034 then -- Reformed Fury
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 32.8)
	end
end
