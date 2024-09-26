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
local blazingCrescendoCount = 1
local nextExhaustVents = 0
local lastExhaustVentsCd = 0
local nextMoltenMetal = 0
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
	self:Log("SPELL_CAST_SUCCESS", "ExhaustVents", 445541)
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
	blazingCrescendoCount = 1
	self:SetStage(1)
	if self:Mythic() then
		nextMoltenMetal = t + 4.6
		self:CDBar(430097, 4.6) -- Molten Metal
		nextIgneousHammer = t + 6.1
		self:CDBar(428711, 6.1) -- Igneous Hammer
		nextLavaCannon = t + 12.2
		self:CDBar(449167, 12.2) -- Lava Cannon
		nextScrapSong = t + 15.5
		self:CDBar(428202, 15.5) -- Scrap Song
		nextExhaustVents = t + 34.1
		lastExhaustVentsCd = 34.1
		self:CDBar(445541, 34.1, CL.count:format(self:SpellName(445541), exhaustVentsCount)) -- Exhaust Vents
		nextBlazingCrescendo = t + 45.0
		self:CDBar(428508, 45.0, CL.count:format(self:SpellName(428508), blazingCrescendoCount)) -- Blazing Crescendo
	else -- Normal, Heroic
		nextMoltenMetal = t + 3.2
		self:CDBar(430097, 3.2) -- Molten Metal
		nextExhaustVents = t + 5.7
		lastExhaustVentsCd = 5.7
		self:CDBar(445541, 5.7, CL.count:format(self:SpellName(445541), exhaustVentsCount)) -- Exhaust Vents
		nextIgneousHammer = t + 6.1
		self:CDBar(428711, 6.1) -- Igneous Hammer
		nextLavaCannon = t + 12.2
		self:CDBar(449167, 12.2) -- Lava Cannon
		nextScrapSong = t + 15.5
		self:CDBar(428202, 15.5) -- Scrap Song
		nextBlazingCrescendo = t + 45.7
		self:CDBar(428508, 45.7, CL.count:format(self:SpellName(428508), blazingCrescendoCount)) -- Blazing Crescendo
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:SilencedSpeaker(args)
	local t = GetTime()
	-- neither boss casts their "ultimate" anymore once one boss is defeated
	self:StopBar(428202) -- Scrap Song
	self:StopBar(CL.count:format(self:SpellName(428508), blazingCrescendoCount)) -- Blazing Crescendo
	-- this is cast by the defeated boss on the remaining boss
	if self:MobId(args.sourceGUID) == 213217 then -- Speaker Brokk defeated
		self:StopBar(CL.count:format(self:SpellName(445541), exhaustVentsCount)) -- Exhaust Vents
		self:StopBar(430097) -- Molten Metal
	else -- Speaker Dorlita defeated
		self:StopBar(428711) -- Igneous Hammer
		self:StopBar(449167) -- Lava Cannon
		-- cooldowns are reset on Speaker Brokk's abilities if Speaker Dorlita is defeated
		nextMoltenMetal = t + 2.8
		self:CDBar(430097, {2.8, 15.8}) -- Molten Metal
		nextExhaustVents = t + 5.2
		lastExhaustVentsCd = 27.9
		self:CDBar(445541, {5.2, 27.9}, CL.count:format(self:SpellName(445541), exhaustVentsCount)) -- Exhaust Vents
	end
	self:SetStage(2)
	self:Message(args.spellId, "cyan", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end

-- Speaker Brokk

function mod:ExhaustVents(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, exhaustVentsCount))
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, exhaustVentsCount))
	exhaustVentsCount = exhaustVentsCount + 1
	-- Exhaust Vents cooldown is set to a shorter duration by Blazing Crescendo
	nextExhaustVents = t + 27.9
	lastExhaustVentsCd = 27.9
	self:CDBar(args.spellId, 27.9, CL.count:format(args.spellName, exhaustVentsCount))
	-- 3.61 to Molten Metal
	if nextMoltenMetal - t < 3.61 then
		nextMoltenMetal = t + 3.61
		self:CDBar(430097, {3.61, 15.8}) -- Molten Metal
	end
	-- 7.27 to Scrap Song
	if self:GetStage() == 1 and nextScrapSong - t < 7.27 then
		nextScrapSong = t + 7.27
		self:CDBar(428202, {7.27, 51.9}) -- Scrap Song
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:MoltenMetal(args)
	local t = GetTime()
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	-- Molten Metal cooldown is set to a shorter duration after Scrap Song and Silenced Speaker
	nextMoltenMetal = t + 15.8
	self:CDBar(args.spellId, 15.8)
	-- 2.43 minimum to next ability
	if nextExhaustVents - t < 2.43 then
		nextExhaustVents = t + 2.43
		self:CDBar(445541, {2.43, lastExhaustVentsCd}, CL.count:format(self:SpellName(445541), exhaustVentsCount)) -- Exhaust Vents
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
		self:CDBar(445541, {3.0, lastExhaustVentsCd}, CL.count:format(self:SpellName(445541), exhaustVentsCount)) -- Exhaust Vents
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
	nextMoltenMetal = t + 7.26
	self:CDBar(430097, {7.26, 15.8}) -- Molten Metal
	nextScrapSong = t + 51.9
	self:CDBar(args.spellId, 51.9)
	self:PlaySound(args.spellId, "long")
end

-- Speaker Dorlita

function mod:BlazingCrescendo(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, blazingCrescendoCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, blazingCrescendoCount))
	blazingCrescendoCount = blazingCrescendoCount + 1
	-- resets the cooldown of Exhaust Vents to 17.0
	nextExhaustVents = t + 17.0
	self:CDBar(445541, {17.0, lastExhaustVentsCd}, CL.count:format(self:SpellName(445541), exhaustVentsCount)) -- Exhaust Vents
	-- resets the cooldown of Igneous Hammer to 13.34
	nextIgneousHammer = t + 13.34
	self:CDBar(428711, 13.34) -- Igneous Hammer
	-- resets the cooldown of Lava Cannon to 19.4
	nextLavaCannon = t + 19.4
	self:CDBar(449167, 19.4) -- Lava Cannon
	nextBlazingCrescendo = t + 52.1
	self:CDBar(args.spellId, 52.1, CL.count:format(args.spellName, blazingCrescendoCount))
	self:PlaySound(args.spellId, "alarm")
end

function mod:IgneousHammer(args)
	local t = GetTime()
	self:Message(args.spellId, "purple")
	-- cooldown reset by Blazing Crescendo
	nextIgneousHammer = t + 12.1
	self:CDBar(args.spellId, 12.1)
	-- 2.43 minimum to next ability
	if nextLavaCannon - t < 2.43 then
		nextLavaCannon = t + 2.43
		self:CDBar(449167, {2.43, 17.0}) -- Lava Cannon
	end
	if self:GetStage() == 1 and nextBlazingCrescendo - t < 2.43 then
		nextBlazingCrescendo = t + 2.43
		self:CDBar(428508, {2.43, 52.1}, CL.count:format(self:SpellName(428508), blazingCrescendoCount)) -- Blazing Crescendo
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:LavaCannon(args)
	local t = GetTime()
	self:Message(args.spellId, "orange")
	-- cooldown reset by Blazing Crescendo
	nextLavaCannon = t + 17.0
	self:CDBar(args.spellId, 17.0)
	-- 3.5 minimum to next ability
	if nextIgneousHammer - t < 3.5 then
		nextIgneousHammer = t + 3.5
		self:CDBar(428711, {3.5, 12.1}) -- Igneous Hammer
	end
	if self:GetStage() == 1 and nextBlazingCrescendo - t < 3.5 then
		nextBlazingCrescendo = t + 3.5
		self:CDBar(428508, {3.5, 52.1}, CL.count:format(self:SpellName(428508), blazingCrescendoCount)) -- Blazing Crescendo
	end
	self:PlaySound(args.spellId, "alarm")
end
