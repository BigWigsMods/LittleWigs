--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Court of Stars Trash", 1087)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	104246, -- Duskwatch Guard
	111563, -- Duskwatch Guard
	104251, -- Duskwatch Sentry
	104270, -- Guardian Construct
	104278, -- Felbound Enforcer
	104277, -- Legion Hound
	107435, -- Gerenth the Vile & Suspicious Noble
	104273, -- Jazshariu
	104275, -- Imacu'tya
	104274, -- Baalgar the Watchful
	105715, -- Watchful Inquisitor
	104295, -- Blazing Imp
	105705, -- Bound Energy
	104300, -- Shadow Mistress
	105704, -- Arcane Manifestation
	105703, -- Mana Wyrm
	104247, -- Duskwatch Arcanist
	105699, -- Mana Saber
	112668, -- Infernal Imp
	108796, -- Arcanist Malrodi (Court of Stars: The Deceitful Student World Quest)
	108740  -- Velimar (Court of Stars: Bring Me the Eyes World Quest)
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.Guard = "Duskwatch Guard"
	L.Sentry = "Duskwatch Sentry"
	L.Construct = "Guardian Construct"
	L.Enforcer = "Felbound Enforcer"
	L.Hound = "Legion Hound"
	L.Gerenth = "Gerenth the Vile"
	L.Jazshariu = "Jazshariu"
	L.Imacutya = "Imacutya"
	L.Baalgar = "Baalgar the Watchful"
	L.Inquisitor = "Watchful Inquisitor"
	L.BlazingImp = "Blazing Imp"
	L.Energy = "Bound Energy"
	L.Mistress = "Shadow Mistress"
	L.Manifestation = "Arcane Manifestation"
	L.Wyrm = "Mana Wyrm"
	L.Arcanist = "Duskwatch Arcanist"
	L.Saber = "Mana Saber"
	L.InfernalImp = "Infernal Imp"
	L.Malrodi = "Arcanist Malrodi"
	L.Velimar = "Velimar"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		209027, -- Quelling Strike (Duskwatch Guard)
		209033, -- Fortification (Duskwatch Guard)
		{209036, "SAY", "FLASH"}, -- Throw Torch (Duskwatch Sentry)
		225100, -- Charging Station (Guardian Construct)
		209495, -- Charged Smash (Guardian Construct)
		209512, -- Disrupting Energy (Guardian Construct)
		{209413, "SAY", "FLASH"}, -- Suppress (Guardian Construct)
		211464, -- Fel Detonation (Felbound Enforcer)
		211391, -- Felblaze Puddle (Legion Hound)
		214692, -- Shadow Bolt Volley (Gerenth the Vile)
		214688, -- Carrion Swarm (Gerenth the Vile)
		{214690, "SAY", "FLASH"}, -- Cripple (Gerenth the Vile)
		207979, -- Shockwave (Jazshariu)
		209378, -- Whirling Blades (Imacu'tya)
		{207980, "SAY", "FLASH"}, -- Disintegration Beam (Baalgar the Watchful)
		211299, -- Searing Glare (Watchful Inquisitor)
		212784, -- Eye Storm (Watchful Inquisitor)
		211401, -- Drifting Embers (Blazing Imp)
		212031, -- Charged Blast (Bound Energy)
		{211470, "SAY", "FLASH"}, -- Bewitch (Shadow Mistress)
		{211473, "SAY", "FLASH"}, -- Shadow Slash (Shadow Mistress)
		209485, -- Drain Magic (Arcane Manifestation)
		209477, -- Wild Detonation (Mana Wyrm)
		209410, -- Nightfall Orb (Duskwatch Arcanist)
		209404, -- Seal Magic (Duskwatch Arcanist)
		{209516, "SAY", "FLASH"}, -- Mana Fang (Mana Saber)
		224377, -- Drifting Embers (Infernal Imp)
		216110, -- Uncontrolled Blast (Arcanist Malrodi)
		216096, -- Wild Magic (Arcanist Malrodi)
		216000, -- Mighty Stomp (Velimar)
		216006, -- Shadowflame Breath (Velimar)
	}, {
		[209027] = L.Guard,
		[209036] = L.Sentry,
		[225100] = L.Construct,
		[211464] = L.Enforcer,
		[211391] = L.Hound,
		[214692] = L.Gerenth,
		[207979] = L.Jazshariu,
		[209378] = L.Imacutya,
		[207980] = L.Baalgar,
		[211299] = L.Inquisitor,
		[211401] = L.BlazingImp,
		[212031] = L.Energy,
		[211470] = L.Mistress,
		[209485] = L.Manifestation,
		[209477] = L.Wyrm,
		[209410] = L.Arcanist,
		[209516] = L.Saber,
		[224377] = L.InfernalImp,
		[216110] = L.Malrodi,
		[216000] = L.Velimar,
}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	-- Charging Station, Shadow Bolt Volley, Carrion Swarm, Shockwave, Whirling Blades, Drain Magic, Wild Detonation, Nightfall Orb, Seal Magic, Fortification, Uncontrolled Blast, Wild Magic, Mighty Stomp, Shadowflame Breath
	self:Log("SPELL_CAST_START", "AlertCasts", 225100, 214692, 214688, 207979, 209378, 209485, 209477, 209410, 209404, 209033, 216110, 216096, 216000, 216006)
	-- Quelling Strike, Fel Detonation, Searing Glare, Eye Storm, Drifting Embers, Charged Blast, Suppress, Charged Smash, Drifting Embers
	self:Log("SPELL_CAST_START", "AlarmCasts", 209027, 211464, 211299, 212784, 211401, 212031, 209413, 209495, 224377)
	-- Felblaze Puddle, Disrupting Energy
	self:Log("SPELL_AURA_APPLIED", "PeriodicDamage", 211391, 209512)
	self:Log("SPELL_PERIODIC_DAMAGE", "PeriodicDamage", 211391, 209512)
	self:Log("SPELL_PERIODIC_MISSED", "PeriodicDamage", 211391, 209512)
	-- Shadow Slash, Bewitch, Suppress, Mana Fang, Cripple, Throw Torch, Shadowflame Breath, Carrion Swarm
	self:Log("SPELL_AURA_APPLIED", "DispellableDebuffs", 211473, 211470, 209413, 209516, 214690, 209036, 216006, 214688)
	-- Disintegration Beam
	self:Log("SPELL_AURA_APPLIED", "DisintegrationBeam", 207980)
	-- Eye Storm
	self:Log("SPELL_CAST_SUCCESS", "EyeStorm", 212784)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

local prevTable = {}
local function throttleMessages(key)
	local t = GetTime()
	if t-(prevTable[key] or 0) > 1.5 then
		prevTable[key] = t
		return false
	else
		return true
	end
end

function mod:AlertCasts(args)
	if throttleMessages(args.spellId) then return end
	self:Message(args.spellId, "Attention", "Alert", CL.casting:format(args.spellName))
end

function mod:AlarmCasts(args)
	if throttleMessages(args.spellId) then return end
	self:Message(args.spellId, "Important", "Alarm", CL.casting:format(args.spellName))
end

do
	local prev = 0
	function mod:PeriodicDamage(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "Personal", "Warning", CL.underyou:format(args.spellName))
		end
	end
end

function mod:DispellableDebuffs(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", not throttleMessages(args.spellId) and "Alert", nil, nil, self:Dispeller("magic"))
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
		self:Say(args.spellId)
	end
end

function mod:DisintegrationBeam(args)
	self:Message(args.spellId, "Attention", "Long")
	self:Bar(args.spellId, 5, CL.cast:format(args.spellName, args.destName))
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
		self:Say(args.spellId)
	end
end

function mod:EyeStorm(args)
	self:Message(args.spellId, "Attention", "Long")
	self:Bar(args.spellId, 8, CL.cast:format(args.spellName))
end
