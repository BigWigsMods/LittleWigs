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
		425394, -- Dousing Breath
		443835, -- Blazing Storms
		{421910, "PRIVATE"}, -- Extinguishing Gust (Mythic)
	}, {
		[421910] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "WicklighterBarrage", 421817)
	self:Log("SPELL_AURA_APPLIED", "WicklighterBarrageApplied", 421817)
	self:Log("SPELL_CAST_START", "InciteFlames", 424212)
	self:Log("SPELL_PERIODIC_DAMAGE", "InciteFlamesDamage", 424223)
	self:Log("SPELL_PERIODIC_MISSED", "InciteFlamesDamage", 424223)
	self:Log("SPELL_CAST_START", "EnkindlingInferno", 423109)
	self:Log("SPELL_CAST_START", "DousingBreath", 425394)
	self:Log("SPELL_CAST_START", "BlazingStorms", 443835)

	-- Mythic
	self:Log("SPELL_CAST_START", "ExtinguishingGust", 421910)
end

function mod:OnEngage()
	if self:Mythic() then
		self:CDBar(425394, 3.4) -- Dousing Breath
		self:CDBar(421817, 6.9) -- Wicklighter Barrage
		self:CDBar(423109, 20.7) -- Enkindling Inferno
		self:CDBar(421910, 25.5) -- Extinguishing Gust
		self:CDBar(424212, 37.7) -- Incite Flames
	else
		self:CDBar(425394, 3.4) -- Dousing Breath
		self:CDBar(421817, 9.5) -- Wicklighter Barrage
		self:CDBar(424212, 21.6) -- Incite Flames
		self:CDBar(423109, 30.1) -- Enkindling Inferno
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local playerList = {}

	function mod:WicklighterBarrage(args)
		playerList = {}
		self:Message(args.spellId, "yellow", CL.incoming:format(args.spellName))
		if self:Mythic() then
			self:CDBar(args.spellId, 60.0)
		else
			self:CDBar(args.spellId, 30.0)
		end
	end

	function mod:WicklighterBarrageApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "yellow", playerList, 3)
		self:PlaySound(args.spellId, "long", nil, playerList)
	end
end

function mod:InciteFlames(args)
	self:Message(args.spellId, "orange")
	if self:Mythic() then
		self:CDBar(args.spellId, 60.7)
	else
		self:CDBar(args.spellId, 31.6)
	end
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:InciteFlamesDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PersonalMessage(424212, "underyou")
			self:PlaySound(424212, "underyou")
		end
	end
end

function mod:EnkindlingInferno(args)
	self:Message(args.spellId, "red")
	if self:Mythic() then
		self:CDBar(args.spellId, 29.1)
	else
		self:CDBar(args.spellId, 31.6)
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:DousingBreath(args)
	self:Message(args.spellId, "cyan")
	if self:Mythic() then
		self:CDBar(args.spellId, 55.8)
	else
		self:CDBar(args.spellId, 31.6)
	end
	self:PlaySound(args.spellId, "info")
end

function mod:BlazingStorms(args)
	-- only cast when no one is in melee range
	self:Message(args.spellId, "purple")
	if self:Tank() then
		self:PlaySound(args.spellId, "warning")
	end
end

-- Mythic

function mod:ExtinguishingGust(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 59.5)
	self:PlaySound(args.spellId, "info")
end
