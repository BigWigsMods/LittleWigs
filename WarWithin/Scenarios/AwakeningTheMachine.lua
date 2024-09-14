--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Awakening the Machine", 2710)
if not mod then return end
mod:RegisterEnableMob(
	210318, -- Speaker Kuldas
	229691, -- Swarmbot
	229695, -- Corrupted Machinist
	229706, -- Explosive Bomberbot
	229739, -- Malfunctioning Pylon
	229778, -- Automatic Ironstrider
	229769, -- Medbot
	229729, -- Nullbot
	229782 -- Awakened Phalanx
)
mod:SetStage(0.5)

--------------------------------------------------------------------------------
-- Locals
--

local mobsKilled = 0
local mobsNeeded = {
	3, -- Wave 1: 3x Swarmbot
	3, -- Wave 2: 2x Swarmbot 1x Corrupted Machinist
	4, -- Wave 3: 3x Swarmbot 1x Corrupted Machinist
	5, -- Wave 4: 5x Swarmbot
	5, -- Wave 5: 2x Swarmbot 2x Corrupted Machinist 1x Explosive Bomberbot
	3, -- Wave 6: 2x Swarmbot 1x Malfunctioning Pylon
	3, -- Wave 7: 2x Swarmbot 1x Malfunctioning Pylon
	5, -- Wave 8: 2x Swarmbot 2x Corrupted Machinist 1x Malfunctioning Pylon
	5, -- Wave 9: 3x Swarmbot 1x Corrupted Machinist 1x Malfunctioning Pylon
	4, -- Wave 10: 3x Swarmbot 1x Automatic Ironstrider
	5, -- Wave 11: 4x Swarmbot 1x Medbot
	5, -- Wave 12: 1x Swarmbot 1x Corrupted Machinist 1x Malfunctioning Pylon 1x Medbot 1x Nullbot
	4, -- Wave 13: 1x Swarmbot 2x Explosive Bomberbot 1x Nullbot
	5, -- Wave 14: 1x Swarmbot 2x Explosive Bomberbot 1x Medbot 1x Nullbot
	7, -- Wave 15: 2x Swarmbot 2x Explosive Bomberbot 1x Malfunctioning Pylon 1x Automatic Ironstrider 1x Medbot
	8, -- Wave 16: 3x Swarmbot 3x Explosive Bomberbot 2x Medbot
	6, -- Wave 17: 1x Corrupted Machinist 2x Explosive Bomberbot 1x Malfunctioning Pylon 1x Automatic Ironstrider 1x Medbot
	10, -- Wave 18: 5x Swarmbot 1x Corrupted Machinist 1x Explosive Bomberbot 1x Malfunctioning Pylon 1x Automatic Ironstrider 1x Nullbot
	14, -- Wave 19: 5x Swarmbot 2x Explosive Bomberbot 1x Automatic Ironstrider 4x Medbot 2x Nullbot
	-- Wave 20: 1x Awakened Phalanx
}

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.awakening_the_machine = "Awakening the Machine"
	L.stages_desc = "Show an alert when a new wave of enemies spawns."
	L.stages_icon = "inv_cape_armor_earthencivilian_d_02_silver"

	L.corrupted_machinist = "Corrupted Machinist"
	L.explosive_bomberbot = "Explosive Bomberbot"
	L.malfunctioning_pylon = "Malfunctioning Pylon"
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
		-- Explosive Bomberbot
		462826, -- Self Destruct
		-- Malfunctioning Pylon
		462892, -- Hazardous Beam
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
		[462826] = L.explosive_bomberbot,
		[462892] = L.malfunctioning_pylon,
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
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "npc", "softfriend")
	self:RegisterWidgetEvent(5573, "Waves")
	self:Death("MobDeath", 229691, 229695, 229769, 229729) -- 229778 is covered in :AutomaticIronstriderDeath
	self:Log("SPELL_CAST_SUCCESS", "MobDeath", 288774, 462826) -- Shutdown, Self Destruct

	-- Corrupted Machinist
	self:Log("SPELL_CAST_START", "PurgingFlames", 462802)

	-- Explosive Bomberbot
	self:Log("SPELL_CAST_START", "SelfDestruct", 462826)

	-- Malfunctioning Pylon
	self:Log("SPELL_CAST_START", "HazardousBeam", 462892)

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

do
	local prev
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, castGUID, spellId)
		if castGUID ~= prev and spellId == 433923 then -- [DNT] Kuldas Machine Speaker Ritual - Cosmetic Channel
			prev = castGUID
			local stage = self:GetStage()
			if stage < 1 then
				stage = 0
			end
			self:Bar("stages", 10, CL.wave:format(stage + 1), L.stages_icon)
		end
	end
end

do
	local waveStart = 0

	function mod:Waves(_, text)
		waveStart = GetTime()
		mobsKilled = 0
		-- [UPDATE_UI_WIDGET] widgetID:5573, widgetType:8, text:Wave 20
		local wave = tonumber(text:match("%d+"))
		if wave and wave ~= 0 then -- widget is reset to 0 once you kill the Awakened Phalanx
			self:StopBar(CL.wave:format(wave))
			self:SetStage(wave)
			self:Message("stages", "cyan", CL.wave_count:format(wave, 20), L.stages_icon)
			self:PlaySound("stages", "info")
		end
	end

	function mod:Intermission()
		self:Message("stages", "green", CL.intermission, L.stages_icon)
		self:PlaySound("stages", "info")
	end

	function mod:MobDeath()
		mobsKilled = mobsKilled + 1
		local stage = self:GetStage()
		if mobsKilled == mobsNeeded[stage] then
			-- the next wave check is a repeating 10s timer based on the wave start. there is a 2s minimum duration
			-- between killing the last mob and starting the next wave, so the bar will range from 2-12s.
			local nextWave = 12 - (GetTime() - waveStart + 2) % 10
			if stage % 5 == 0 then
				self:Bar("stages", nextWave, CL.intermission, L.stages_icon)
				self:ScheduleTimer("Intermission", nextWave)
			else
				self:Bar("stages", nextWave, CL.wave:format(stage + 1), L.stages_icon)
			end
		end
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

-- Malfunctioning Pylon

function mod:HazardousBeam(args)
	self:Message(args.spellId, "yellow", CL.beam)
	self:PlaySound(args.spellId, "alert")
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
	self:MobDeath()
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
