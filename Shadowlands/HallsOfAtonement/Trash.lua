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
	167607, -- Stoneborn Slasher
	167876 -- Inquisitor Sigar
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
	L.sigar = "Inquisitor Sigar"
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
		342171, -- Loyal Stoneborn
		{325523, "TANK"}, -- Deadly Thrust
		{325876, "SAY", "SAY_COUNTDOWN"}, -- Curse of Obliteration
		325700, -- Collect Sins
		325701, -- Siphon Life
		{326409, "CASTBAR"}, -- Thrash
		326441, -- Sin Quake
		326607, -- Turn to Stone
		{326997, "TANK"}, -- Powerful Swipe
		326891, -- Anguish
	},{
		[326450] = L.houndmaster,
		[344993] = L.gargon,
		[346866] = L.loyalstoneborn,
		[325523] = L.darkblade,
		[325876] = L.obliterator,
		[325700] = L.collector,
		[326409] = L.shard,
		[326607] = L.reaver,
		[326997] = L.slasher,
		[326891] = L.sigar,
	},{
		[325876] = CL.curse, -- Curse of Obliteration (Curse)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "LoyalBeasts", 326450)
	self:Log("SPELL_AURA_APPLIED", "LoyalBeastsApplied", 326450)
	self:Log("SPELL_DAMAGE", "RapidFire", 325799)
	self:Log("SPELL_MISSED", "RapidFire", 325799)
	self:Log("SPELL_AURA_APPLIED_DOSE", "JaggedSwipe", 344993)
	self:Log("SPELL_CAST_START", "StoneBreath", 346866)
	self:Log("SPELL_CAST_SUCCESS", "LoyalStoneborn", 342171)
	self:Log("SPELL_CAST_START", "DeadlyThrust", 325523)
	self:Log("SPELL_CAST_START", "CurseOfObliteration", 325876)
	self:Log("SPELL_AURA_APPLIED", "CurseOfObliterationApplied", 325876)
	self:Log("SPELL_AURA_REMOVED", "CurseOfObliterationRemoved", 325876)
	self:Log("SPELL_CAST_START", "CollectSins", 325700)
	self:Log("SPELL_CAST_START", "SiphonLife", 325701)
	self:Log("SPELL_CAST_START", "ThrashPreCast", 326409)
	self:Log("SPELL_AURA_APPLIED", "Thrash", 326409)
	self:Log("SPELL_AURA_REMOVED", "ThrashOver", 326409)
	self:Log("SPELL_CAST_SUCCESS", "SinQuake", 326441)
	self:Log("SPELL_CAST_START", "TurnToStone", 326607)
	self:Log("SPELL_AURA_APPLIED", "TurnToStoneBuffApplied", 326607)
	self:Log("SPELL_AURA_APPLIED", "TurnToStoneDebuffApplied", 326617)
	self:Log("SPELL_CAST_START", "PowerfulSwipe", 326997)

	self:Log("SPELL_AURA_APPLIED", "AnguishDamage", 326891)
	self:Log("SPELL_PERIODIC_DAMAGE", "AnguishDamage", 326891)
	self:Log("SPELL_PERIODIC_MISSED", "AnguishDamage", 326891)
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
	function mod:LoyalBeastsApplied(args)
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
		self:StackMessageOld(args.spellId, args.destName, stacks, "blue")
		self:PlaySound(args.spellId, stacks > 5 and "warning" or "alert")
	end
end

-- Loyal Stoneborn
function mod:StoneBreath(args)
	if self:Friendly(args.sourceFlags) then return end

	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

function mod:LoyalStoneborn(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 45)
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
	self:TargetMessage(args.spellId, "orange", args.destName, CL.curse)
	self:TargetBar(args.spellId, 6, args.destName, CL.curse)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, CL.curse, nil, "Curse")
		self:SayCountdown(args.spellId, 6)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	else
		self:PlaySound(args.spellId, "info")
	end
end

function mod:CurseOfObliterationRemoved(args)
	self:StopBar(CL.curse, args.destName)

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

function mod:SinQuake(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

-- Stoneborn Reaver
function mod:TurnToStone(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, self:Interrupter() and "warning" or "alert")
end

do
	local prev = 0
	function mod:TurnToStoneBuffApplied(args)
		if not self:Player(args.destFlags) and self:Dispeller("magic", true) then
			local t = args.time
			if t-prev > 2 then
				prev = t
				self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
				self:PlaySound(args.spellId, "warning")
			end
		end
	end
end

do
	local playerList = mod:NewTargetList()
	function mod:TurnToStoneDebuffApplied(args)
		if self:Dispeller("magic") then
			playerList[#playerList+1] = args.destName
			self:PlaySound(326607, "alert", nil, playerList)
			self:TargetsMessageOld(326607, "orange", playerList, 5)
		end
	end
end

-- Stoneborn Slasher
function mod:PowerfulSwipe(args)
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Inquisitor Sigar
do
	local prev = 0
	function mod:AnguishDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t-prev > 2 then
				prev = t
				self:PlaySound(args.spellId, "underyou")
				self:PersonalMessage(args.spellId, "underyou")
			end
		end
	end
end
