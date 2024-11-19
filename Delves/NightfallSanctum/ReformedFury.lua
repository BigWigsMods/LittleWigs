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
mod:SetStage(1)

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
	self:SetSpellRename(443837, CL.frontal_cone) -- Shadow Sweep (Frontal Cone)
	self:SetSpellRename(444408, CL.dodge) -- Speaker's Wrath (Dodge)
	self:SetSpellRename(434281, CL.explosion) -- Echo of Renilash (Explosion)
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
	},{
		[443837] = L.speaker_davenruth,
		["warmup"] = L.reformed_fury,
	},{
		[443837] = CL.frontal_cone, -- Shadow Sweep (Frontal Cone)
		[444408] = CL.dodge, -- Speaker's Wrath (Dodge)
		[434281] = CL.explosion, -- Echo of Renilash (Explosion)
	}
end

function mod:OnBossEnable()
	-- Speaker Davenruth
	self:Log("SPELL_CAST_START", "ShadowSweep", 443837)
	self:Log("SPELL_CAST_START", "BlessingOfDusk", 443482, 470592)
	self:Log("SPELL_CAST_START", "SpeakersWrath", 444408)
	self:Death("SpeakerDavenruthDeath", 218022)

	-- Reformed Fury
	self:Log("SPELL_CAST_START", "DarkfireVolley", 444479)
	self:Log("SPELL_CAST_START", "InflictDeath", 440205, 470593)
	self:Log("SPELL_CAST_START", "EchoOfRenilash", 434281)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(443837, 3.6, CL.frontal_cone) -- Shadow Sweep
	self:CDBar(443482, 7.2) -- Blessing of Dusk
	self:CDBar(444408, 16.2, CL.dodge) -- Speaker's Wrath
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Speaker Davenruth

function mod:ShadowSweep(args)
	self:Message(args.spellId, "orange", CL.frontal_cone)
	self:CDBar(args.spellId, 8.5, CL.frontal_cone)
	self:PlaySound(args.spellId, "alarm")
end

function mod:BlessingOfDusk(args)
	-- also cast by trash
	if self:MobId(args.sourceGUID) == 218022 then -- Speaker Davenruth
		self:Message(443482, "red", CL.casting:format(args.spellName))
		self:PlaySound(443482, "alert")
		self:CDBar(443482, 25.5)
	end
end

function mod:SpeakersWrath(args)
	self:Message(args.spellId, "yellow", CL.extra:format(args.spellName, CL.dodge))
	self:CDBar(args.spellId, 23.1, CL.dodge)
	self:PlaySound(args.spellId, "long")
end

function mod:SpeakerDavenruthDeath()
	-- this event sometimes fires again later on, use the stage to throttle
	if self:GetStage() == 1 then
		self:SetStage(2)
		self:StopBar(CL.frontal_cone) -- Shadow Sweep
		self:StopBar(443482) -- Blessing of Dusk
		self:StopBar(CL.dodge) -- Speaker's Wrath
		self:Bar("warmup", 4.7, CL.active, L.warmup_icon) -- time until Reformed Fury spawns
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT") -- to detect Reformed Fury engage
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	-- Reformed Fury doesn't pull right away, timers start when the boss engages
	if self:GetBossId(218034) then -- Reformed Fury
		self:UnregisterEvent(event)
		self:CDBar(444479, 6.0) -- Darkfire Volley
		self:CDBar(440205, 8.5) -- Inflict Death
		self:CDBar(434281, 13.4, CL.explosion) -- Echo of Renilash
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
		self:Message(440205, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(440205, "alert")
		self:CDBar(440205, 15.8)
	end
end

function mod:EchoOfRenilash(args)
	-- also cast by trash
	if self:MobId(args.sourceGUID) == 218034 then -- Reformed Fury
		self:Message(args.spellId, "orange", CL.explosion)
		self:CDBar(args.spellId, 32.8, CL.explosion)
		self:PlaySound(args.spellId, "alarm")
	end
end
