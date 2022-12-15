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
	L.west = "W"
	L.northeast = "NE"
	L.southeast = "SE"
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
		386320, -- Summon Saboteur
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
	self:Log("SPELL_CAST_SUCCESS", "SummonSaboteur", 386320, 386747, 386748)

	-- Dragonkiller Lance
	self:Log("SPELL_CAST_START", "Reload", 386921)
	self:Log("SPELL_CAST_SUCCESS", "ReloadSuccess", 386921)
	self:Log("SPELL_AURA_APPLIED", "Lanced", 387155)
	
	-- Nokhud Saboteur (Mythic-only)
	self:Log("SPELL_AURA_APPLIED", "Dismantle", 386490)
end

function mod:OnEngage()
	self:Bar(388283, 28.8) -- Eruption
	self:Bar(388817, 10.6) -- Shards of Stone
	self:CDBar(385916, 15.5) -- Tectonic Stomp
	if self:Mythic() then
		self:Bar(386320, 5.5) -- Summon Saboteur
	end
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

function mod:SummonSaboteur(args)
	local direction -- 386320 = W Lance, 386747 = NE Lance, 386748 = SE Lance
	if args.spellId == 386320 then
		direction = L.west
	elseif args.spellId == 386747 then
		direction = L.northeast
	else -- 386748
		direction = L.southeast
	end
	self:Message(386320, "red", CL.other:format(args.spellName, direction))
	self:PlaySound(386320, "alert")
	self:CDBar(386320, 29.1)
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
	self:CDBar(388283, 33.1) -- Eruption 5s stun, 27s energy gain, ~1s delay
end

-- Nokhud Saboteur

function mod:Dismantle(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end
