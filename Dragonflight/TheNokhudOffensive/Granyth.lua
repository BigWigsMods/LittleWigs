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
-- Locals
--

local reloadingLanceGUID = nil
local shardsOfStoneCount = 1
local shardsOfStoneRemaining = 2
local eruptionCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

local saboteurMarker = mod:AddMarkerOption(true, "npc", 8, -25612, 8) -- Nokhud Saboteur
function mod:GetOptions()
	return {
		-- Granyth
		{388283, "CASTBAR"}, -- Eruption
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
	reloadingLanceGUID = nil
	shardsOfStoneCount = 1
	shardsOfStoneRemaining = 2
	eruptionCount = 1
	if self:Mythic() then
		self:CDBar(386320, 5.1) -- Summon Saboteur
	end
	self:CDBar(388817, 10.6, CL.count:format(self:SpellName(388817), shardsOfStoneCount)) -- Shards of Stone
	self:CDBar(385916, 15.5) -- Tectonic Stomp
	self:CDBar(388283, 28.8, CL.count:format(self:SpellName(388283), eruptionCount)) -- Eruption
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Granyth

function mod:Eruption(args)
	self:StopBar(CL.count:format(self:SpellName(388817), shardsOfStoneCount)) -- Shards of Stone
	self:StopBar(CL.count:format(args.spellName, eruptionCount))
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	self:CastBar(args.spellId, 6)
end

function mod:ShardsOfStone(args)
	self:StopBar(CL.count:format(args.spellName, shardsOfStoneCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, shardsOfStoneCount))
	self:PlaySound(args.spellId, "alert")
	shardsOfStoneCount = shardsOfStoneCount + 1
	shardsOfStoneRemaining = shardsOfStoneRemaining - 1
	if shardsOfStoneRemaining > 0 then
		self:CDBar(args.spellId, 13.3, CL.count:format(args.spellName, shardsOfStoneCount))
	end
end

function mod:TectonicStomp(args)
	self:StopBar(args.spellId)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

do
	local saboteurGUID = nil

	function mod:SummonSaboteur(args)
		self:StopBar(386320)
		local direction -- 386320 = W Lance, 386747 = NE Lance, 386748 = SE Lance
		if args.spellId == 386320 then
			direction = CL.west
		elseif args.spellId == 386747 then
			direction = CL.north_east
		else -- 386748
			direction = CL.south_east
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
	reloadingLanceGUID = args.sourceGUID
	self:Bar(386530, 25, args.spellName)
end

function mod:ReloadSuccess(args)
	reloadingLanceGUID = nil
	self:Message(386530, "green", L.lance_ready)
	self:PlaySound(386530, "info")
end

function mod:Lanced(args)
	shardsOfStoneRemaining = 2
	self:Message(386530, "green", args.spellName)
	self:PlaySound(386530, "info")
	self:StopBar(CL.cast:format(self:SpellName(388283))) -- Eruption
	if self:Mythic() then
		self:CDBar(386320, 5.3) -- Summon Saboteur
	end
	self:CDBar(388817, 15.4, CL.count:format(self:SpellName(388817), shardsOfStoneCount)) -- Shards of Stone
	self:CDBar(385916, 20.1) -- Tectonic Stomp
	self:StopBar(CL.count:format(self:SpellName(388283), eruptionCount)) -- Eruption
	eruptionCount = eruptionCount + 1
	self:CDBar(388283, 33.1, CL.count:format(self:SpellName(388283), eruptionCount)) -- Eruption: 5s stun, 27s energy gain, ~1s delay
end

-- Nokhud Saboteur

function mod:Dismantle(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

function mod:DismantleApplied(args)
	-- only stop the Reload bar if the reloading lance is the one being Dismantled
	if reloadingLanceGUID == args.destGUID then
		self:StopBar(386921) -- Reload
	end
end
