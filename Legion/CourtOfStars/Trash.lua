
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
	108151, -- Gerenth the Vile
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
	105699 -- Mana Saber
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
		209485, -- Drain Magic (Arcane Manifestation)
		209477, -- Wild Detonation (Mana Wyrm)
		209410, -- Nightfall Orb (Duskwatch Arcanist)
		209404, -- Seal Magic (Duskwatch Arcanist)
		209516, -- Mana Fang (Mana Saber)
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	-- Charging Station, Shadow Bolt Volley, Carrion Swarm, Shockwave, Whirling Blades, Bewitch, Drain Magic, Wild Detonation, Nightfall Orb, Seal Magic
	self:Log("SPELL_CAST_START", "AlertCasts", 225100, 214692, 214688, 207979, 209378, 211470, 209485, 209477, 209410, 209404)
	-- Quelling Strike, Fel Detonation, Searing Glare, Eye Storm, Drifting Embers, Charged Blast, Suppress
	self:Log("SPELL_CAST_START", "AlarmCasts", 209027, 211464, 211299, 212784, 211401, 212031, 209413)
	-- Felblaze Puddle, Charged Smash
	self:Log("SPELL_AURA_APPLIED", "PeriodicDamage", 211391, 209495)
	self:Log("SPELL_PERIODIC_DAMAGE", "PeriodicDamage", 211391, 209495)
	self:Log("SPELL_PERIODIC_MISSED", "PeriodicDamage", 211391, 209495)
	-- Shadow Slash
	self:Log("SPELL_AURA_APPLIED", "ShadowSlash", 211473)
	-- Disintegration Beam
	self:Log("SPELL_AURA_APPLIED", "DisintegrationBeam", 207981)
	-- Suppress
	self:Log("SPELL_AURA_APPLIED", "SuppressApplied", 209413)
	-- Mana Fang
	self:Log("SPELL_AURA_APPLIED", "ManaFang", 209516)
	-- Fortification
	self:Log("SPELL_AURA_APPLIED", "Fortification", 209033)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AlertCasts(args)
	self:Message(args.spellId, "Important", "Alert", CL.incoming:format(args.spellName))
end

function mod:AlarmCasts(args)
	self:Message(args.spellId, "Important", "Alarm", CL.incoming:format(args.spellName))
end

do
	local prev = 0
	function mod:PeriodicDamage(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 2 then
			prev = t
			self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
		end
	end
end

function mod:DisintegrationBeam(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alarm")
	self:TargetBar(args.spellId, 5, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
		self:Say(args.spellId)
	end
end

function mod:SuppressApplied(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alarm", nil, nil, self:Dispeller("magic"))
	self:TargetBar(args.spellId, 6, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
		self:Say(args.spellId)
	end
end

function mod:ShadowSlash(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alert")
	self:TargetBar(args.spellId, 6, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
		self:Say(args.spellId)
	end
end

function mod:ManaFang(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alert", nil, nil, self:Dispeller("magic"))
	self:TargetBar(args.spellId, 12, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
		self:Say(args.spellId)
	end
end

function mod:Fortification(args)
	local unit = self:GetUnitIdByGUID(args.sourceGUID)
	if unit then
		local _, _, _, buffed = UnitBuff(unit, args.spellName)
		if buffed and self:Dispeller("magic", true) then
			self:Message(args.spellId, "Attention", "Alert", CL.incoming:format(args.spellName))
		end
	end
end