if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Forge Speakers", 2652, 2590)
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
		445541, -- Activate Ventilation
		430097, -- Molten Metal
		428202, -- Scrap Song
		-- Speaker Dorlita
		428508, -- Deconstruction
		{428711, "TANK"}, -- Molten Hammer
		449167, -- Lava Expulsion
	}, {
		[445541] = -28459, -- Speaker Brokk
		[428508] = -28461, -- Speaker Dorlita
	}
end

function mod:OnBossEnable()
	-- Stages
	self:Log("SPELL_CAST_SUCCESS", "SilencedSpeaker", 439577)

	-- Speaker Brokk
	self:Log("SPELL_CAST_START", "ActivateVentilation", 445541)
	self:Log("SPELL_CAST_START", "MoltenMetal", 430097)
	self:Log("SPELL_CAST_START", "ScrapSong", 428202)

	-- Speaker Dorlita
	self:Log("SPELL_CAST_SUCCESS", "Deconstruction", 428508)
	self:Log("SPELL_CAST_START", "MoltenHammer", 428711)
	self:Log("SPELL_CAST_START", "LavaExpulsion", 449167)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(430097, 4.5) -- Molten Metal
	self:CDBar(428711, 6.9) -- Molten Hammer
	self:CDBar(445541, 9.3) -- Activate Ventilation
	self:CDBar(449167, 13.0) -- Lava Expulsion
	self:CDBar(428202, 19.1) -- Scrap Song
	self:CDBar(428508, 45.7) -- Deconstruction
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:SilencedSpeaker(args)
	-- this is cast by the defeated boss on the remaining boss
	if self:MobId(args.sourceGUID) == 213217 then -- Speaker Brokk defeated
		self:StopBar(445541) -- Activate Ventilation
		self:StopBar(430097) -- Molten Metal
		self:StopBar(428202) -- Scrap Song
	else -- Speaker Dorlita defeated
		self:StopBar(428508) -- Deconstruction
		self:StopBar(428711) -- Molten Hammer
		self:StopBar(449167) -- Lava Expulsion
	end
	self:SetStage(2)
	self:Message(args.spellId, "cyan", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end

-- Speaker Brokk

function mod:ActivateVentilation(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 34.0)
end

function mod:MoltenMetal(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 9.7)
end

function mod:ScrapSong(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 49.6)
end

-- Speaker Dorlita

function mod:Deconstruction(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 46.1)
end

function mod:MoltenHammer(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 12.1)
end

function mod:LavaExpulsion(args)
	-- doesn't seem possible to determine the target
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 17.0)
end
