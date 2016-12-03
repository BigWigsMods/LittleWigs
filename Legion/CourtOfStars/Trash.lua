--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Court of Stars Trash", 1087)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	104246, -- Duskwatch Guard
	111563, -- Duskwatch Guard
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
	112668 -- Infernal Imp
)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		209027, -- Quelling Strike (Duskwatch Guard)
		209033, -- Fortification (Duskwatch Guard)
		225100, -- Charging Station (Guardian Construct)
		209495, -- Charged Smash (Guardian Construct)
		209512, -- Disrupting Energy (Guardian Construct)
		209413, -- Suppress (Guardian Construct)
		211464, -- Fel Detonation (Felbound Enforcer)
		211391, -- Felblaze Puddle (Legion Hound)
		214692, -- Shadow Bolt Volley (Gerenth the Vile)
		214688, -- Carrion Swarm (Gerenth the Vile)
		207979, -- Shockwave (Jazshariu)
		209378, -- Whirling Blades (Imacu'tya)
		207981, -- Disintegration Beam (Baalgar the Watchful)
		211299, -- Searing Glare (Watchful Inquisitor)
		212784, -- Eye Storm (Watchful Inquisitor)
		211401, -- Drifting Embers (Blazing Imp)
		212031, -- Charged Blast (Bound Energy)
		211470, -- Bewitch (Shadow Mistress)
		211473, -- Shadow Slash (Shadow Mistress)
		209485, -- Drain Magic (Arcane Manifestation)
		209477, -- Wild Detonation (Mana Wyrm)
		209410, -- Nightfall Orb (Duskwatch Arcanist)
		209404, -- Seal Magic (Duskwatch Arcanist)
		209516, -- Mana Fang (Mana Saber)
		224375, -- Drifting Embers (Infernal Imp)
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	-- Charging Station, Shadow Bolt Volley, Carrion Swarm, Shockwave, Whirling Blades, Drain Magic, Wild Detonation, Nightfall Orb, Seal Magic
	self:Log("SPELL_CAST_START", "AlertCasts", 225100, 214692, 214688, 207979, 209378, 209485, 209477, 209410, 209404)
	-- Quelling Strike, Fel Detonation, Searing Glare, Eye Storm, Drifting Embers, Charged Blast, Suppress, Charged Smash, Drifting Embers
	self:Log("SPELL_CAST_START", "AlarmCasts", 209027, 211464, 211299, 212784, 211401, 212031, 209413, 209495, 224375)
	-- Felblaze Puddle, Disrupting Energy
	self:Log("SPELL_AURA_APPLIED", "PeriodicDamage", 211391, 209512)
	self:Log("SPELL_PERIODIC_DAMAGE", "PeriodicDamage", 211391, 209512)
	self:Log("SPELL_PERIODIC_MISSED", "PeriodicDamage", 211391, 209512)
	-- Shadow Slash, Bewitch, Suppress, Mana Fang, Fortification
	self:Log("SPELL_AURA_APPLIED", "DispellableDebuffs", 211473, 211470, 209413, 209516, 209033)
	-- Disintegration Beam
	self:Log("SPELL_AURA_APPLIED", "DisintegrationBeam", 207981)
	-- Eye Storm
	self:Log("SPELL_CAST_SUCCESS", "EyeStorm", 212784)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AlertCasts(args)
	self:Message(args.spellId, "Attention", "Alert", CL.casting:format(args.spellName))
end

function mod:AlarmCasts(args)
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
	self:Message(args.spellId, "Personal", "Alert", nil, nil, self:Dispeller("magic"), CL.on:format(args.spellName, args.destName))
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

function mod:DisintegrationBeam(args)
	self:Message(args.spellId, "Attention", "Long")
	self:TargetBar(args.spellId, 10, CL.on:format(args.spellName, args.destName))
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
		self:Say(args.spellId)
	end
end

function mod:EyeStorm(args)
	self:Message(args.spellId, "Attention", "Long")
	self:Bar(args.spellId, 8, CL.cast:format(args.spellName))
end
