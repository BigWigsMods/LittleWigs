
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ingra Maloch", 2290, 2400)
if not mod then return end
mod:RegisterEnableMob(164567, 164804) -- Ingra Maloch, Droman Oulfarran
mod.engageId = 2397
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		323057, -- Spirit Bolt
		328756, -- Repulsive Visage
		323149, -- Embrace Darkness
		323137, -- Bewildering Pollen
		323177, -- Tears of the Forest
		323059, -- Droman's Wrath
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SpiritBolt", 323057)
	self:Log("SPELL_CAST_START", "RepulsiveVisage", 328756)
	self:Log("SPELL_CAST_START", "EmbraceDarkness", 323149)
	self:Log("SPELL_CAST_START", "BewilderingPollen", 323137)
	self:Log("SPELL_CAST_SUCCESS", "TearsoftheForest", 323177)
	self:Log("SPELL_CAST_START", "DromansWrath", 323059)
	self:Log("SPELL_AURA_APPLIED", "DromansWrathApplied", 323059)
	self:Log("SPELL_AURA_REMOVED", "DromansWrathRemoved", 323059)
end

function mod:OnEngage()
	self:Bar(323137, 4.5) -- Bewildering Pollen
	self:Bar(323177, 10.5) -- Tears of the Forest
	self:Bar(328756, 26.5) -- Repulsive Visage
	self:Bar(328756, 30) -- Embrace Darkness
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SpiritBolt(args)
	if self:Interrupter() then
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:RepulsiveVisage(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

function mod:EmbraceDarkness(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

function mod:BewilderingPollen(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 30)
end

function mod:TearsoftheForest(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 15)
end

function mod:DromansWrath(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "long")
end

function mod:DromansWrathApplied(args)
	self:StopBar(323137) -- Bewildering Pollen
	self:StopBar(323177) -- Tears of the Forest
	self:Bar(args.spellId, 12)
end

function mod:DromansWrathRemoved(args)
	self:Message(args.spellId, "cyan", CL.removed:format(args.spellName))
	self:PlaySound(args.spellId, "info")
	self:Bar(323137, 9) -- Bewildering Pollen
	self:Bar(323177, 18.4) -- Tears of the Forest
	self:Bar(328756, 26.5) -- Repulsive Visage XXX Estimated
	self:Bar(323149, 36) -- Embrace Darkness
end
