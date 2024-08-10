if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Master Machinists", 2652, 2590)
if not mod then return end
mod:RegisterEnableMob(
	213217, -- Speaker Brokk
	213216 -- Speaker Dorlita
)
mod:SetEncounterID(2888)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local exhaustVentsCount = 1
local nextExhaustVents = 0
local lastExhaustVentsCd = 0
local nextScrapSong = 0
local nextIgneousHammer = 0
local nextLavaCannon = 0
local nextBlazingCrescendo = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		439577, -- Silenced Speaker
		-- Speaker Brokk
		445541, -- Exhaust Vents
		430097, -- Molten Metal
		428202, -- Scrap Song
		-- Speaker Dorlita
		428508, -- Blazing Crescendo
		{428711, "TANK"}, -- Igneous Hammer
		449167, -- Lava Cannon
	}, {
		[445541] = -28459, -- Speaker Brokk
		[428508] = -28461, -- Speaker Dorlita
	}
end

function mod:OnBossEnable()
	-- Stages
	self:Log("SPELL_AURA_APPLIED", "SilencedSpeaker", 439577)

	-- Speaker Brokk
	self:Log("SPELL_CAST_START", "ExhaustVents", 445541)
	self:Log("SPELL_CAST_START", "MoltenMetal", 430097)
	self:Log("SPELL_INTERRUPT", "MoltenMetalInterrupt", 430097)
	self:Log("SPELL_CAST_START", "ScrapSong", 428202)

	-- Speaker Dorlita
	self:Log("SPELL_CAST_SUCCESS", "BlazingCrescendo", 428508)
	self:Log("SPELL_CAST_START", "IgneousHammer", 428711)
	self:Log("SPELL_CAST_START", "LavaCannon", 449167)
end

function mod:OnEngage()
	local t = GetTime()
	exhaustVentsCount = 1
	self:SetStage(1)
	self:CDBar(430097, 3.2) -- Molten Metal
	nextExhaustVents = t + 5.7
	lastExhaustVentsCd = 5.7
	self:CDBar(445541, 5.7) -- Exhaust Vents
	nextIgneousHammer = t + 6.1
	self:CDBar(428711, 6.1) -- Igneous Hammer
	nextLavaCannon = t + 12.2
	self:CDBar(449167, 12.2) -- Lava Cannon
	nextScrapSong = t + 15.5
	self:CDBar(428202, 15.5) -- Scrap Song
	nextBlazingCrescendo = t + 45.7
	self:CDBar(428508, 45.7) -- Blazing Crescendo
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:SilencedSpeaker(args)
	local t = GetTime()
	-- neither boss casts their "ultimate" anymore once one boss is defeated
	self:StopBar(428202) -- Scrap Song
	self:StopBar(428508) -- Blazing Crescendo
	-- this is cast by the defeated boss on the remaining boss
	if self:MobId(args.sourceGUID) == 213217 then -- Speaker Brokk defeated
		self:StopBar(445541) -- Exhaust Vents
		self:StopBar(430097) -- Molten Metal
	else -- Speaker Dorlita defeated
		self:StopBar(428711) -- Igneous Hammer
		self:StopBar(449167) -- Lava Cannon
		-- cooldowns are reset on Speaker Brokk's abilities if Speaker Dorlita is defeated
		self:CDBar(430097, {2.8, 13.4}) -- Molten Metal
		nextExhaustVents = t + 5.2
		lastExhaustVentsCd = 34.0
		self:CDBar(445541, {5.2, 34.0}) -- Exhaust Vents
	end
	self:SetStage(2)
	self:Message(args.spellId, "cyan", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end

-- Speaker Brokk

function mod:ExhaustVents(args)
	local t = GetTime()
	self:Message(args.spellId, "orange")
	exhaustVentsCount = exhaustVentsCount + 1
	if self:GetStage() == 1 then
		if exhaustVentsCount % 2 == 0 then
			nextExhaustVents = t + 34.0
			lastExhaustVentsCd = 34.0
			self:CDBar(args.spellId, 34.0)
		else
			nextExhaustVents = t + 15.8
			lastExhaustVentsCd = 15.8
			self:CDBar(args.spellId, 15.8)
		end
	else -- Stage 2
		nextExhaustVents = t + 34.0
		lastExhaustVentsCd = 34.0
		self:CDBar(args.spellId, 34.0)
	end
	-- 9.69 minimum to next ability
	self:CDBar(430097, {9.69, 13.4}) -- Molten Metal
	if self:GetStage() == 1 and nextScrapSong - t < 9.69 then
		nextScrapSong = t + 9.69
		self:CDBar(428202, {9.69, 51.9}) -- Scrap Song
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:MoltenMetal(args)
	local t = GetTime()
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	-- Molten Metal cooldown is set to a shorter duration after Scrap Song and Silenced Speaker
	self:CDBar(args.spellId, 13.4)
	-- 2.43 minimum to next ability
	if nextExhaustVents - t < 2.43 then
		nextExhaustVents = t + 2.43
		self:CDBar(445541, {2.43, lastExhaustVentsCd}) -- Exhaust Vents
	end
	if self:GetStage() == 1 and nextScrapSong - t < 2.43 then
		nextScrapSong = t + 2.43
		self:CDBar(428202, {2.43, 51.9}) -- Scrap Song
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:MoltenMetalInterrupt()
	-- 3s ability lockout applies to Speaker Brokk after being interrupted
	local t = GetTime()
	if nextExhaustVents - t < 3.0 then
		nextExhaustVents = t + 3.0
		self:CDBar(445541, {3.0, lastExhaustVentsCd}) -- Exhaust Vents
	end
	if self:GetStage() == 1 and nextScrapSong - t < 3.0 then
		nextScrapSong = t + 3.0
		self:CDBar(428202, {3.0, 51.9}) -- Scrap Song
	end
end

function mod:ScrapSong(args)
	local t = GetTime()
	self:Message(args.spellId, "yellow")
	-- resets the cooldown of Molten Metal to 7.26
	self:CDBar(430097, {7.26, 13.4}) -- Molten Metal
	-- resets the cooldown of Exhaust Vents to 17.0
	nextExhaustVents = t + 17.0
	if lastExhaustVentsCd >= 17.0 then
		self:CDBar(445541, {17.0, lastExhaustVentsCd}) -- Exhaust Vents
	else
		self:CDBar(445541, 17.0) -- Exhaust Vents
	end
	nextScrapSong = t + 51.9
	self:CDBar(args.spellId, 51.9)
	self:PlaySound(args.spellId, "long")
end

-- Speaker Dorlita

function mod:BlazingCrescendo(args)
	local t = GetTime()
	self:Message(args.spellId, "red")
	-- resets the cooldown of Exhaust Vents to 12.11
	nextExhaustVents = t + 12.11
	self:CDBar(445541, {12.11, lastExhaustVentsCd}) -- Exhaust Vents
	-- resets the cooldown of Igneous Hammer to 13.34
	nextIgneousHammer = t + 13.34
	self:CDBar(428711, 13.34) -- Igneous Hammer
	-- resets the cooldown of Lava Cannon to 19.02
	nextLavaCannon = t + 19.02
	self:CDBar(449167, 19.02) -- Lava Cannon
	nextBlazingCrescendo = t + 52.1
	self:CDBar(args.spellId, 52.1)
	self:PlaySound(args.spellId, "alarm")
end

function mod:IgneousHammer(args)
	local t = GetTime()
	self:Message(args.spellId, "purple")
	nextIgneousHammer = t + 12.1
	self:CDBar(args.spellId, 12.1)
	-- 2.43 minimum to next ability
	if nextLavaCannon - t < 2.43 then
		nextLavaCannon = t + 2.43
		self:CDBar(449167, {2.43, 16.2}) -- Lava Cannon
	end
	if self:GetStage() == 1 and nextBlazingCrescendo - t < 2.43 then
		nextBlazingCrescendo = t + 2.43
		self:CDBar(428508, {2.43, 52.1}) -- Blazing Crescendo
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:LavaCannon(args)
	local t = GetTime()
	self:Message(args.spellId, "orange")
	nextLavaCannon = t + 16.2
	self:CDBar(args.spellId, 16.2)
	-- 3.61 minimum to next ability
	if nextIgneousHammer - t < 3.61 then
		nextIgneousHammer = t + 3.61
		self:CDBar(428711, {3.61, 12.1}) -- Igneous Hammer
	end
	if self:GetStage() == 1 and nextBlazingCrescendo - t < 3.61 then
		nextBlazingCrescendo = t + 3.61
		self:CDBar(428508, {3.61, 52.1}) -- Blazing Crescendo
	end
	self:PlaySound(args.spellId, "alarm")
end
