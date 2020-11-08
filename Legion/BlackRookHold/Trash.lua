
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Black Rook Hold Trash", 1501)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	98280, -- Risen Arcanist
	98243, -- Soul-torn Champion
	100485, -- Soul-torn Vanguard
	102094, -- Risen Swordsman
	98275, -- Risen Archer
	98691, -- Risen Scout
	98370, -- Ghostly Councilor
	102788 -- Felspite Dominator
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.arcanist = "Risen Arcanist"
	L.champion = "Soul-torn Champion"
	L.swordsman = "Risen Swordsman"
	L.archer = "Risen Archer"
	L.scout = "Risen Scout"
	L.councilor = "Ghostly Councilor"
	L.dominator = "Felspite Dominator"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		200248, -- Arcane Blitz (Risen Arcanist)
		200261, -- Bonebreaking Strike (Soul-torn Champion)
		197974, -- Bonecrushing Strike (Soul-torn Vanguard)
		214003, -- Coup de Grace (Risen Swordsman)
		200343, -- Arrow Barrage (Risen Archer)
		200291, -- Knife Dance (Risen Scout)
		225573, -- Dark Mending (Ghostly Councilor)
		203163, -- Sic Bats! (Felspite Dominator)
		227913  -- Felfrenzy (Felspite Dominator)
	}, {
		[200248] = L.arcanist,
		[200261] = L.champion,
		[214003] = L.swordsman,
		[200343] = L.archer,
		[200291] = L.scout,
		[225573] = L.councilor,
		[203163] = L.dominator
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_CAST_START", "ArcaneBlitz", 200248)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ArcaneBlitzApplied", 200248)
	self:Log("SPELL_AURA_REMOVED", "ArcaneBlitzRemoved", 200248)
	self:Log("SPELL_CAST_START", "BonebreakingStrike", 200261, 197974) -- 197974 = Bonecrushing Strike
	self:Log("SPELL_CAST_START", "CoupdeGrace", 214003)
	self:Log("SPELL_CAST_START", "ArrowBarrage", 200343)
	self:Log("SPELL_CAST_START", "KnifeDance", 200291)
	self:Log("SPELL_CAST_START", "DarkMending", 225573)
	self:Log("SPELL_AURA_APPLIED", "SicBats", 203163)
	self:Log("SPELL_CAST_START", "Felfrenzy", 227913)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local blitzTracker = {}

	-- Risen Arcanist
	function mod:ArcaneBlitz(args)
		-- only show a message if stacks are getting high (6 = 300% which is around 1m damage a hit)
		local amount = blitzTracker[args.sourceGUID]
		if amount and amount > 5 and (self:Interrupter(args.sourceGUID) or self:Dispeller("magic", true)) then
			self:MessageOld(args.spellId, "yellow", "alert", CL.count:format(args.spellName, amount))
		end
	end
	function mod:ArcaneBlitzApplied(args)
		blitzTracker[args.destGUID] = args.amount
	end
	function mod:ArcaneBlitzRemoved(args)
		blitzTracker[args.destGUID] = nil
	end
end

-- Soul-torn Champion, Soul-torn Vanguard
function mod:BonebreakingStrike(args)
	self:MessageOld(args.spellId, "orange", "alarm", CL.incoming:format(args.spellName))
end

-- Risen Swordsman
function mod:CoupdeGrace(args)
	self:MessageOld(args.spellId, "red", "alarm", CL.incoming:format(args.spellName))
end

-- Risen Archer
function mod:ArrowBarrage(args)
	self:MessageOld(args.spellId, "yellow", "warning", CL.casting:format(args.spellName))
end

-- Risen Scout
function mod:KnifeDance(args)
	self:MessageOld(args.spellId, "red", "alert", CL.casting:format(args.spellName))
end

-- Ghostly Councilor
function mod:DarkMending(args)
	self:MessageOld(args.spellId, "yellow", self:Interrupter() and "alarm", CL.casting:format(args.spellName))
end

-- Felspite Dominator
function mod:Felfrenzy(args)
	self:MessageOld(args.spellId, "yellow", self:Interrupter() and "alarm", CL.casting:format(args.spellName))
end

do
	local prev = 0
	function mod:SicBats(args)
		local t = GetTime()
		if t-prev > 1.5 then
			prev = t
			self:TargetMessageOld(args.spellId, args.destName, "orange", "warning")
		end
	end
end
