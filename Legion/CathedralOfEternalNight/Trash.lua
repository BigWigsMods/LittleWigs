
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Cathedral of Eternal Night Trash", 1677)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	118704, -- Dul'zak
	118690, -- Wrathguard Invader
	119952, -- Felguard Destroyer
	119923, -- Helblaze Soulmender
	118703, -- Felborne Botanist
	118714, -- Hellblaze Temptress
	118713, -- Felstrider Orbcaster
	120713, -- Wa'glur
	118719, -- Wyrmtongue Scavenger
	118723, -- Gazerax
	121569  -- Vilebark Walker
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.dulzak = "Dul'zak"
	L.wrathguard = "Wrathguard Invader"
	L.felguard = "Felguard Destroyer"
	L.soulmender = "Helblaze Soulmender"
	L.botanist = "Felborne Botanist"
	L.temptress = "Hellblaze Temptress"
	L.orbcaster = "Felstrider Orbcaster"
	L.waglur = "Wa'glur"
	L.scavenger = "Wyrmtongue Scavenger"
	L.gazerax = "Gazerax"
	L.vilebark = "Vilebark Walker"

	L.throw_tome = "Throw Tome"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Dul'zak
		238653, -- Shadow Wave
		-- Wrathguard Invader
		{236737, "SAY"}, -- Fel Strike
		-- Felguard Destroyer
		241598, -- Shadow Wall
		-- Helblaze Soulmender
		238543, -- Demonic Mending
		-- Felborne Botanist
		237565, -- Blistering Rain
		-- Hellblaze Temptress
		237391, -- Alluring Aroma
		-- Felstrider Orbcaster
		239320, -- Felblaze Orb
		-- Wa'glur
		241772, -- Unearthy Howl
		-- Wyrmtongue Scavenger
		242839, -- Throw Frost Tome
		242841, -- Throw Silence Tome
		239101, -- Throw Arcane Tome
		-- Gazerax
		239232, -- Blinding Glare
		-- Vilebark Walker
		242760, -- Lumbering Crash
	}, {
		[238653] = L.dulzak,
		[236737] = L.wrathguard,
		[241598] = L.felguard,
		[238543] = L.soulmender,
		[237565] = L.botanist,
		[237391] = L.temptress,
		[239320] = L.orbcaster,
		[241772] = L.waglur,
		[242839] = L.scavenger,
		[239232] = L.gazerax,
		[242760] = L.vilebark
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:RegisterEvent("UNIT_SPELLCAST_START", "ShadowWave") -- Shadow Wave
	self:Log("SPELL_CAST_START", "FelStrike", 236737) -- Fel Strike
	self:Log("SPELL_CAST_START", "ShadowWall", 241598) -- Shadow Wall
	self:Log("SPELL_CAST_START", "DemonicMending", 238543) -- Demonic Mending
	self:Log("SPELL_CAST_START", "BlisteringRain", 237565) -- Blistering Rain
	self:Log("SPELL_CAST_START", "AlluringAroma", 237391) -- Alluring Aroma
	self:Log("SPELL_CAST_START", "FelblazeOrb", 239320) -- Felblaze Orb
	self:Log("SPELL_CAST_START", "UnearthyHowl", 241772) -- Unearthy Howl
	self:Log("SPELL_CAST_START", "BlindingGlare", 239232) -- Blinding Glare
	self:Log("SPELL_CAST_START", "ThrowTome", 242839, 242841, 242837) -- Throw Frost Tome, Throw Silence Tome, Throw Arcane Tome
	self:Log("SPELL_CAST_START", "LumberingCrash", 242760) -- Lumbering Crash
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Dul'zak
do
	local prev = nil
	function mod:ShadowWave(_, _, castGUID, spellId)
		if spellId == 238653 and castGUID ~= prev then -- Shadow Wave
			prev = castGUID
			self:MessageOld(spellId, "orange", "alarm", CL.incoming:format(self:SpellName(spellId)))
			self:Bar(spellId, 23.2)
		end
	end
end

-- Wrathguard Invader
do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessageOld(236737, name, "blue", "alert")
			self:Say(236737)
		elseif t-prev > 1.5 then
			prev = t
			self:MessageOld(236737, "yellow", "alert")
		end
	end
	function mod:FelStrike(args)
		self:GetUnitTarget(printTarget, 0.5, args.sourceGUID)
	end
end

-- Felguard Destroyer
function mod:ShadowWall(args)
	self:MessageOld(args.spellId, "yellow", "long", CL.casting:format(args.spellName))
end

-- Helblaze Soulmender
function mod:DemonicMending(args)
	self:MessageOld(args.spellId, "orange", "warning", CL.casting:format(args.spellName))
end

-- Felborne Botanist
function mod:BlisteringRain(args)
	self:MessageOld(args.spellId, "yellow", "long", CL.casting:format(args.spellName))
end

-- Hellblaze Temptress
function mod:AlluringAroma(args)
	self:MessageOld(args.spellId, "orange", "warning", CL.casting:format(args.spellName))
end

-- Felstrider Orbcaster
function mod:FelblazeOrb(args)
	self:MessageOld(args.spellId, "orange", "warning", CL.casting:format(args.spellName))
end

-- Wa'glur
function mod:UnearthyHowl(args)
	self:MessageOld(args.spellId, "orange", "warning", CL.casting:format(args.spellName))
end

-- Gazerax
function mod:BlindingGlare(args)
	self:MessageOld(args.spellId, "orange", "warning", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 2.5)
end

do
	local prev = 0
	function mod:ThrowTome(args)
		local t = GetTime()
		if t-prev > 1 then
			prev = t
			self:MessageOld(args.spellId == 242837 and 239101 or args.spellId, "orange", "warning", CL.casting:format(L.throw_tome)) -- using a different ID for Arcane Tome's options because 242837 has no description
		end
	end
end

-- Vilebark Walker
function mod:LumberingCrash(args)
	self:MessageOld(args.spellId, "red", "alarm", CL.casting:format(args.spellName))
end
