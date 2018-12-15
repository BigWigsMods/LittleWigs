
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The MOTHERLODE!! Trash", 1594)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	136934, -- Weapons Tester
	134232, -- Hired Assassin
	130488, -- Mech Jockey
	130661, -- Venture Co. Earthshaper
	130635, -- Stonefury
	133345, -- Feckless Assistant
	133593, -- Expert Technician
	133430, -- Venture Co. Mastermind
	133432, -- Venture Co. Alchemist
	130653, -- Wanton Sapper
	136470, -- Refreshment Vendor
	136643  -- Azerite Extractor
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.tester = "Weapons Tester"
	L.assassin = "Hired Assassin"
	L.jockey = "Mech Jockey"
	L.earthshaper = "Venture Co. Earthshaper"
	L.stonefury = "Stonefury"
	L.assistant = "Feckless Assistant"
	L.technician = "Expert Technician"
	L.mastermind = "Venture Co. Mastermind"
	L.alchemist = "Venture Co. Alchemist"
	L.sapper = "Wanton Sapper"
	L.vendor = "Refreshment Vendor"
	L.extractor = "Azerite Extractor"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Weapons Tester
		268846, -- Echo Blade
		-- Hired Assassin
		269302, -- Toxic Blades
		-- Mech Jockey
		267433, -- Activate Mech
		-- Venture Co. Earthshaper
		268709, -- Earth Shield
		-- Stonefury
		268702, -- Furious Quake
		263215, -- Tectonic Barrier
		-- Feckless Assistant
		263066, -- Transfiguration Serum
		-- Expert Technician
		262540, -- Overcharge
		262554, -- Repair
		-- Venture Co. Mastermind
		262947, -- Azerite Injection
		-- Venture Co. Alchemist
		268797, -- Transmute: Enemy to Goo
		-- Wanton Sapper
		269313, -- Final Blast
		-- Refreshment Vendor
		280605, -- Brain Freeze
		-- Azerite Extractor
		268415, -- Power Through
	}, {
		[268846] = L.tester,
		[269302] = L.assassin,
		[267433] = L.jockey,
		[268709] = L.earthshaper,
		[268702] = L.stonefury,
		[263066] = L.assistant,
		[262540] = L.technician,
		[262947] = L.mastermind,
		[268797] = L.alchemist,
		[269313] = L.sapper,
		[280605] = L.vendor,
		[268415] = L.extractor,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_CAST_START", "EchoBlade", 268846)
	self:Log("SPELL_CAST_START", "ToxicBlades", 269302)
	self:Log("SPELL_CAST_START", "ActivateMech", 267433)
	self:Log("SPELL_AURA_APPLIED", "EarthShieldApplied", 268709)
	self:Log("SPELL_CAST_START", "FuriousQuake", 268702)
	self:Log("SPELL_CAST_START", "TectonicBarrier", 263215)
	self:Log("SPELL_AURA_APPLIED", "TectonicBarrierApplied", 263215)
	self:Log("SPELL_CAST_START", "TransfigurationSerum", 263066)
	self:Log("SPELL_CAST_START", "Overcharge", 262540)
	self:Log("SPELL_AURA_APPLIED", "OverchargeApplied", 262540)
	self:Log("SPELL_CAST_START", "Repair", 262554)
	self:Log("SPELL_AURA_APPLIED", "AzeriteInjectionApplied", 262947)
	self:Log("SPELL_CAST_START", "TransmuteEnemyToGoo", 268797)
	self:Log("SPELL_AURA_APPLIED", "TransmuteEnemyToGooApplied", 268797)
	self:Log("SPELL_AURA_REMOVED", "TransmuteEnemyToGooRemoved", 268797)
	self:Log("SPELL_CAST_START", "FinalBlast", 269313)
	self:Log("SPELL_AURA_APPLIED", "BrainFreezeApplied", 280605)
	self:Log("SPELL_AURA_REMOVED", "BrainFreezeRemoved", 280605)
	self:Log("SPELL_CAST_SUCCESS", "PowerThrough", 268415)
	
	self:Log("SPELL_DAMAGE", "StonefuryInteract", "*")
	self:Log("SWING_DAMAGE", "StonefuryInteract", "*")
	self:Log("SPELL_AURA_APPLIED", "StonefuryAuraApplied", "*")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Weapons Tester
function mod:EchoBlade(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "watchstep")
end

-- Hired Assassin
function mod:ToxicBlades(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "interrupt")
end

-- Mech Jockey
function mod:ActivateMech(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "long", "mobout")
end

-- Venture Co. Earthshaper
function mod:EarthShieldApplied(args)
	if not UnitIsPlayer(args.destName) then
		self:Message2(args.spellId, "red", CL.other:format(args.spellName, args.destName))
		if self:Dispeller("magic", true) then
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Stonefury
do
	local engagedStonefury = {}
	function mod:StonefuryInteract(args)
		if self:MobId(args.sourceGUID) == 130635 then
			engagedStonefury[args.sourceGUID] = true
		elseif self:MobId(args.destGUID) == 130635 then
			engagedStonefury[args.destGUID] = true
		end
	end

	function mod:StonefuryAuraApplied(args)
		local destGUID = args.destGUID
		if self:MobId(destGUID) == 130635 and args.sourceGUID ~= destGUID then
			engagedStonefury[destGUID] = true
		end
	end

	function mod:FuriousQuake(args)
		if engagedStonefury[args.sourceGUID] then
			self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning", "interrupt")
		end
	end
end

do
	local prev = 0
	function mod:TectonicBarrier(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message2(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning", "interrupt")
		end
	end
end

function mod:TectonicBarrierApplied(args)
	if not UnitIsPlayer(args.destName) then
		self:Message2(args.spellId, "red", CL.other:format(args.spellName, args.destName))
		if self:Dispeller("magic", true) then
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Feckless Assistant
function mod:TransfigurationSerum(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm", "interrupt")
end

-- Expert Technician
function mod:Overcharge(args)
	self:Message2(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "interrupt")
end

function mod:Repair(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "interrupt")
end

function mod:OverchargeApplied(args)
	if not UnitIsPlayer(args.destName) then
		self:Message2(args.spellId, "yellow", CL.other:format(args.spellName, args.destName))
		if self:Dispeller("magic", true) then
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Venture Co. Mastermind
function mod:AzeriteInjectionApplied(args)
	if not UnitIsPlayer(args.destName) then
		self:Message2(args.spellId, "red", CL.other:format(args.spellName, args.destName))
		if self:Dispeller("magic", true) then
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Venture Co. Alchemist
function mod:TransmuteEnemyToGoo(args)
	self:Message2(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "interrupt")
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:TransmuteEnemyToGooApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessage2(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:TransmuteEnemyToGooRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

-- Wanton Sapper
do
	local prev = 0
	function mod:FinalBlast(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message2(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Refreshment Vendor
function mod:BrainFreezeApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessage2(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
		self:TargetBar(args.spellId, 6, args.destName)
	end
end

function mod:BrainFreezeRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

-- Azerite Extractor
function mod:PowerThrough(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "watchstep")
end
