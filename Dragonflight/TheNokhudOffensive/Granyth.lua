--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Granyth", 2516, 2498)
if not mod then return end
mod:RegisterEnableMob(186616) -- Granyth
mod:SetEncounterID(2637)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.lance_ready = "Lance Ready"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Granyth
		388283, -- Eruption
		388817, -- Shards of Stone
		385916, -- Tectonic Stomp
		-- Dragonkiller Lance
		386530, -- Dragonkiller Lance
		-- Nokhud Saboteur
		386490, -- Dismantle
	}, {
		[388283] = -25455, -- Granyth
		[386530] = -25614, -- Dragonkiller Lance
		[386490] = -25612, -- Nokhud Saboteur
	}
end

function mod:OnBossEnable()
	-- Granyth
	self:Log("SPELL_CAST_START", "Eruption", 388283)
	self:Log("SPELL_CAST_START", "ShardsOfStone", 388817)
	self:Log("SPELL_CAST_START", "TectonicStomp", 385916)

	-- Dragonkiller Lance
	self:Log("SPELL_CAST_START", "Reload", 386921)
	self:Log("SPELL_CAST_SUCCESS", "ReloadSuccess", 386921)
	self:Log("SPELL_AURA_APPLIED", "Lanced", 387155)
	
	-- Nokhud Saboteur (Mythic-only)
	-- TODO summon/activate saboteur?
	self:Log("SPELL_AURA_APPLIED", "Dismantle", 386490)
end

function mod:OnEngage()
	self:CDBar(388283, 28.9) -- Eruption
	self:CDBar(388817, 10.6) -- Shards of Stone
	self:CDBar(385916, 15.5) -- Tectonic Stomp
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Granyth

function mod:Eruption(args)
	self:StopBar(args.spellId)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	self:CastBar(args.spellId, 6)
end

function mod:ShardsOfStone(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 13.4)
end

function mod:TectonicStomp(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 19.4)
end

-- Dragonkiller Lance

function mod:Reload(args)
	self:Bar(386530, 25, args.spellName) -- Dragonkiller Lance
end

function mod:ReloadSuccess(args)
	self:Message(386530, "green", L.lance_ready) -- Dragonkiller Lance
	self:PlaySound(386530, "info") -- Dragonkiller Lance
end

function mod:Lanced(args)
	self:Message(386530, "green", args.spellName) -- Dragonkiller Lance
	self:PlaySound(386530, "info") -- Dragonkiller Lance
	self:StopBar(CL.cast:format(self:SpellName(388283))) -- Eruption
	self:CDBar(388283, 35) -- Eruption TODO 25s energy gain, 10s delay?
end

-- Nokhud Saboteur

function mod:Dismantle(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end
