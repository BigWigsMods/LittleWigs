--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Nokhud Offensive Trash", 2516)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	191847, -- Nokhud Plainstomper
	192800, -- Nokhud Lancemaster
	192796, -- Nokhud Hornsounder
	192794, -- Nokhud Beastmaster
	192803, -- War Ohuna
	194896, -- Primal Stormshield
	194894, -- Primalist Stormspeaker
	194897, -- Stormsurge Totem
	194317, -- Stormcaller Boroo
	195265, -- Stormcaller Arynga
	194315, -- Stormcaller Solongo
	194316, -- Stormcaller Zarii
	195696, -- Primalist Thunderbeast
	195876, -- Desecrated Ohuna
	195851, -- Ukhel Deathspeaker
	195877, -- Risen Mystic
	195878, -- Ukhel Beastcaller
	195927, -- Soulharvester Galtmaa
	195928, -- Soulharvester Duuren
	195929, -- Soulharvester Tumen
	195930, -- Soulharvester Mandakh
	199717, -- Nokhud Defender
	193373, -- Nokhud Thunderfist
	193462  -- Batak
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.nokhud_plainstomper = "Nokhud Plainstomper"
	L.nokhud_hornsounder = "Nokhud Hornsounder"
	L.nokhud_beastmaster = "Nokhud Beastmaster"
	L.primal_stormshield = "Primal Stormshield"
	L.primalist_stormspeaker = "Primalist Stormspeaker"
	L.stormsurge_totem = "Stormsurge Totem"
	L.primalist_thunderbeast = "Primalist Thunderbeast"
	L.desecrated_ohuna = "Desecrated Ohuna"
	L.ukhel_deathspeaker = "Ukhel Deathspeaker"
	L.risen_mystic = "Risen Mystic"
	L.ukhel_beastcaller = "Ukhel Beastcaller"
	L.soulharvester_galtmaa = "Soulharvester Galtmaa"
	L.nokhud_defender = "Nokhud Defender"
	L.nokhud_thunderfist = "Nokhud Thunderfist"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Nokhud Plainstomper
		384365, -- Disruptive Shout
		384336, -- War Stomp
		-- Nokhud Hornsounder
		383823, -- Rally the Clan
		-- Nokhud Beastmaster
		334610, -- Hunt Prey
		-- Primal Stormshield
		{386223, "DISPEL"}, -- Stormshield
		-- Primalist Stormspeaker
		386024, -- Tempest
		386015, -- Summon Squall
		-- Stormsurge Totem
		386694, -- Stormsurge
		-- Primalist Thunderbeast
		{387127, "SAY"}, -- Chain Lightning
		387125, -- Thunderstrike
		386028, -- Thunder Clap
		-- Desecrated Ohuna
		387629, -- Rotting Wind
		-- Ukhel Deathspeaker
		387614, -- Chant of the Dead
		-- Risen Mystic
		387596, -- Swift Wind
		-- Ukhel Beastcaller
		387440, -- Desecrating Roar
		-- Soulharvester Galtmaa
		395035, -- Shatter Soul
		387411, -- Death Bolt Volley
		-- Nokhud Defender
		373395, -- Bloodcurdling Shout
		-- Nokhud Thunderfist
		397394, -- Deadly Thunder
	}, {
		[384365] = L.nokhud_plainstomper,
		[383823] = L.nokhud_hornsounder,
		[334610] = L.nokhud_beastmaster,
		[386223] = L.primal_stormshield,
		[386024] = L.primalist_stormspeaker,
		[386694] = L.stormsurge_totem,
		[387127] = L.primalist_thunderbeast,
		[387629] = L.desecrated_ohuna,
		[387614] = L.ukhel_deathspeaker,
		[387596] = L.risen_mystic,
		[387440] = L.ukhel_beastcaller,
		[395035] = L.soulharvester_galtmaa,
		[373395] = L.nokhud_defender,
		[397394] = L.nokhud_thunderfist,
	}, {
		[334610] = CL.fixate,
	}
end

function mod:OnBossEnable()
	-- Nokhud Plainstomper
	self:Log("SPELL_CAST_START", "DisruptiveShout", 384365)
	self:Log("SPELL_CAST_START", "WarStomp", 384336)

	-- Nokhud Hornsounder
	self:Log("SPELL_CAST_START", "RallyTheClan", 383823)

	-- Nokhud Beastmaster
	self:Log("SPELL_AURA_APPLIED", "HuntPreyApplied", 334610)

	-- Primal Stormshield
	self:Log("SPELL_AURA_APPLIED", "StormshieldApplied", 386223)

	-- Primalist Stormspeaker
	self:Log("SPELL_CAST_START", "Tempest", 386024)
	self:Log("SPELL_CAST_START", "SummonSquall", 386015)

	-- Stormsurge Totem
	self:Log("SPELL_CAST_START", "Stormsurge", 386694)

	-- Primalist Thunderbeast
	self:Log("SPELL_CAST_START", "ChainLightning", 387127)
	self:Log("SPELL_CAST_START", "Thunderstrike", 387125)
	self:Log("SPELL_CAST_START", "ThunderClap", 386028)

	-- Desecrated Ohuna
	self:Log("SPELL_CAST_START", "RottingWind", 387629)

	-- Ukhel Deathspeaker
	self:Log("SPELL_CAST_START", "ChantOfTheDead", 387614)

	-- Risen Mystic
	self:Log("SPELL_CAST_START", "SwiftWind", 387596)

	-- Ukhel Beastcaller
	self:Log("SPELL_CAST_START", "DesecratingRoar", 387440)

	-- Soulharvester Galtmaa
	self:Log("SPELL_AURA_APPLIED", "ShatterSoulApplied", 395035)
	self:Log("SPELL_CAST_START", "DeathBoltVolley", 387411)

	-- Nokhud Defender
	self:Log("SPELL_CAST_START", "BloodcurdlingShout", 373395)

	-- Nokhud Thunderfist
	self:Log("SPELL_CAST_START", "DeadlyThunder", 397394)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Nokhud Plainstomper

function mod:DisruptiveShout(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	if self:Interrupter() then
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:WarStomp(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Nokhud Hornsounder

function mod:RallyTheClan(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Nokhud Beastmaster

function mod:HuntPreyApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId, nil, CL.fixate)
		self:PlaySound(args.spellId, "alert")
	end
end

-- Primal Stormshield

function mod:StormshieldApplied(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Player(args.destFlags) then
		self:Message(args.spellId, "yellow", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

-- Primalist Stormspeaker

function mod:Tempest(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

function mod:SummonSquall(args)
	-- this is also cast when you first go near these mobs, so check for combat status before alerting
	local unit = self:GetUnitIdByGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) then
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

-- Stormsurge Totem

function mod:Stormsurge(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Primalist Thunderbeast

do
	local function printTarget(self, name, guid)
		self:TargetMessage(387127, "red", name)
		self:PlaySound(387127, "alert", nil, name)
		if self:Me(guid) then
			self:Say(387127)
		end
	end

	function mod:ChainLightning(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
	end
end

function mod:Thunderstrike(args)
	local _, interruptReady = self:Interrupter()
	if interruptReady then
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:ThunderClap(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Desecrated Ohuna

do
	local prev = 0
	function mod:RottingWind(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Ukhel Deathspeaker

function mod:ChantOfTheDead(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Risen Mystic

function mod:SwiftWind(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Ukhel Beastcaller

function mod:DesecratingRoar(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Soulharvester Galtmaa

function mod:ShatterSoulApplied(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "blue", args.destName)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:DeathBoltVolley(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

-- Nokhud Defender

function mod:BloodcurdlingShout(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	if self:Interrupter() then
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alert")
	end
end

-- Nokhud Thunderfist

function mod:DeadlyThunder(args)
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	if self:Interrupter() then
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alert")
	end
end
