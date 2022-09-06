--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ingra Maloch", 2290, 2400)
if not mod then return end
mod:RegisterEnableMob(164567, 164804) -- Ingra Maloch, Droman Oulfarran
mod:SetEncounterID(2397)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		323137, -- Bewildering Pollen
		323177, -- Tears of the Forest
		323250, -- Anima Puddle
		323059, -- Droman's Wrath
		323057, -- Spirit Bolt
		328756, -- Repulsive Visage
		323149, -- Embrace Darkness
	},{
		[323137] = -21653, -- Droman Oulfarran
		[323057] = mod.displayName, -- Ingra Maloch
	},{
		[328756] = CL.fear, -- Repulsive Visage (Fear)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SpiritBolt", 323057)
	self:Log("SPELL_CAST_START", "RepulsiveVisage", 328756)
	self:Log("SPELL_CAST_START", "EmbraceDarkness", 323149)
	self:Log("SPELL_CAST_START", "BewilderingPollen", 323137)
	self:Log("SPELL_CAST_SUCCESS", "TearsoftheForest", 323177)
	self:Log("SPELL_PERIODIC_DAMAGE", "AnimaPuddle", 323250)
	self:Log("SPELL_PERIODIC_MISSED", "AnimaPuddle", 323250)
	self:Log("SPELL_CAST_START", "DromansWrath", 323059)
	self:Log("SPELL_AURA_APPLIED", "DromansWrathApplied", 323059)
	self:Log("SPELL_AURA_REMOVED", "DromansWrathRemoved", 323059)
	self:Log("SPELL_AURA_APPLIED", "SoulShackleApplied", 321006)
end

function mod:OnEngage()
	self:CDBar(323137, 7) -- Bewildering Pollen
	self:CDBar(323177, 15) -- Tears of the Forest
	if self:Mythic() then
		self:Bar(328756, 26.5, CL.fear) -- Repulsive Visage
	end
	self:CDBar(323149, 30.5) -- Embrace Darkness
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SpiritBolt(args)
	local canDo, ready = self:Interrupter()
	if canDo then
		self:Message(args.spellId, "orange")
		if ready then
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:RepulsiveVisage(args)
	self:Message(args.spellId, "orange", CL.casting:format(CL.fear))
	self:PlaySound(args.spellId, "warning")
end

function mod:EmbraceDarkness(args)
	self:StopBar(args.spellId)
	self:Message(args.spellId, "orange")
end

function mod:BewilderingPollen(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 18)
end

function mod:TearsoftheForest(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:Bar(args.spellId, 15)
end

do
	local prev = 0
	function mod:AnimaPuddle(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

function mod:DromansWrath(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "long")
end

function mod:DromansWrathApplied(args)
	self:StopBar(323137) -- Bewildering Pollen
	self:StopBar(323177) -- Tears of the Forest
	self:StopBar(328756) -- Repulsive Visage
	self:StopBar(323149) -- Embrace Darkness
	self:Bar(args.spellId, 15)
end

function mod:DromansWrathRemoved(args)
	self:Message(args.spellId, "red", CL.removed:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:SoulShackleApplied()
	-- Soul Shackle is also applied on respawn, so only create timers if the boss is engaged
	if self:IsEngaged() then
		self:CDBar(323137, 7.8) -- Bewildering Pollen
		self:CDBar(323177, 18.5) -- Tears of the Forest
		if self:Mythic() then
			self:CDBar(328756, 26.5, CL.fear) -- Repulsive Visage
		end
		self:CDBar(323149, 30) -- Embrace Darkness
	end
end
