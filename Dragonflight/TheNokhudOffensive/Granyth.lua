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

local saboteurMarker = mod:AddMarkerOption(true, "npc", 8, -25612, 8) -- Nokhud Saboteur
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
		saboteurMarker,
		386490, -- Dismantle
	}, {
		[388283] = -25455, -- Granyth
		[386530] = -25614, -- Dragonkiller Lance
		[saboteurMarker] = -25612, -- Nokhud Saboteur
	}
end

function mod:OnBossEnable()
	-- Granyth
	self:Log("SPELL_CAST_START", "Eruption", 388283)
	self:Log("SPELL_CAST_START", "ShardsOfStone", 388817)
	self:Log("SPELL_CAST_START", "TectonicStomp", 385916)
	self:Log("SPELL_SUMMON", "SummonSaboteur", 386320, 386747, 386748)

	-- Dragonkiller Lance
	self:Log("SPELL_CAST_START", "Reload", 386921)
	self:Log("SPELL_CAST_SUCCESS", "ReloadSuccess", 386921)
	self:Log("SPELL_AURA_APPLIED", "Lanced", 387155)
	
	-- Nokhud Saboteur (Mythic-only)
	self:Log("SPELL_CAST_START", "Dismantle", 386490)
	self:Log("SPELL_AURA_APPLIED", "DismantleApplied", 386490)
end

function mod:OnEngage()
	self:CDBar(388283, 28.8) -- Eruption
	self:CDBar(388817, 10.6) -- Shards of Stone
	self:CDBar(385916, 15.5) -- Tectonic Stomp
	if self:Mythic() then
		self:CDBar(386320, 5.1) -- Summon Saboteur
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Granyth

function mod:Eruption(args)
	self:StopBar(388817) -- Shards of Stone
	self:StopBar(args.spellId)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	self:CastBar(args.spellId, 6)
end

function mod:ShardsOfStone(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 13.3)
end

function mod:TectonicStomp(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

do
	local saboteurGUID = nil

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

		-- register events to auto-mark saboteur
		if self:GetOption(saboteurMarker) then
			saboteurGUID = args.destGUID
			self:RegisterTargetEvents("MarkSaboteur")
		end
	end

	function mod:MarkSaboteur(_, unit, guid)
		if saboteurGUID == guid then
			saboteurGUID = nil
			self:CustomIcon(saboteurMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end
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
	self:CDBar(386320, 5.3) -- Summon Saboteur
	self:CDBar(388817, 15.4) -- Shards of Stone
	self:CDBar(385916, 20.1) -- Tectonic Stomp
	self:CDBar(388283, 33.1) -- Eruption 5s stun, 27s energy gain, ~1s delay
end

-- Nokhud Saboteur

function mod:Dismantle(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

function mod:DismantleApplied(args)
	self:StopBar(386921) -- Reload
end
