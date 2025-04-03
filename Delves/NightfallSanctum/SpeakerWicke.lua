--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Speaker Wicke", 2686)
if not mod then return end
mod:RegisterEnableMob(
	234058, -- Speaker Wicke
	238833 -- Reformed Fury
)
mod:SetEncounterID(3147) -- Reformed Fury
mod:SetRespawnTime(15)
mod:SetAllowWin(true)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.speaker_wicke = "Speaker Wicke"
	L.reformed_fury = "Reformed Fury"
	L.warmup_icon = "ability_rogue_nightblade"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.speaker_wicke
	self:SetSpellRename(443837, CL.frontal_cone) -- Shadow Sweep (Frontal Cone)
	self:SetSpellRename(444408, CL.dodge) -- Speaker's Wrath (Dodge)
	self:SetSpellRename(434281, CL.explosion) -- Echo of Renilash (Explosion)
end

function mod:GetOptions()
	return {
		-- Speaker Wicke
		443837, -- Shadow Sweep
		470592, -- Blessing of Dusk
		444408, -- Speaker's Wrath
		-- Reformed Fury
		"warmup",
		444479, -- Darkfire Volley
		470593, -- Inflict Death
		434281, -- Echo of Renilash
	},{
		[443837] = L.speaker_wicke,
		["warmup"] = L.reformed_fury,
	},{
		[443837] = CL.frontal_cone, -- Shadow Sweep (Frontal Cone)
		[444408] = CL.dodge, -- Speaker's Wrath (Dodge)
		[434281] = CL.explosion, -- Echo of Renilash (Explosion)
	}
end

function mod:OnBossEnable()
	-- Speaker Wicke
	self:Log("SPELL_CAST_START", "ShadowSweep", 443837)
	self:Log("SPELL_CAST_START", "BlessingOfDusk", 470592)
	self:Log("SPELL_CAST_START", "SpeakersWrath", 444408)
	self:Death("SpeakerWickeDeath", 234058)

	-- Reformed Fury
	self:Log("SPELL_CAST_START", "DarkfireVolley", 444479)
	self:Log("SPELL_CAST_START", "InflictDeath", 470593)
	self:Log("SPELL_CAST_START", "EchoOfRenilash", 434281)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(443837, 3.2, CL.frontal_cone) -- Shadow Sweep
	self:CDBar(470592, 7.2) -- Blessing of Dusk
	self:CDBar(444408, 12.1, CL.dodge) -- Speaker's Wrath
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Speaker Wicke

function mod:ShadowSweep(args)
	self:Message(args.spellId, "orange", CL.frontal_cone)
	self:CDBar(args.spellId, 8.5, CL.frontal_cone)
	self:PlaySound(args.spellId, "alarm")
end

function mod:BlessingOfDusk(args)
	-- also cast by trash
	if self:MobId(args.sourceGUID) == 234058 then -- Speaker Wicke
		self:Message(470592, "red", CL.casting:format(args.spellName))
		self:CDBar(470592, 25.5)
		self:PlaySound(470592, "alert")
	end
end

function mod:SpeakersWrath(args)
	self:Message(args.spellId, "yellow", CL.extra:format(args.spellName, CL.dodge))
	self:CDBar(args.spellId, 23.0, CL.dodge)
	self:PlaySound(args.spellId, "long")
end

function mod:SpeakerWickeDeath()
	-- this event sometimes fires again later on, use the stage to throttle
	if self:GetStage() == 1 then
		self:SetStage(2)
		self:StopBar(CL.frontal_cone) -- Shadow Sweep
		self:StopBar(470592) -- Blessing of Dusk
		self:StopBar(CL.dodge) -- Speaker's Wrath
		self:Bar("warmup", 4.7, CL.active, L.warmup_icon) -- time until Reformed Fury spawns
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT") -- to detect Reformed Fury engage
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	-- Reformed Fury doesn't pull right away, timers start when the boss engages
	if self:GetBossId(238833) then -- Reformed Fury
		self:UnregisterEvent(event)
		self:CDBar(444479, 6.0) -- Darkfire Volley
		self:CDBar(470593, 8.5) -- Inflict Death
		self:CDBar(434281, 13.4, CL.explosion) -- Echo of Renilash
	end
end

-- Reformed Fury

function mod:DarkfireVolley(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 21.8)
	self:PlaySound(args.spellId, "alert")
end

function mod:InflictDeath(args)
	-- also cast by trash
	if self:MobId(args.sourceGUID) == 238833 then -- Reformed Fury
		self:Message(470593, "yellow", CL.casting:format(args.spellName))
		self:CDBar(470593, 15.8)
		self:PlaySound(470593, "alert")
	end
end

function mod:EchoOfRenilash(args)
	-- also cast by trash
	if self:MobId(args.sourceGUID) == 238833 then -- Reformed Fury
		self:Message(args.spellId, "orange", CL.explosion)
		self:CDBar(args.spellId, 32.8, CL.explosion)
		self:PlaySound(args.spellId, "alarm")
	end
end
