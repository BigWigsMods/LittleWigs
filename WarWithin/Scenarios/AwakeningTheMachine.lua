--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Awakening the Machine", 2710)
if not mod then return end
mod:RegisterEnableMob(
	210318, -- Speaker Kuldas
	229691, -- Swarmbot
	229695, -- Corrupted Machinist
	229739, -- Malfunctioning Pylon
	229706, -- Explosive Bomberbot
	229778, -- Automatic Ironstrider
	229769, -- Medbot
	229729, -- Nullbot
	229782 -- Awakened Phalanx
)
mod:SetStage(0.5)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.awakening_the_machine = "Awakening the Machine"

	L.stages_desc = "Show an alert when a new wave of enemies spawns."

	L.corrupted_machinist = "Corrupted Machinist"
	L.malfunctioning_pylon = "Malfunctioning Pylon"
	L.explosive_bomberbot = "Explosive Bomberbot"
	L.automatic_ironstrider = "Automatic Ironstrider"
	L.medbot = "Medbot"
	L.nullbot = "Nullbot"
	L.awakened_phalanx = "Awakened Phalanx"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.awakening_the_machine
	self:SetSpellRename(462892, CL.beam) -- Hazardous Beam (Beam)
	self:SetSpellRename(462983, CL.bomb) -- Volatile Magma (Bomb)
	self:SetSpellRename(463081, CL.charge) -- Earthshaking Charge (Charge)
end

function mod:GetOptions()
	return {
		-- Waves
		"stages",
		-- Corrupted Machinist
		462802, -- Purging Flames
		-- Malfunctioning Pylon
		462892, -- Hazardous Beam
		-- Explosive Bomberbot
		462826, -- Self Destruct
		-- Automatic Ironstrider
		{462983, "SAY_COUNTDOWN", "NAMEPLATE"}, -- Volatile Magma
		-- Medbot
		462936, -- Routine Maintenance
		-- Nullbot
		462856, -- Nullification Barrier
		-- Awakened Phalanx
		463052, -- Bellowing Slam
		463081, -- Earthshaking Charge
	},{
		["stages"] = CL.general,
		[462802] = L.corrupted_machinist,
		[462892] = L.malfunctioning_pylon,
		[462826] = L.explosive_bomberbot,
		[462983] = L.automatic_ironstrider,
		[462936] = L.medbot,
		[462856] = L.nullbot,
		[463052] = L.awakened_phalanx,
	},{
		[462892] = CL.beam, -- Hazardous Beam (Beam)
		[462983] = CL.bomb, -- Volatile Magma (Bomb)
		[463081] = CL.charge, -- Earthshaking Charge (Charge)
	}
end

function mod:OnBossEnable()
	-- Waves
	self:RegisterWidgetEvent(5573, "Waves")

	-- Corrupted Machinist
	self:Log("SPELL_CAST_START", "PurgingFlames", 462802)

	-- Malfunctioning Pylon
	self:Log("SPELL_CAST_START", "HazardousBeam", 462892)

	-- Explosive Bomberbot
	self:Log("SPELL_CAST_START", "SelfDestruct", 462826)

	-- Automatic Ironstrider
	self:Log("SPELL_CAST_SUCCESS", "VolatileMagma", 462983)
	self:Log("SPELL_AURA_APPLIED", "VolatileMagmaApplied", 462983)
	self:Log("SPELL_AURA_REMOVED", "VolatileMagmaRemoved", 462983)
	self:Death("AutomaticIronstriderDeath", 229778)

	-- Medbot
	self:Log("SPELL_CAST_START", "RoutineMaintenance", 462936)

	-- Nullbot
	self:Log("SPELL_CAST_SUCCESS", "NullificationBarrier", 462856)

	-- Awakened Phalanx
	self:Log("SPELL_CAST_START", "BellowingSlam", 463052)
	self:Log("SPELL_CAST_START", "EarthshakingCharge", 463081)
	self:Death("AwakenedPhalanxDeath", 229782)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Waves

function mod:Waves(_, text)
	-- [UPDATE_UI_WIDGET] widgetID:5573, widgetType:8, text:Wave 20
	local wave = tonumber(text:match("%d+"))
	if wave and wave ~= 0 then -- widget is reset to 0 once you kill the Awakened Phalanx
		self:SetStage(wave)
		self:Message("stages", "cyan", CL.wave_count:format(wave, 20), false)
		self:PlaySound("stages", "info")
	end
end

-- Corrupted Machinist

do
	local prev = 0
	function mod:PurgingFlames(args)
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Malfunctioning Pylon

function mod:HazardousBeam(args)
	self:Message(args.spellId, "yellow", CL.beam)
	self:PlaySound(args.spellId, "alert")
end

-- Explosive Bomberbot

do
	local prev = 0
	function mod:SelfDestruct(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Automatic Ironstrider

function mod:VolatileMagma(args)
	self:Nameplate(args.spellId, 20.6, args.sourceGUID)
end

function mod:VolatileMagmaApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName, CL.bomb)
	if self:Me(args.destGUID) then
		self:SayCountdown(args.spellId, 8)
	end
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end

function mod:VolatileMagmaRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:AutomaticIronstriderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Medbot

do
	local prev = 0
	function mod:RoutineMaintenance(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Nullbot

do
	local prev = 0
	function mod:NullificationBarrier(args)
		self:Message(args.spellId, "orange", CL.on:format(args.spellName, args.destName))
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Awakened Phalanx

function mod:BellowingSlam(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 20.6)
	self:PlaySound(args.spellId, "alert")
end

function mod:EarthshakingCharge(args)
	self:Message(args.spellId, "red", CL.charge)
	self:CDBar(args.spellId, 25.5, CL.charge)
	self:PlaySound(args.spellId, "alarm")
end

function mod:AwakenedPhalanxDeath()
	self:StopBar(463052) -- Bellowing Slam
	self:StopBar(CL.charge) -- Earthshaking Charge
end
