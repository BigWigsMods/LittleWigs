--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Eco-Dome Al'dani Trash", 2830)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	244927, -- Terrified Broker
	247244, -- Arcane Siphon
	234912, -- Ravaging Scavenger
	242209, -- Overgorged Mite
	234870, -- Invading Mite
	234883, -- Voracious Gorger
	236995, -- Ravenous Destroyer
	242631, -- Overcharged Sentinel
	234962, -- Wastelander Farstalker
	234960, -- Tamed Ruinstalker
	234957, -- Wastelander Ritualist
	234955, -- Wastelander Pactspeaker
	240952, -- Evoked Spirit
	235151, -- K'aresh Elemental
	245092, -- Burrowing Creeper
	234918 -- Wastes Creeper
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.terrified_broker = "Terrified Broker"
	L.arcane_siphon = "Arcane Siphon"
	L.overgorged_mite = "Overgorged Mite"
	L.voracious_gorger = "Voracious Gorger"
	L.ravenous_destroyer = "Ravenous Destroyer"
	L.overcharged_sentinel = "Overcharged Sentinel"
	L.wastelander_farstalker = "Wastelander Farstalker"
	L.tamed_ruinstalker = "Tamed Ruinstalker"
	L.wastelander_ritualist = "Wastelander Ritualist"
	L.wastelander_pactspeaker = "Wastelander Pactspeaker"
	L.evoked_spirit = "Evoked Spirit"
	L.karesh_elemental = "K'aresh Elemental"
	L.burrowing_creeper = "Burrowing Creeper"
	L.wastes_creeper = "Wastes Creeper"

	L.taahbat_and_awazj_warmup_trigger = "I have no time for this. Taah'bat! Be certain they follow no further."
end

--------------------------------------------------------------------------------
-- Initialization
--

local evokedSpiritMarker = mod:AddMarkerOption(true, "npc", 7, "evoked_spirit", 7)
function mod:GetOptions()
	return {
		-- Terrified Broker
		{1236981, "ME_ONLY"}, -- Disruption Grenade
		-- Arcane Siphon
		1239229, -- K'areshi Surge
		-- Overgorged Mite
		{1229474, "NAMEPLATE", "OFF"}, -- Gorge
		-- Voracious Gorger
		{1221152, "NAMEPLATE"}, -- Gorging Smash
		-- Ravenous Destroyer
		{1221190, "NAMEPLATE"}, -- Gluttonous Miasma
		{1226111, "SAY", "SAY_COUNTDOWN", "NAMEPLATE"}, -- Volatile Ejection
		-- Overcharged Sentinel
		{1235368, "NAMEPLATE"}, -- Arcane Slash
		1231244, -- Unstable Core
		1222202, -- Arcane Burn
		-- Wastelander Farstalker
		{1229510, "NAMEPLATE"}, -- Arcing Zap
		{1221679, "NAMEPLATE", "OFF"}, -- Farstalker's Leap
		-- Tamed Ruinstalker
		{1222356, "NAMEPLATE"}, -- Warp
		-- Wastelander Ritualist
		{1221483, "NAMEPLATE"}, -- Arcing Energy
		-- Wastelander Pactspeaker
		{1221532, "NAMEPLATE"}, -- Erratic Ritual
		{1248699, "NAMEPLATE"}, -- Consume Spirit
		evokedSpiritMarker,
		1226492, -- Ritual Disrupted
		-- K'aresh Elemental
		{1223000, "DISPEL", "NAMEPLATE"}, -- Embrace of K'aresh
		-- Burrowing Creeper
		{1237195, "NAMEPLATE"}, -- Burrow Charge
		{1237220, "NAMEPLATE"}, -- Singing Sandstorm
		{1215850, "NAMEPLATE"}, -- Earthcrusher
		-- Wastes Creeper
		{1223007, "NAMEPLATE"}, -- Burrowing Eruption
		{1222341, "TANK_HEALER", "NAMEPLATE", "OFF"}, -- Gloom Bite
	}, {
		{
			tabName = self:BossName(2675), -- Azhiccar
			{1236981, 1239229, 1229474, 1221152, 1221190, 1226111},
		},
		{
			tabName = self:BossName(2676), -- Taah'bat and A'wazj
			{1235368, 1231244, 1222202, 1229510, 1221679, 1222356, 1221483},
		},
		{
			tabName = self:BossName(2677), -- Soul-Scribe
			{1221532, 1248699, evokedSpiritMarker, 1226492, 1223000, 1237195, 1237220, 1215850, 1223007, 1222341},
		},
		[1236981] = L.terrified_broker,
		[1239229] = L.arcane_siphon,
		[1229474] = L.overgorged_mite,
		[1221152] = L.voracious_gorger,
		[1221190] = L.ravenous_destroyer,
		[1235368] = L.overcharged_sentinel,
		[1229510] = L.wastelander_farstalker,
		[1222356] = L.tamed_ruinstalker,
		[1221483] = L.wastelander_ritualist,
		[1221532] = L.wastelander_pactspeaker,
		[1223000] = L.karesh_elemental,
		[1237195] = L.burrowing_creeper,
		[1223007] = L.wastes_creeper,
	}
end

function mod:OnRegister()
	-- delayed for custom locale
	evokedSpiritMarker = mod:AddMarkerOption(true, "npc", 7, "evoked_spirit", 7)
end

function mod:OnBossEnable()
	-- Warmups
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	-- Terrified Broker
	self:Log("SPELL_AURA_APPLIED", "DisruptionGrenadeApplied", 1236981)

	-- Arcane Siphon
	self:Log("SPELL_AURA_APPLIED", "KareshiSurgeApplied", 1239229)

	-- Overgorged Mite
	self:RegisterEngageMob("OvergorgedMiteEngaged", 242209)
	self:Log("SPELL_CAST_START", "Gorge", 1229474)
	self:Log("SPELL_INTERRUPT", "GorgeInterrupt", 1229474)
	self:Log("SPELL_CAST_SUCCESS", "GorgeSuccess", 1229474)
	self:Death("OvergorgedMiteDeath", 242209)

	-- Voracious Gorger
	self:RegisterEngageMob("VoraciousGorgerEngaged", 234883)
	self:Log("SPELL_CAST_SUCCESS", "GorgingSmash", 1221152)
	self:Death("VoraciousGorgerDeath", 234883)

	-- Ravenous Destroyer
	self:RegisterEngageMob("RavenousDestroyerEngaged", 236995)
	self:Log("SPELL_CAST_SUCCESS", "GluttonousMiasma", 1221190)
	self:Log("SPELL_AURA_APPLIED", "GluttonousMiasmaApplied", 1221190)
	self:Log("SPELL_CAST_START", "VolatileEjection", 1226111)
	self:Death("RavenousDestroyerDeath", 236995)

	-- Overcharged Sentinel
	self:RegisterEngageMob("OverchargedSentinelEngaged", 242631)
	self:Log("SPELL_CAST_START", "ArcaneSlash", 1235368)
	self:Log("SPELL_CAST_SUCCESS", "ArcaneSlashSuccess", 1235368)
	self:Log("SPELL_AURA_APPLIED", "ShatteredCoreApplied", 1231328) -- for Unstable Core
	self:Log("SPELL_PERIODIC_DAMAGE", "ArcaneBurnDamage", 1222202)
	self:Log("SPELL_PERIODIC_MISSED", "ArcaneBurnDamage", 1222202)
	self:Death("OverchargedSentinelDeath", 242631)

	-- Wastelander Farstalker
	self:RegisterEngageMob("WastelanderFarstalkerEngaged", 234962)
	self:Log("SPELL_CAST_START", "ArcingZap", 1229510)
	self:Log("SPELL_INTERRUPT", "ArcingZapInterrupt", 1229510)
	self:Log("SPELL_CAST_SUCCESS", "ArcingZapSuccess", 1229510)
	self:Log("SPELL_CAST_SUCCESS", "FarstalkersLeap", 1221679)
	self:Death("WastelanderFarstalkerDeath", 234962)

	-- Tamed Ruinstalker
	self:RegisterEngageMob("TamedRuinstalkerEngaged", 234960)
	self:Log("SPELL_CAST_START", "Warp", 1222356)
	self:Death("TamedRuinstalkerDeath", 234960)

	-- Wastelander Ritualist
	self:RegisterEngageMob("WastelanderRitualistEngaged", 234957)
	self:Log("SPELL_CAST_SUCCESS", "ArcingEnergy", 1221483)
	self:Log("SPELL_AURA_APPLIED", "ArcingEnergyApplied", 1221483)
	self:Death("WastelanderRitualistDeath", 234957)

	-- Wastelander Pactspeaker
	self:RegisterEngageMob("WastelanderPactspeakerEngaged", 234955)
	self:Log("SPELL_CAST_START", "ErraticRitual", 1221532)
	self:Log("SPELL_CAST_START", "ConsumeSpirit", 1248699)
	self:Log("SPELL_SUMMON", "EvokeSpirit", 1248700)
	self:Log("SPELL_AURA_APPLIED", "RitualDisruptedApplied", 1226492)
	self:Death("WastelanderPactspeakerDeath", 234955)

	-- K'aresh Elemental
	self:RegisterEngageMob("KareshElementalEngaged", 235151)
	self:Log("SPELL_CAST_SUCCESS", "EmbraceOfKaresh", 1223000)
	self:Log("SPELL_AURA_APPLIED", "EmbraceOfKareshApplied", 1223000)
	self:Death("KareshElementalDeath", 235151)

	-- Burrowing Creeper
	self:RegisterEngageMob("BurrowingCreeperEngaged", 245092)
	self:Log("SPELL_CAST_START", "BurrowCharge", 1237195)
	self:Log("SPELL_CAST_START", "SingingSandstorm", 1237220)
	self:Log("SPELL_CAST_START", "Earthcrusher", 1215850)
	self:Death("BurrowingCreeperDeath", 245092)

	-- Wastes Creeper
	self:RegisterEngageMob("WastesCreeperEngaged", 234918)
	self:Log("SPELL_CAST_START", "BurrowingEruption", 1223007)
	self:Log("SPELL_CAST_START", "GloomBite", 1222341)
	self:Log("SPELL_CAST_SUCCESS", "GloomBiteSuccess", 1222341)
	self:Death("WastesCreeperDeath", 234918)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmups

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg == L.taahbat_and_awazj_warmup_trigger then
		local taahbatAndAwazjModule = BigWigs:GetBossModule("Taah'bat and A'wazj", true)
		if taahbatAndAwazjModule then
			taahbatAndAwazjModule:Enable()
			taahbatAndAwazjModule:Warmup()
		end
	end
end

-- Terrified Broker

function mod:DisruptionGrenadeApplied(args)
	self:TargetMessage(args.spellId, "green", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

-- Arcane Siphon

function mod:KareshiSurgeApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.on_group:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

-- Overgorged Mite

function mod:OvergorgedMiteEngaged(guid)
	self:Nameplate(1229474, 3.9, guid) -- Gorge
end

do
	local prev = 0
	function mod:Gorge(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:GorgeInterrupt(args)
	self:Nameplate(1229474, 5.0, args.destGUID)
end

function mod:GorgeSuccess(args)
	self:Nameplate(args.spellId, 5.0, args.sourceGUID)
end

function mod:OvergorgedMiteDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Voracious Gorger

function mod:VoraciousGorgerEngaged(guid)
	self:Nameplate(1221152, 7.7, guid) -- Gorging Smash
end

function mod:GorgingSmash(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:VoraciousGorgerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Ravenous Destroyer

function mod:RavenousDestroyerEngaged(guid)
	self:Nameplate(1221190, 8.9, guid) -- Gluttonous Miasma
	self:Nameplate(1226111, 14.3, guid) -- Volatile Ejection
end

function mod:GluttonousMiasma(args)
	self:Nameplate(args.spellId, 19.4, args.sourceGUID)
end

function mod:GluttonousMiasmaApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

do
	local function printTarget(self, name, guid, elapsed)
		self:TargetMessage(1226111, "orange", name)
		if self:Me(guid) then
			self:Say(1226111, nil, nil, "Volatile Ejection")
			self:SayCountdown(1226111, 4 - elapsed)
		end
		self:PlaySound(1226111, "alarm", nil, name)
	end

	function mod:VolatileEjection(args)
		-- target debuff 1226110 is hidden
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		self:Nameplate(args.spellId, 19.4, args.sourceGUID)
	end
end

function mod:RavenousDestroyerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Overcharged Sentinel

function mod:OverchargedSentinelEngaged(guid)
	self:Nameplate(1235368, 4.2, guid) -- Arcane Slash
end

function mod:ArcaneSlash(args)
	-- follows the tank
	self:Message(args.spellId, "purple")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	if self:Tank() then
		self:PlaySound(args.spellId, "alert")
	else
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:ArcaneSlashSuccess(args)
	self:Nameplate(args.spellId, 12.9, args.sourceGUID)
end

function mod:ShatteredCoreApplied(args) -- Unstable Core
	-- trigger alert on Shattered Core applied, because Unstable Core will be reapplied on a wipe
	self:Message(1231244, "yellow", CL.percent:format(50, self:SpellName(1231244)))
	self:PlaySound(1231244, "long")
end

do
	local prev = 0
	function mod:ArcaneBurnDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then -- 1.5s tick rate
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:OverchargedSentinelDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Wastelander Farstalker

function mod:WastelanderFarstalkerEngaged(guid)
	self:Nameplate(1221679, 5.6, guid) -- Farstalker's Leap
	self:Nameplate(1229510, 9.9, guid) -- Arcing Zap
end

do
	local prev = 0
	function mod:ArcingZap(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:ArcingZapInterrupt(args)
	self:Nameplate(1229510, 23.3, args.destGUID)
end

function mod:ArcingZapSuccess(args)
	self:Nameplate(args.spellId, 23.3, args.sourceGUID)
end

do
	local prev = 0
	function mod:FarstalkersLeap(args)
		self:Nameplate(args.spellId, 12.2, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "cyan")
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:WastelanderFarstalkerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Tamed Ruinstalker

function mod:TamedRuinstalkerEngaged(guid)
	self:Nameplate(1222356, 4.4, guid) -- Warp
end

do
	local prev = 0
	function mod:Warp(args)
		self:Nameplate(args.spellId, 12.2, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:TamedRuinstalkerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Wastelander Ritualist

function mod:WastelanderRitualistEngaged(guid)
	self:Nameplate(1221483, 11.5, guid) -- Arcing Energy
end

function mod:ArcingEnergy(args)
	self:Nameplate(args.spellId, 10.9, args.sourceGUID)
end

function mod:ArcingEnergyApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

function mod:WastelanderRitualistDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Wastelander Pactspeaker

function mod:WastelanderPactspeakerEngaged(guid)
	self:Nameplate(1221532, 8.4, guid) -- Erratic Ritual
	self:Nameplate(1248699, 23.2, guid) -- Consume Spirit
end

function mod:ErraticRitual(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 19.8, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:ConsumeSpirit(args)
	self:Message(args.spellId, "red")
	self:Nameplate(args.spellId, 40.1, args.sourceGUID)
	self:PlaySound(args.spellId, "long")
end

do
	local spiritGUID = nil

	function mod:EvokeSpirit(args)
		-- register events to auto-mark Evoked Spirit (240952)
		if self:GetOption(evokedSpiritMarker) then
			spiritGUID = args.destGUID
			self:RegisterTargetEvents("MarkEvokedSpirit")
		end
	end

	function mod:MarkEvokedSpirit(_, unit, guid)
		if spiritGUID == guid then
			spiritGUID = nil
			self:CustomIcon(evokedSpiritMarker, unit, 7)
			self:UnregisterTargetEvents()
		end
	end
end

function mod:RitualDisruptedApplied(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "info")
end

function mod:WastelanderPactspeakerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- K'aresh Elemental

function mod:KareshElementalEngaged(guid)
	if self:Dispeller("magic", true, 1223000) then
		self:Nameplate(1223000, 7.1, guid) -- Embrace of K'aresh
	end
end

function mod:EmbraceOfKaresh(args)
	if self:Dispeller("magic", true, args.spellId) then
		self:Nameplate(args.spellId, 17.0, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:EmbraceOfKareshApplied(args)
		if self:Dispeller("magic", true, args.spellId) and not self:Friendly(args.destFlags) and args.time - prev > 2.5 then
			prev = args.time
			self:Message(args.spellId, "orange", CL.on:format(args.spellName, args.destName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:KareshElementalDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Burrowing Creeper

function mod:BurrowingCreeperEngaged(guid)
	self:Nameplate(1237195, 5.2, guid) -- Burrow Charge
	self:Nameplate(1237220, 13.7, guid) -- Singing Sandstorm
	self:Nameplate(1215850, 19.8, guid) -- Earthcrusher
end

do
	local function printTarget(self, name)
		self:TargetMessage(1237195, "yellow", name)
		self:PlaySound(1237195, "alarm", nil, name)
	end

	function mod:BurrowCharge(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		self:Nameplate(args.spellId, 19.4, args.sourceGUID)
	end
end

function mod:SingingSandstorm(args)
	self:Message(args.spellId, "red")
	self:Nameplate(args.spellId, 26.3, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:Earthcrusher(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 31.3, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:BurrowingCreeperDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Wastes Creeper

function mod:WastesCreeperEngaged(guid)
	self:Nameplate(1222341, 3.3, guid) -- Gloom Bite
	self:Nameplate(1223007, 7.8, guid) -- Burrowing Eruption
end

function mod:BurrowingEruption(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 18.3, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:GloomBite(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:GloomBiteSuccess(args)
	self:Nameplate(args.spellId, 12.1, args.sourceGUID)
end

function mod:WastesCreeperDeath(args)
	self:ClearNameplate(args.destGUID)
end
