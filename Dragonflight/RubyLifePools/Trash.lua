--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ruby Life Pools Trash", 2521)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	188244, -- Primal Juggernaut
	187969, -- Flashfrost Earthshaper
	188067, -- Flashfrost Chillweaver
	187897, -- Defier Draghar
	190206, -- Primalist Flamedancer
	190034, -- Blazebound Destroyer
	195119, -- Primalist Shockcaster
	197698, -- Thunderhead
	197697, -- Flamegullet
	198047, -- Tempest Channeler
	197985, -- Flame Channeler
	197535  -- High Channeler Ryvati
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.primal_juggernaut = "Primal Juggernaut"
	L.flashfrost_earthshaper = "Flashfrost Earthshaper"
	L.flashfrost_chillweaver = "Flashfrost Chillweaver"
	L.defier_draghar = "Defier Draghar"
	L.primalist_flamedancer = "Primalist Flamedancer"
	L.blazebound_destroyer = "Blazebound Destroyer"
	L.primalist_shockcaster = "Primalist Shockcaster"
	L.thunderhead = "Thunderhead"
	L.flamegullet = "Flamegullet"
	L.tempest_channeler = "Tempest Channeler"
	L.flame_channeler = "Flame Channeler"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Primal Juggernaut
		372696, -- Excavating Blast
		-- Flashfrost Earthshaper
		372735, -- Tectonic Slam
		-- Flashfrost Chillweaver
		372743, -- Ice Shield
		-- Defier Draghar
		372087, -- Blazing Rush
		372047, -- Steel Barrage
		-- Primalist Flamedancer
		385536, -- Flame Dance
		{373972, "DISPEL"}, -- Blaze of Glory
		-- Blazebound Destroyer
		{373693, "SAY", "SAY_COUNTDOWN"}, -- Living Bomb
		373692, -- Inferno
		373614, -- Burnout
		-- Primalist Shockcaster
		{385313, "DISPEL"}, -- Unlucky Strike
		-- Thunderhead
		392640, -- Rolling Thunder
		391726, -- Storm Breath
		{392395, "TANK_HEALER"}, -- Thunder Jaw
		-- Flamegullet
		391723, -- Flame Breath
		392569, -- Molten Blood
		{392394, "TANK_HEALER"}, -- Fire Maw
		-- Tempest Channeler
		392486, -- Lightning Storm
		-- Flame Channeler
		392451, -- Flashfire
	}, {
		[372696] = L.primal_juggernaut,
		[372735] = L.flashfrost_earthshaper,
		[372743] = L.flashfrost_chillweaver,
		[372087] = L.defier_draghar,
		[385536] = L.primalist_flamedancer,
		[373693] = L.blazebound_destroyer,
		[385313] = L.primalist_shockcaster,
		[392640] = L.thunderhead,
		[391723] = L.flamegullet,
		[392486] = L.tempest_channeler,
		[392451] = L.flame_channeler,
	}
end

function mod:OnBossEnable()
	-- Primal Juggernaut
	self:Log("SPELL_CAST_START", "ExcavatingBlast", 372696)

	-- Flashfrost Earthshaper
	self:Log("SPELL_CAST_START", "TectonicSlam", 372735)

	-- Flashfrost Chillweaver
	self:Log("SPELL_CAST_SUCCESS", "IceShield", 372743)

	-- Defier Draghar
	self:Log("SPELL_CAST_START", "BlazingRush", 372087)
	self:Log("SPELL_CAST_START", "SteelBarrage", 372047)
	self:Death("DefierDragharDeath", 187897)

	-- Primalist Flamedancer
	self:Log("SPELL_CAST_SUCCESS", "FlameDance", 385536)
	self:Log("SPELL_AURA_APPLIED", "BlazeOfGloryApplied", 373972)

	-- Blazebound Destroyer
	self:Log("SPELL_AURA_APPLIED", "LivingBombApplied", 373693)
	self:Log("SPELL_AURA_REMOVED", "LivingBombRemoved", 373693)
	self:Log("SPELL_CAST_START", "Inferno", 373692)
	self:Log("SPELL_CAST_START", "Burnout", 373614)

	-- Primalist Shockcaster
	self:Log("SPELL_AURA_APPLIED", "UnluckyStrikeApplied", 385313)

	-- Thunderhead
	self:Log("SPELL_CAST_START", "RollingThunder", 392640)
	self:Log("SPELL_AURA_APPLIED", "RollingThunderApplied", 392641)
	self:Log("SPELL_CAST_START", "StormBreath", 391726)
	self:Log("SPELL_CAST_START", "ThunderJaw", 392395)
	self:Death("ThunderheadDeath", 197698)

	-- Flamegullet
	self:Log("SPELL_CAST_START", "FlameBreath", 391723)
	self:Log("SPELL_CAST_START", "FireMaw", 392394)
	self:Log("SPELL_AURA_APPLIED", "MoltenBlood", 392569)
	self:Death("FlamegulletDeath", 197697)

	-- Tempest Channeler
	self:Log("SPELL_CAST_START", "LightningStorm", 392486)

	-- Flame Channeler
	self:Log("SPELL_CAST_START", "Flashfire", 392451)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Primal Juggernaut

function mod:ExcavatingBlast(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

-- Flashfrost Earthshaper

function mod:TectonicSlam(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

-- Flashfrost Chillweaver

do
	local prev = 0
	function mod:IceShield(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Defier Draghar

function mod:BlazingRush(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 17)
end

function mod:SteelBarrage(args)
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 18.2)
end

function mod:DefierDragharDeath(args)
	self:StopBar(372087) -- Blazing Rush
	self:StopBar(372047) -- Steel Barrage
end

-- Primalist Flamedancer

function mod:FlameDance(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:BlazeOfGloryApplied(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Player(args.destFlags) then
		self:Message(args.spellId, "red", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "alert")
	end
end

-- Blazebound Destroyer

function mod:LivingBombApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, 6)
	end
end

function mod:LivingBombRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:Inferno(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:Burnout(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

-- Primalist Shockcaster

function mod:UnluckyStrikeApplied(args)
	if self:Dispeller("curse", nil, args.spellId) or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Thunderhead

do
	local playerList = {}

	function mod:RollingThunder(args)
		playerList = {}
		self:CDBar(args.spellId, 22)
	end

	function mod:RollingThunderApplied(args)
		playerList[#playerList+1] = args.destName
		self:TargetsMessage(392640, "red", playerList, 2)
		self:PlaySound(392640, "alert", nil, playerList)
	end
end

function mod:StormBreath(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 14.5)
end

function mod:ThunderJaw(args)
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 19.3)
end

function mod:ThunderheadDeath(args)
	self:StopBar(392640) -- Rolling Thunder
	self:StopBar(391726) -- Storm Breath
	self:StopBar(392395) -- Thunder Jaw
end

-- Flamegullet

function mod:FlameBreath(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 14.5)
end

function mod:FireMaw(args)
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 23.0)
end

function mod:MoltenBlood(args)
	self:Message(args.spellId, "red", CL.percent:format(50, args.spellName))
	self:PlaySound(args.spellId, "long")
end

function mod:FlamegulletDeath(args)
	self:StopBar(391723) -- Flame Breath
	self:StopBar(392394) -- Fire Maw
end

-- Tempest Channeler

function mod:LightningStorm(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end

-- Flame Channeler

function mod:Flashfire(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
