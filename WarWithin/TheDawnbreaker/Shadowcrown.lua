if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Shadowcrown", 2662, 2580)
if not mod then return end
mod:RegisterEnableMob(211087) -- Speaker Shadowcrown
mod:SetEncounterID(2837)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

local darknessComesCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{451026, "CASTBAR"}, -- Darkness Comes
		{426735, "DISPEL"}, -- Burning Shadows
		-- Normal / Heroic
		425264, -- Obsidian Blast
		445996, -- Collapsing Darkness
		-- Mythic
		453212, -- Obsidian Beam
		453140, -- Collapsing Night
	}, {
		[425264] = CL.normal.." / "..CL.heroic,
		[453212] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DarknessComes", 451026)
	self:Log("SPELL_AURA_APPLIED", "BurningShadowsApplied", 426735)

	-- Normal / Heroic
	self:Log("SPELL_CAST_START", "ObsidianBlast", 425264)
	self:Log("SPELL_CAST_START", "CollapsingDarkness", 445996)

	-- Mythic
	self:Log("SPELL_CAST_START", "ObsidianBeam", 453212)
	self:Log("SPELL_CAST_START", "CollapsingNight", 453140)
end

function mod:OnEngage()
	darknessComesCount = 1
	if self:Mythic() then
		-- TODO verify timers
		self:CDBar(453212, 6.1) -- Obsidian Beam
		self:CDBar(426735, 11.4) -- Burning Shadows
		self:CDBar(453140, 12.9) -- Collapsing Night
	else -- Normal, Heroic
		self:CDBar(425264, 6.1) -- Obsidian Blast
		self:CDBar(426735, 11.4) -- Burning Shadows
		self:CDBar(445996, 12.9) -- Collapsing Darkness
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DarknessComes(args)
	local percent
	if darknessComesCount == 1 then
		darknessComesCount = darknessComesCount + 1
		percent = 50
		if self:Mythic() then
			-- TODO verify timers
			self:CDBar(453212, 21.6) -- Obsidian Beam
			self:CDBar(426735, 26.3) -- Burning Shadows
			self:CDBar(453140, 27.5) -- Collapsing Night
		else -- Normal, Heroic
			self:CDBar(425264, 21.6) -- Obsidian Blast
			self:CDBar(426735, 26.3) -- Burning Shadows
			self:CDBar(445996, 27.5) -- Collapsing Darkness
		end
	else
		percent = 0
		self:StopBar(426735) -- Burning Shadows
		if self:Mythic() then
			self:StopBar(453212) -- Obsidian Beam
			self:StopBar(453140) -- Collapsing Night
		else -- Normal, Heroic
			self:StopBar(425264) -- Obsidian Blast
			self:StopBar(445996) -- Collapsing Darkness
		end
	end
	self:Message(args.spellId, "cyan", CL.percent:format(percent, args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 15)
end

function mod:BurningShadowsApplied(args)
	-- TODO this snares, but isn't dispelled by movement dispelling effects (bug)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
	self:CDBar(args.spellId, 19.1)
end

-- Normal / Heroic

function mod:ObsidianBlast(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 11.6)
end

function mod:CollapsingDarkness(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 14.7)
end

-- Mythic

function mod:ObsidianBeam(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	-- TODO verify timer
	self:CDBar(args.spellId, 11.6)
end

function mod:CollapsingNight(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	-- TODO verify timer
	self:CDBar(args.spellId, 14.7)
end
