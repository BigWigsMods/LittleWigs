--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Blazikon", 2651, 2559)
if not mod then return end
mod:RegisterEnableMob(208743) -- Blazikon
mod:SetEncounterID(2826)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	423080, -- Extinguishing Gust
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		421817, -- Wicklighter Barrage
		424212, -- Incite Flames
		423109, -- Enkindling Inferno
		443835, -- Blazing Storms
		425394, -- Dousing Breath (Normal / Heroic)
		{422700, "PRIVATE"}, -- Extinguishing Gust (Mythic)
	}, {
		[425394] = CL.normal.." / "..CL.heroic,
		[422700] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "WicklighterBarrage", 421817)
	self:Log("SPELL_AURA_APPLIED", "WicklighterBarrageApplied", 421817)
	self:Log("SPELL_CAST_START", "InciteFlames", 424212)
	self:Log("SPELL_CAST_START", "EnkindlingInferno", 423109)
	self:Log("SPELL_CAST_START", "BlazingStorms", 443835)
	self:Log("SPELL_CAST_START", "DousingBreath", 425394)

	-- Mythic
	self:Log("SPELL_CAST_SUCCESS", "ExtinguishingGust", 422700) -- TODO what's the best event?
end

function mod:OnEngage()
	if self:Mythic() then
		-- TODO real timer
		self:CDBar(425394, 3.4) -- Extinguishing Gust
	else
		self:CDBar(425394, 3.4) -- Dousing Breath
	end
	self:CDBar(421817, 9.5) -- Wicklighter Barrage
	self:CDBar(424212, 21.6) -- Incite Flames
	self:CDBar(423109, 30.1) -- Enkindling Inferno
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local playerList = {}

	function mod:WicklighterBarrage(args)
		playerList = {}
		self:Message(args.spellId, "yellow", CL.incoming:format(args.spellName))
		self:CDBar(args.spellId, 31.6)
	end

	function mod:WicklighterBarrageApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "yellow", playerList, 3)
		self:PlaySound(args.spellId, "long", nil, playerList)
	end
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

function mod:BlazingStorms(args)
	-- only cast when no one is in melee range
	self:Message(args.spellId, "purple")
	if self:Tank() then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:DousingBreath(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 31.6)
end

-- Mythic

function mod:ExtinguishingGust(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 31.6) -- TODO guessed
end
