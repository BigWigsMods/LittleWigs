if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Anub'ikkaj", 2662, 2581)
if not mod then return end
mod:RegisterEnableMob(211089) -- Anub'ikkaj
mod:SetEncounterID(2838)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		427001, -- Terrifying Slam
		426860, -- Dark Orb
		426787, -- Shadowy Decay
		-- Mythic
		452127, -- Animate Shadows
	}, {
		[452127] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "TerrifyingSlam", 427001)
	self:Log("SPELL_CAST_START", "DarkOrb", 426860)
	self:Log("SPELL_CAST_START", "ShadowyDecay", 426787)
	-- TODO private aura sound on Dark Orb 426865?
	-- or else the emote started showing targeted player in 55087, possibly unintentional

	-- Mythic
	self:Log("SPELL_CAST_START", "AnimateShadows", 452127)
end

function mod:OnEngage()
	self:CDBar(426860, 6.0) -- Dark Orb
	self:CDBar(427001, 15.0) -- Terrifying Slam
	self:CDBar(426787, 22.0) -- Shadowy Decay
	if self:Mythic() then
		--TODO self:CDBar(452127, 20.0) -- Animate Shadows
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TerrifyingSlam(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	-- TODO almost always 26s, but once it was 16s - why?
	self:CDBar(args.spellId, 26.0)
end

function mod:DarkOrb(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	-- TODO almost always 26s, but once it was 16s - why?
	self:CDBar(args.spellId, 26.0)
end

function mod:ShadowyDecay(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 26.0)
end

-- Mythic

function mod:AnimateShadows(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	--self:CDBar(args.spellId, 26.0) TODO
end
