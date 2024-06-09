if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Blazikon", 2651, 2559)
if not mod then return end
mod:RegisterEnableMob(208743) -- Blazikon
mod:SetEncounterID(2826)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		421817, -- Wicklighter Barrage
		424212, -- Incite Flames
		423109, -- Enkindling Inferno
		-- TODO Blazing Storms no one in melee range
		425394, -- Dousing Breath (Normal / Heroic)
		-- TODO Extinguishing Gust (Mythic)
	}, {
		[425394] = CL.normal.." / "..CL.heroic,
		--[] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "WicklighterBarrage", 421817)
	self:Log("SPELL_CAST_START", "InciteFlames", 424212)
	self:Log("SPELL_CAST_START", "EnkindlingInferno", 423109)
	self:Log("SPELL_CAST_START", "DousingBreath", 425394)
end

function mod:OnEngage()
	self:CDBar(425394, 3.4) -- Dousing Breath
	self:CDBar(421817, 9.5) -- Wicklighter Barrage
	self:CDBar(424212, 21.6) -- Incite Flames
	self:CDBar(423109, 30.1) -- Enkindling Inferno
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:WicklighterBarrage(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 31.6)
end

function mod:InciteFlames(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 31.6)
end

function mod:EnkindlingInferno(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 31.6)
end

function mod:DousingBreath(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 31.6)
end
