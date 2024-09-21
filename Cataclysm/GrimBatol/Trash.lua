--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grim Batol Trash", 670)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	224219, -- Twilight Earthcaller
	224152, -- Twilight Brute
	224609, -- Twilight Destroyer
	40167, -- Twilight Beguiler
	40166, -- Molten Giant
	224271, -- Twilight Warlock
	224240, -- Twilight Flamerender
	224249, -- Twilight Lavabender
	39392 -- Faceless Corruptor
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.twilight_earthcaller = "Twilight Earthcaller"
	L.twilight_brute = "Twilight Brute"
	L.twilight_destroyer = "Twilight Destroyer"
	L.twilight_beguiler = "Twilight Beguiler"
	L.molten_giant = "Molten Giant"
	L.twilight_warlock = "Twilight Warlock"
	L.twilight_flamerender = "Twilight Flamerender"
	L.twilight_lavabender = "Twilight Lavabender"
	L.faceless_corruptor = "Faceless Corruptor"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Twilight Earthcaller
		{451871, "NAMEPLATE"}, -- Mass Tremor
		-- Twilight Brute
		{456696, "NAMEPLATE"}, -- Obsidian Stomp
		-- Twilight Destroyer
		{451613, "SAY", "NAMEPLATE"}, -- Twilight Flame
		451614, -- Twilight Ember
		{451939, "NAMEPLATE"}, -- Umbral Wind
		-- Twilight Beguiler
		{76711, "NAMEPLATE"}, -- Sear Mind
		-- Molten Giant
		{451965, "NAMEPLATE"}, -- Molten Wake
		{451971, "TANK_HEALER", "NAMEPLATE"}, -- Lava Fist
		-- Twilight Warlock
		{451224, "DISPEL", "NAMEPLATE"}, -- Enveloping Shadowflame
		-- Twilight Flamerender
		{462216, "NAMEPLATE"}, -- Blazing Shadowflame
		{451241, "TANK_HEALER", "NAMEPLATE"}, -- Shadowflame Slash
		-- Twilight Lavabender
		{456711, "NAMEPLATE"}, -- Shadowlava Blast
		{456713, "NAMEPLATE"}, -- Dark Eruption
		451387, -- Ascension
		-- Faceless Corruptor
		{451391, "NAMEPLATE"}, -- Mind Piercer
		{451395, "NAMEPLATE"}, -- Corrupt
	}, {
		[451871] = L.twilight_earthcaller,
		[456696] = L.twilight_brute,
		[451613] = L.twilight_destroyer,
		[76711] = L.twilight_beguiler,
		[451965] = L.molten_giant,
		[451224] = L.twilight_warlock,
		[462216] = L.twilight_flamerender,
		[456711] = L.twilight_lavabender,
		[451391] = L.faceless_corruptor,
	}, {
		[451391] = CL.mind_control, -- Mind Piercer (Mind Control)
	}
end

function mod:OnBossEnable()
	if self:Retail() then
		-- Twilight Earthcaller
		self:Log("SPELL_CAST_START", "MassTremor", 451871)
		self:Log("SPELL_INTERRUPT", "MassTremorInterrupt", 451871)
		self:Log("SPELL_CAST_SUCCESS", "MassTremorSuccess", 451871)
		self:Death("TwilightEarthcallerDeath", 224219)

		-- Twilight Brute
		self:Log("SPELL_CAST_SUCCESS", "ObsidianStomp", 456696)
		self:Death("TwilightBruteDeath", 224152)

		-- Twilight Destroyer
		self:Log("SPELL_CAST_SUCCESS", "TwilightFlame", 451613)
		self:Log("SPELL_AURA_APPLIED", "TwilightFlameApplied", 451613)
		self:Log("SPELL_PERIODIC_DAMAGE", "TwilightEmberDamage", 451614)
		self:Log("SPELL_PERIODIC_MISSED", "TwilightEmberDamage", 451614)
		self:Log("SPELL_CAST_START", "UmbralWind", 451939)
		self:Death("TwilightDestroyerDeath", 224609)
	end

	-- Twilight Beguiler
	self:Log("SPELL_CAST_START", "SearMind", 76711) -- Chained Mind on classic

	if self:Retail() then
		self:Log("SPELL_INTERRUPT", "SearMindInterrupt", 76711)
		self:Log("SPELL_CAST_SUCCESS", "SearMindSuccess", 76711)
		self:Death("TwilightBeguilerDeath", 40167)

		-- Molten Giant
		self:Log("SPELL_CAST_START", "MoltenWake", 451965)
		self:Log("SPELL_CAST_START", "LavaFist", 451971)
		self:Death("MoltenGiantDeath", 40166)

		-- Twilight Warlock
		self:Log("SPELL_CAST_SUCCESS", "EnvelopingShadowflame", 451224)
		self:Log("SPELL_AURA_APPLIED", "EnvelopingShadowflameApplied", 451224)
		self:Death("TwilightWarlockDeath", 224271)

		-- Twilight Flamerender
		self:Log("SPELL_CAST_START", "BlazingShadowflame", 462216)
		self:Log("SPELL_CAST_SUCCESS", "BlazingShadowflameSuccess", 462216)
		self:Log("SPELL_CAST_START", "ShadowflameSlash", 451241)
		self:Log("SPELL_CAST_SUCCESS", "ShadowflameSlashSuccess", 451241)
		self:Death("TwilightFlamerenderDeath", 224240)

		-- Twilight Lavabender
		self:Log("SPELL_CAST_START", "ShadowlavaBlast", 456711)
		self:Log("SPELL_CAST_START", "DarkEruption", 456713)
		self:Log("SPELL_CAST_START", "Ascension", 451387)
		self:Death("TwilightLavabenderDeath", 224249)

		-- Faceless Corruptor
		self:Log("SPELL_CAST_START", "MindPiercer", 451391)
		self:Log("SPELL_AURA_APPLIED", "MindPiercerApplied", 451394)
		self:Log("SPELL_CAST_SUCCESS", "Corrupt", 451395)
		self:Log("SPELL_AURA_APPLIED", "CorruptApplied", 451395)
		self:Death("FacelessCorruptorDeath", 39392)
	end
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			-- Twilight Beguiler
			76711, -- Chained Mind
		}, {
			[76711] = L.twilight_beguiler,
		}
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Twilight Earthcaller

function mod:MassTremor(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
end

function mod:MassTremorInterrupt(args)
	self:Nameplate(451871, 22.5, args.destGUID)
end

function mod:MassTremorSuccess(args)
	self:Nameplate(args.spellId, 22.5, args.sourceGUID)
end

function mod:TwilightEarthcallerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Twilight Brute

do
	local prev = 0
	function mod:ObsidianStomp(args)
		-- there are some RP fighting mobs below who cast this, filter them
		local unit = self:UnitTokenFromGUID(args.sourceGUID)
		if unit and UnitCanAttack("player", unit) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:Message(args.spellId, "orange")
				self:PlaySound(args.spellId, "alarm")
			end
			self:Nameplate(args.spellId, 17.0, args.sourceGUID)
		end
	end
end

function mod:TwilightBruteDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Twilight Destroyer

function mod:TwilightFlame(args)
	self:Nameplate(args.spellId, 20.7, args.sourceGUID)
end

function mod:TwilightFlameApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Twilight Flame")
	end
end

do
	local prev = 0
	function mod:TwilightEmberDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:UmbralWind(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:Nameplate(args.spellId, 23.1, args.sourceGUID)
end

function mod:TwilightDestroyerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Twilight Beguiler

function mod:SearMind(args) -- Chained Mind on Classic
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	if self:Retail() then
		self:Nameplate(args.spellId, 0, args.sourceGUID)
	end
end

function mod:SearMindInterrupt(args)
	self:Nameplate(76711, 18.3, args.destGUID)
end

function mod:SearMindSuccess(args)
	self:Nameplate(args.spellId, 18.3, args.sourceGUID)
end

function mod:TwilightBeguilerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Molten Giant

function mod:MoltenWake(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:Nameplate(args.spellId, 18.2, args.sourceGUID)
end

function mod:LavaFist(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:Nameplate(args.spellId, 15.0, args.sourceGUID)
end

function mod:MoltenGiantDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Twilight Warlock

function mod:EnvelopingShadowflame(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitCanAttack("player", unit) then
		self:Nameplate(args.spellId, 19.8, args.sourceGUID)
	end
end

do
	local playerList = {}
	local prev = 0
	function mod:EnvelopingShadowflameApplied(args)
		if self:Me(args.destGUID) or self:Healer() or self:Dispeller("curse", nil, args.spellId) then
			local t = args.time
			if t - prev > .5 then -- throttle alerts to .5s intervals
				-- can't use SUCCESS to reset playerList because this spell is spammed in RP fighting
				prev = t
				playerList = {}
			end
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(args.spellId, "orange", playerList, 2, nil, nil, .5) -- goes on 2 players at a time
			self:PlaySound(args.spellId, "alert", nil, playerList)
		end
	end
end

function mod:TwilightWarlockDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Twilight Flamerender

do
	local prev = 0
	function mod:BlazingShadowflame(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:BlazingShadowflameSuccess(args)
	self:Nameplate(args.spellId, 16.4, args.sourceGUID)
end

do
	local prev = 0
	function mod:ShadowflameSlash(args)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:ShadowflameSlashSuccess(args)
	self:Nameplate(args.spellId, 16.7, args.sourceGUID)
end

function mod:TwilightFlamerenderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Twilight Lavabender

function mod:ShadowlavaBlast(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Nameplate(args.spellId, 17.8, args.sourceGUID)
end

function mod:DarkEruption(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Nameplate(args.spellId, 20.3, args.sourceGUID)
end

function mod:Ascension(args)
	self:Message(args.spellId, "cyan", CL.percent:format(50, args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:TwilightLavabenderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Faceless Corruptor

do
	local prev = 0
	function mod:MindPiercer(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:MindPiercerApplied(args)
		self:TargetMessage(451391, "cyan", args.destName, CL.mind_control)
		local t = args.time
		if t - prev > 1.5 then
			-- throttle sound in case more than one player is hit
			prev = t
			self:PlaySound(451391, "info", nil, args.destName)
		end
	end
end

function mod:Corrupt(args)
	self:Nameplate(args.spellId, 17.0, args.sourceGUID)
end

function mod:CorruptApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:FacelessCorruptorDeath(args)
	self:ClearNameplate(args.destGUID)
end
