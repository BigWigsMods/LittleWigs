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
	192789, -- Nokhud Longbow
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
	193457, -- Balara
	193462  -- Batak
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.teera_and_maruuk_warmup_trigger = "Why has our rest been disturbed?"

	L.nokhud_plainstomper = "Nokhud Plainstomper"
	L.nokhud_hornsounder = "Nokhud Hornsounder"
	L.nokhud_beastmaster = "Nokhud Beastmaster"
	L.nokhud_longbow = "Nokhud Longbow"
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
	L.balara = "Balara"
	L.batak = "Batak"
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
		-- Nokhud Longbow
		384476, -- Rain of Arrows
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
		436841, -- Rotting Wind
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
		-- Balara
		382277, -- Vehement Charge
		372147, -- Ravaging Spear
		-- Batak
		382233, -- Broad Stomp
	}, {
		[384365] = L.nokhud_plainstomper,
		[383823] = L.nokhud_hornsounder,
		[334610] = L.nokhud_beastmaster,
		[384476] = L.nokhud_longbow,
		[386223] = L.primal_stormshield,
		[386024] = L.primalist_stormspeaker,
		[386694] = L.stormsurge_totem,
		[387127] = L.primalist_thunderbeast,
		[436841] = L.desecrated_ohuna,
		[387614] = L.ukhel_deathspeaker,
		[387596] = L.risen_mystic,
		[387440] = L.ukhel_beastcaller,
		[395035] = L.soulharvester_galtmaa,
		[373395] = L.nokhud_defender,
		[397394] = L.nokhud_thunderfist,
		[382277] = L.balara,
		[382233] = L.batak,
	}, {
		[334610] = CL.fixate,
	}
end

function mod:OnBossEnable()
	-- General
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	-- Nokhud Plainstomper
	self:Log("SPELL_CAST_START", "DisruptiveShout", 384365)
	self:Log("SPELL_CAST_START", "WarStomp", 384336)

	-- Nokhud Hornsounder
	self:Log("SPELL_CAST_START", "RallyTheClan", 383823)

	-- Nokhud Beastmaster
	self:Log("SPELL_AURA_APPLIED", "HuntPreyApplied", 334610)

	-- Nokhud Longbow
	self:Log("SPELL_CAST_START", "RainOfArrows", 384476)

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
	self:Log("SPELL_CAST_START", "RottingWind", 436841)

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

	-- Balara
	self:Log("SPELL_CAST_START", "VehementCharge", 382277)
	self:Log("SPELL_CAST_START", "RavagingSpear", 372147)

	-- Batak
	self:Log("SPELL_CAST_START", "BroadStomp", 382233)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- General

function mod:CHAT_MSG_MONSTER_YELL(event, msg)
	if msg == L.teera_and_maruuk_warmup_trigger then
		-- Teera and Maruuk warmup
		local teeraAndMaruukModule = BigWigs:GetBossModule("Teera and Maruuk", true)
		if teeraAndMaruukModule then
			teeraAndMaruukModule:Enable()
			teeraAndMaruukModule:Warmup()
			self:UnregisterEvent(event)
		end
	end
end

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
	if self:Me(args.destGUID) and not self:Tank() then
		self:PersonalMessage(args.spellId, nil, CL.fixate)
		self:PlaySound(args.spellId, "warning")
	end
end

-- Nokhud Longbow

function mod:RainOfArrows(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
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
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

function mod:SummonSquall(args)
	-- this is also cast when you first go near these mobs, so check for combat status before alerting
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
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
			self:Say(387127, nil, nil, "Chain Lightning")
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
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
			return
		end
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
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
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Ukhel Beastcaller

function mod:DesecratingRoar(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

-- Soulharvester Galtmaa

function mod:ShatterSoulApplied(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "blue", args.destName)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:DeathBoltVolley(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
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
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	if self:Interrupter() then
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alert")
	end
end

-- Balara

function mod:VehementCharge(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

-- Batak

function mod:RavagingSpear(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:BroadStomp(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end
