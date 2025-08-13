--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Halls of Atonement Trash", 2287)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	164562, -- Depraved Houndmaster
	164563, -- Vicious Gargon
	165515, -- Depraved Darkblade (outdoors)
	167615, -- Depraved Darkblade (indoors)
	165414, -- Depraved Obliterator
	165529, -- Depraved Collector
	167607, -- Stoneborn Slasher
	164557, -- Shard of Halkias
	167612, -- Stoneborn Reaver
	167611, -- Stoneborn Eviscerator
	167892, -- Tormented Soul
	167898, -- Manifestation of Envy
	167876 -- Inquisitor Sigar
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.depraved_houndmaster = "Depraved Houndmaster"
	L.vicious_gargon = "Vicious Gargon"
	L.loyal_stoneborn = "Loyal Stoneborn"
	L.depraved_darkblade = "Depraved Darkblade"
	L.depraved_obliterator = "Depraved Obliterator"
	L.depraved_collector = "Depraved Collector"
	L.stoneborn_slasher = "Stoneborn Slasher"
	L.shard_of_halkias = "Shard of Halkias"
	L.stoneborn_reaver = "Stoneborn Reaver"
	L.stoneborn_eviscerator = "Stoneborn Eviscerator"
	L.inquisitor_sigar = "Inquisitor Sigar"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Depraved Houndmaster
		{326450, "DISPEL", "NAMEPLATE"}, -- Loyal Beasts
		-- Vicious Gargon
		1237602, -- Gushing Wound
		-- Depraved Darkblade
		{1235060, "DISPEL"}, -- Anima Tainted Armor
		-- Depraved Obliterator
		{325876, "SAY", "SAY_COUNTDOWN", "NAMEPLATE"}, -- Mark of Obliteration
		-- Depraved Collector
		{325701, "NAMEPLATE"}, -- Siphon Life
		-- Stoneborn Slasher
		{326997, "NAMEPLATE"}, -- Powerful Swipe
		{1235326, "NAMEPLATE"}, -- Disrupting Screech
		{1237071, "TANK", "NAMEPLATE"}, -- Stone Fist
		-- Shard of Halkias
		{326409, "NAMEPLATE"}, -- Thrash
		{326441, "NAMEPLATE"}, -- Sin Quake
		-- Stoneborn Reaver
		{1235762, "NAMEPLATE"}, -- Turn to Stone
		{1235766, "TANK", "NAMEPLATE"}, -- Mortal Strike
		-- Stoneborn Eviscerator
		{326638, "NAMEPLATE", "OFF"}, -- Hurl Glaive
		-- Inquisitor Sigar
		{326794, "NAMEPLATE"}, -- Dark Communion
		{1236614, "SAY_COUNTDOWN", "NAMEPLATE"}, -- Display of Power
		326847, -- Disperse Sin
		326891, -- Anguish
	}, {
		[326450] = L.depraved_houndmaster,
		[1237602] = L.vicious_gargon,
		[1235060] = L.depraved_darkblade,
		[325876] = L.depraved_obliterator,
		[325701] = L.depraved_collector,
		[326997] = L.stoneborn_slasher,
		[326409] = L.shard_of_halkias,
		[1235762] = L.stoneborn_reaver,
		[326638] = L.stoneborn_eviscerator,
		[326794] = L.inquisitor_sigar,
	}
end

function mod:OnBossEnable()
	-- Depraved Houndmaster
	self:RegisterEngageMob("DepravedHoundmasterEngaged", 164562)
	self:Log("SPELL_CAST_START", "LoyalBeasts", 326450)
	self:Log("SPELL_INTERRUPT", "LoyalBeastsInterrupt", 326450)
	self:Log("SPELL_CAST_SUCCESS", "LoyalBeastsSuccess", 326450)
	self:Log("SPELL_AURA_APPLIED", "LoyalBeastsApplied", 326450)
	self:Death("DepravedHoundmasterDeath", 164562)

	-- Vicious Gargon
	self:Log("SPELL_AURA_APPLIED_DOSE", "GushingWoundApplied", 1237602)

	-- Depraved Darkblade
	self:Log("SPELL_AURA_APPLIED_DOSE", "AnimaTaintedArmorApplied", 1235060)

	-- Depraved Obliterator
	self:RegisterEngageMob("DepravedObliteratorEngaged", 165414)
	self:Log("SPELL_CAST_SUCCESS", "MarkOfObliteration", 325876)
	self:Log("SPELL_AURA_APPLIED", "MarkOfObliterationApplied", 325876)
	self:Log("SPELL_AURA_REMOVED", "MarkOfObliterationRemoved", 325876)
	self:Death("DepravedObliteratorDeath", 165414)

	-- Depraved Collector
	self:RegisterEngageMob("DepravedCollectorEngaged", 165529)
	self:Log("SPELL_CAST_SUCCESS", "SiphonLife", 325701)
	self:Log("SPELL_AURA_APPLIED", "SiphonLifeApplied", 325701)
	self:Death("DepravedCollectorDeath", 165529)

	-- Stoneborn Slasher
	self:RegisterEngageMob("StonebornSlasherEngaged", 167607)
	self:Log("SPELL_CAST_START", "PowerfulSwipe", 326997)
	self:Log("SPELL_CAST_START", "DisruptingScreech", 1235326)
	self:Log("SPELL_CAST_START", "StoneFist", 1237071)
	self:Death("StonebornSlasherDeath", 167607)

	-- Shard of Halkias
	self:RegisterEngageMob("ShardOfHalkiasEngaged", 164557)
	self:Log("SPELL_CAST_START", "Thrash", 326409)
	self:Log("SPELL_CAST_SUCCESS", "SinQuake", 326441)
	self:Death("ShardOfHalkiasDeath", 164557)

	-- Stoneborn Reaver
	self:RegisterEngageMob("StonebornReaverEngaged", 167612)
	self:Log("SPELL_CAST_START", "TurnToStone", 1235762)
	self:Log("SPELL_AURA_APPLIED", "TurnToStoneApplied", 1235762)
	self:Log("SPELL_CAST_START", "MortalStrike", 1235766)
	self:Death("StonebornReaverDeath", 167612)

	-- Stoneborn Eviscerator
	self:RegisterEngageMob("StonebornEvisceratorEngaged", 167611)
	self:Log("SPELL_CAST_SUCCESS", "HurlGlaive", 326638)
	self:Death("StonebornEvisceratorDeath", 167611)

	-- Inquisitor Sigar
	self:RegisterEngageMob("InquisitorSigarEngaged", 167876)
	self:Log("SPELL_CAST_START", "DarkCommunion", 326794)
	self:Log("SPELL_CAST_START", "DisplayOfPower", 1236614)
	self:Log("SPELL_AURA_APPLIED", "DisplayOfPowerApplied", 1236614)
	self:Log("SPELL_AURA_REMOVED", "DisplayOfPowerRemoved", 1236614)
	self:Log("SPELL_CAST_START", "DisperseSin", 326847)
	self:Log("SPELL_PERIODIC_DAMAGE", "AnguishDamage", 326891)
	self:Log("SPELL_PERIODIC_MISSED", "AnguishDamage", 326891)
	self:Death("InquisitorSigarDeath", 167876)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Depraved Houndmaster

function mod:DepravedHoundmasterEngaged(guid)
	self:Nameplate(326450, 15.1, guid) -- Loyal Beasts
end

function mod:LoyalBeasts(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:LoyalBeastsInterrupt(args)
	self:Nameplate(326450, 22.6, args.destGUID)
end

function mod:LoyalBeastsSuccess(args)
	self:Nameplate(args.spellId, 22.6, args.sourceGUID)
end

do
	local prev = 0
	function mod:LoyalBeastsApplied(args)
		if (self:Tank() or self:Healer() or self:Dispeller("enrage", true, args.spellId)) and args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "purple", CL.buff_other:format(args.destName, args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:DepravedHoundmasterDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Vicious Gargon

function mod:GushingWoundApplied(args)
	if self:Me(args.destGUID) and args.amount % 5 == 0 then
		self:StackMessage(args.spellId, "blue", args.destName, args.amount, 10)
		if args.amount >= 15 then
			self:PlaySound(args.spellId, "warning")
		else
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Depraved Darkblade

function mod:AnimaTaintedArmorApplied(args)
	if (self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId)) and args.amount >= 10 and args.amount % 5 == 0 then
		self:StackMessage(args.spellId, "purple", args.destName, args.amount, 15)
		if args.amount > 15 and self:Dispeller("magic", nil, args.spellId) then
			self:PlaySound(args.spellId, "warning")
		else
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Depraved Obliterator

function mod:DepravedObliteratorEngaged(guid)
	self:Nameplate(325876, 8.2, guid) -- Mark of Obliteration
end

function mod:MarkOfObliteration(args)
	self:Nameplate(args.spellId, 23.6, args.sourceGUID)
end

do
	local prevOnMe = 0
	function mod:MarkOfObliterationApplied(args)
		self:TargetMessage(args.spellId, "orange", args.destName)
		if self:Me(args.destGUID) then
			if not self:Solo() and args.time - prevOnMe > 12 then
				prevOnMe = args.time
				self:Say(args.spellId, nil, nil, "Mark of Obliteration")
				self:SayCountdown(args.spellId, 12)
			end
			self:PlaySound(args.spellId, "info")
		else
			self:PlaySound(args.spellId, "alarm", nil, args.destName)
		end
	end

	function mod:MarkOfObliterationRemoved(args)
		if self:Me(args.destGUID) then
			prevOnMe = 0
			self:CancelSayCountdown(args.spellId)
		end
	end
end

function mod:DepravedObliteratorDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Depraved Collector

function mod:DepravedCollectorEngaged(guid)
	self:Nameplate(325701, 3.0, guid) -- Siphon Life
end

function mod:SiphonLife(args)
	self:Nameplate(args.spellId, 15.9, args.sourceGUID)
end

function mod:SiphonLifeApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

function mod:DepravedCollectorDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Stoneborn Slasher

function mod:StonebornSlasherEngaged(guid)
	self:Nameplate(1237071, 5.0, guid) -- Stone Fist
	self:Nameplate(326997, 10.7, guid) -- Powerful Swipe
	self:Nameplate(1235326, 15.9, guid) -- Disrupting Screech
end

function mod:PowerfulSwipe(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 23.1, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:DisruptingScreech(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 32.9, args.sourceGUID)
	self:PlaySound(args.spellId, "warning")
end

function mod:StoneFist(args)
	self:Message(args.spellId, "purple")
	self:Nameplate(args.spellId, 17.1, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:StonebornSlasherDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Shard of Halkias

function mod:ShardOfHalkiasEngaged(guid)
	self:Nameplate(326409, 7.9, guid) -- Thrash
	self:Nameplate(326441, 20.3, guid) -- Sin Quake
end

function mod:Thrash(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 23.1, args.sourceGUID)
	self:PlaySound(args.spellId, "warning")
end

function mod:SinQuake(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 23.1, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:ShardOfHalkiasDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Stoneborn Reaver

function mod:StonebornReaverEngaged(guid)
	self:Nameplate(1235766, 4.3, guid) -- Mortal Strike
	self:Nameplate(1235762, 20.2, guid) -- Turn to Stone
end

do
	local prev = 0
	function mod:TurnToStone(args)
		self:Nameplate(args.spellId, 24.3, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev, playerList = 0, {}
	function mod:TurnToStoneApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
			if args.time - prev > 0.3 then -- TargetsMessage uses a 0.3s throttle
				prev = args.time
				playerList = {}
			end
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(args.spellId, "yellow", playerList, 5)
			self:PlaySound(args.spellId, "info", nil, playerList)
		end
	end
end

do
	local prev = 0
	function mod:MortalStrike(args)
		self:Nameplate(args.spellId, 14.6, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:StonebornReaverDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Stoneborn Eviscerator

function mod:StonebornEvisceratorEngaged(guid)
	self:Nameplate(326638, 9.2, guid) -- Hurl Glaive
end

do
	local prev = 0
	function mod:HurlGlaive(args)
		self:Nameplate(args.spellId, 17.0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:TargetMessage(args.spellId, "red", args.destName)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

function mod:StonebornEvisceratorDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Inquisitor Sigar

do
	local timer

	function mod:InquisitorSigarEngaged(guid)
		self:CDBar(326794, 4.9) -- Dark Communion
		self:Nameplate(326794, 4.9, guid) -- Dark Communion
		self:CDBar(1236614, 15.4) -- Display of Power
		self:Nameplate(1236614, 15.4, guid) -- Display of Power
		timer = self:ScheduleTimer("InquisitorSigarDeath", 20, nil, guid)
	end

	function mod:DarkCommunion(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "cyan")
		self:CDBar(args.spellId, 31.7)
		self:Nameplate(args.spellId, 31.7, args.sourceGUID)
		timer = self:ScheduleTimer("InquisitorSigarDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "long")
	end

	function mod:DisplayOfPower(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 32.1)
		self:Nameplate(args.spellId, 32.1, args.sourceGUID)
		timer = self:ScheduleTimer("InquisitorSigarDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "info")
	end

	function mod:DisplayOfPowerApplied(args)
		if self:Me(args.destGUID) then
			self:SayCountdown(args.spellId, 15)
		end
	end

	function mod:DisplayOfPowerRemoved(args)
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(args.spellId)
		end
	end

	function mod:DisperseSin(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		-- won't be cast unless adds are present when USCS 326846 checks for them
		timer = self:ScheduleTimer("InquisitorSigarDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	do
		local prev = 0
		function mod:AnguishDamage(args)
			if self:Me(args.destGUID) and args.time - prev > 2 then
				prev = args.time
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end

	function mod:InquisitorSigarDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(326794) -- Dark Communion
		self:StopBar(1236614) -- Display of Power
		self:StopBar(326847) -- Disperse Sin
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end
