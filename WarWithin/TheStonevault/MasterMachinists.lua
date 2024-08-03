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
	self:Log("SPELL_CAST_SUCCESS", "SilencedSpeaker", 439577)

	-- Speaker Brokk
	self:Log("SPELL_CAST_START", "ExhaustVents", 445541)
	self:Log("SPELL_CAST_START", "MoltenMetal", 430097)
	self:Log("SPELL_CAST_START", "ScrapSong", 428202)

	-- Speaker Dorlita
	self:Log("SPELL_CAST_SUCCESS", "BlazingCrescendo", 428508)
	self:Log("SPELL_CAST_START", "IgneousHammer", 428711)
	self:Log("SPELL_CAST_START", "LavaCannon", 449167)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(430097, 4.5) -- Molten Metal
	self:CDBar(428711, 6.9) -- Igneous Hammer
	self:CDBar(445541, 9.3) -- Exhaust Vents
	self:CDBar(449167, 13.0) -- Lava Cannon
	self:CDBar(428202, 19.1) -- Scrap Song
	self:CDBar(428508, 45.7) -- Blazing Crescendo
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:SilencedSpeaker(args)
	-- this is cast by the defeated boss on the remaining boss
	if self:MobId(args.sourceGUID) == 213217 then -- Speaker Brokk defeated
		self:StopBar(445541) -- Exhaust Vents
		self:StopBar(430097) -- Molten Metal
		self:StopBar(428202) -- Scrap Song
	else -- Speaker Dorlita defeated
		self:StopBar(428508) -- Blazing Crescendo
		self:StopBar(428711) -- Igneous Hammer
		self:StopBar(449167) -- Lava Cannon
	end
	self:SetStage(2)
	self:Message(args.spellId, "cyan", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end

-- Speaker Brokk

function mod:ExhaustVents(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 15.8) -- TODO often delayed
end

function mod:MoltenMetal(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 8.5) -- TODO often delayed
end

function mod:ScrapSong(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 52.1)
end

-- Speaker Dorlita

function mod:BlazingCrescendo(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 52.1)
end

function mod:IgneousHammer(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 12.1)
end

function mod:LavaCannon(args)
	-- doesn't seem possible to determine the target
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 17.0)
end
