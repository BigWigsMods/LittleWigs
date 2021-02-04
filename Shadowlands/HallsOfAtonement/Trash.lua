--------------------------------------------------------------------------------
-- TODO:
--
-- Turn to Stone applies a dispellable stun, might need a warning.

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Halls of Atonement Trash", 2287)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	164562, -- Depraved Houndmaster
	164563, -- Vicious Gargon
	174175, -- Loyal Stoneborn
	165515, -- Depraved Darkblade
	167615, -- Depraved Darkblade
	165414, -- Depraved Obliterator
	165529, -- Depraved Collector
	164557, -- Shard of Halkias
	167612, -- Stoneborn Reaver
	167607 -- Stoneborn Slasher
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.houndmaster = "Depraved Houndmaster"
	L.gargon = "Vicious Gargon"
	L.loyalstoneborn = "Loyal Stoneborn"
	L.darkblade = "Depraved Darkblade"
	L.obliterator = "Depraved Obliterator"
	L.collector = "Depraved Collector"
	L.shard = "Shard of Halkias"
	L.reaver = "Stoneborn Reaver"
	L.slasher = "Stoneborn Slasher"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		326450, -- Loyal Beasts
		325799, -- Rapid Fire
		344993, -- Jagged Swipe
		346866, -- Stone Breath
		{325523, "TANK"}, -- Deadly Thrust
		{325876, "SAY", "SAY_COUNTDOWN"}, -- Curse of Obliteration
		325700, -- Collect Sins
		325701, -- Siphon Life
		326409, -- Thrash
		326607, -- Turn to Stone
		{326997, "TANK"} -- Powerful Swipe
	}, {
		[326450] = L.houndmaster,
		[344993] = L.gargon,
		[346866] = L.loyalstoneborn,
		[325523] = L.darkblade,
		[325876] = L.obliterator,
		[325700] = L.collector,
		[326409] = L.shard,
		[326607] = L.reaver,
		[326997] = L.slasher,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "LoyalBeasts", 326450)
	self:Log("SPELL_AURA_APPLIED", "LoyalBeastsSuccess", 326450)
	self:Log("SPELL_DAMAGE", "RapidFire", 325799)
	self:Log("SPELL_MISSED", "RapidFire", 325799)
	self:Log("SPELL_AURA_APPLIED_DOSE", "JaggedSwipe", 344993)
	self:Log("SPELL_CAST_START", "StoneBreath", 346866)
	self:Log("SPELL_CAST_START", "DeadlyThrust", 325523)
	self:Log("SPELL_CAST_START", "CurseOfObliteration", 325876)
	self:Log("SPELL_AURA_APPLIED", "CurseOfObliterationApplied", 325876)
	self:Log("SPELL_AURA_REMOVED", "CurseOfObliterationRemoved", 325876)
	self:Log("SPELL_CAST_START", "CollectSins", 325700)
	self:Log("SPELL_CAST_START", "SiphonLife", 325701)
	self:Log("SPELL_CAST_START", "ThrashPreCast", 326409)
	self:Log("SPELL_AURA_APPLIED", "Thrash", 326409)
	self:Log("SPELL_AURA_REMOVED", "ThrashOver", 326409)
	self:Log("SPELL_CAST_START", "TurnToStone", 326607)
	self:Log("SPELL_CAST_START", "PowerfulSwipe", 326997)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Depraved Houndmaster
function mod:LoyalBeasts(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

do
	-- This is an AoE cast that could affect 0 Gargons,
	-- so SPELL_AURA_APPLIED with throttling it is.
	local prev = 0
	function mod:LoyalBeastsSuccess(args)
		if self:Tank() or self:Healer() or self:Dispeller("enrage", true) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
				self:PlaySound(args.spellId, "warning")
			end
		end
	end
end

do
	local prev = 0
	function mod:RapidFire(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId, "near")
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end

-- Vicious Gargon
function mod:JaggedSwipe(args)
	local stacks = args.amount
	if self:Me(args.destGUID) and stacks % 3 == 0 then
		self:StackMessage(args.spellId, args.destName, stacks, "blue")
		self:PlaySound(args.spellId, stacks > 5 and "warning" or "alert")
	end
end

-- Loyal Stoneborn
function mod:StoneBreath(args)
	if bit.band(args.sourceFlags, 0x10) ~= 0 then return end -- COMBATLOG_OBJECT_REACTION_FRIENDLY

	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

-- Depraved Darkblade
do
	local prev = 0
	function mod:DeadlyThrust(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Depraved Obliterator
do
	local prev = 0
	function mod:CurseOfObliteration(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:CurseOfObliterationApplied(args)
	local isOnMe = self:Me(args.destGUID)

	self:TargetMessage(args.spellId, "cyan", args.destName)
	self:TargetBar(args.spellId, 6, args.destName)
	self:PlaySound(args.spellId, isOnMe and "alarm" or "info", nil, args.destName)

	if isOnMe then
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, 6)
	end
end

function mod:CurseOfObliterationRemoved(args)
	self:StopBar(args.spellName, args.destName)

	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

-- Depraved Collector
function mod:CollectSins(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:SiphonLife(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

-- Shard of Halkias
function mod:ThrashPreCast(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 2)
	self:PlaySound(args.spellId, "warning")
end

function mod:Thrash(args)
	self:Bar(args.spellId, 8)
end

function mod:ThrashOver(args)
	self:StopBar(args.spellName)
end

-- Stoneborn Reaver
function mod:TurnToStone(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, self:Interrupter() and "warning" or "alert")
end

-- Stoneborn Slasher
function mod:PowerfulSwipe(args)
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
