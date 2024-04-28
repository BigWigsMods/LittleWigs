--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Umbrelskul", 2515, 2508)
if not mod then return end
mod:RegisterEnableMob(186738) -- Umbrelskul
mod:SetEncounterID(2584)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local brittleCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

local hardenedCrystalMarker = mod:AddMarkerOption(true, "npc", 8, -26061, 8) -- Hardened Crystal
function mod:GetOptions()
	return {
		386746, -- Brittle
		{385331, "OFF"}, -- Fracture
		385399, -- Unleashed Destruction
		385075, -- Arcane Eruption
		384699, -- Crystalline Roar
		{384978, "DISPEL"}, -- Dragon Strike
		hardenedCrystalMarker,
	}, {
		[hardenedCrystalMarker] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "EncounterEvent", 181089) -- Brittle
	self:Log("SPELL_CAST_START", "UnleashedDestruction", 385399, 388804) -- Normal/Heroic, Mythic/Mythic+
	self:Log("SPELL_CAST_START", "ArcaneEruption", 385075)
	self:Log("SPELL_CAST_SUCCESS", "CrystallineRoar", 384696)
	self:Log("SPELL_CAST_START", "DragonStrike", 384978)
	self:Log("SPELL_CAST_SUCCESS", "DragonStrikeSuccess", 384978)
	self:Log("SPELL_AURA_APPLIED", "DragonStrikeApplied", 384978)
end

function mod:OnEngage()
	brittleCount = 0
	if self:Tank() or self:Solo() or self:Dispeller("magic", nil, 384978) then
		self:CDBar(384978, 7.4) -- Dragon Strike
	end
	self:CDBar(384699, 12.2) -- Crystalline Roar
	-- cast at 100 energy, 27.4s energy gain + .8s delay
	self:CDBar(385075, 28.2) -- Arcane Eruption
	self:CDBar(385399, 54.8) -- Unleashed Destruction
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EncounterEvent(args) -- Brittle
	brittleCount = brittleCount + 1
	self:Message(386746, "orange", CL.percent:format(100 - brittleCount * 25, self:SpellName(386746)))
	self:PlaySound(386746, "long")
	-- after a ~2.4 second delay the Detonating Crystals begin to cast 20s Fracture.
	-- there is no good way to clean up this bar when conditions met (no UNIT_DIED on crystals).
	self:Bar(385331, 22.4) -- Fracture
	-- register events to auto-mark Hardened Crystal
	if self:Mythic() and self:GetOption(hardenedCrystalMarker) then
		self:RegisterTargetEvents("MarkCrystal")
	end
end

function mod:MarkCrystal(_, unit, guid)
	-- there is no SPELL_SUMMON for the crystals and they don't log casts, so scan for the correct NPC id
	if self:MobId(guid) == 199368 then -- Hardened Crystal
		self:CustomIcon(hardenedCrystalMarker, unit, 8)
		self:UnregisterTargetEvents()
	end
end

function mod:UnleashedDestruction(args)
	self:Message(385399, "yellow")
	self:PlaySound(385399, "alarm")
	-- this can be interrupted by Brittle and it won't be recast
	if args.spellId == 388804 then -- Mythic/Mythic+
		-- the timer in Mythic is ~double and has larger variance
		self:CDBar(385399, 114.1)
	else -- 385399, Normal/Heroic
		-- cast at ~50 energy, 54.7s energy gain + optional delay
		self:CDBar(385399, 54.7)
	end
end

function mod:ArcaneEruption(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	-- cast at 100 energy, 54.7s energy gain + optional delay
	-- this can be interrupted by Brittle and it won't be recast
	self:CDBar(args.spellId, 54.7)
end

function mod:CrystallineRoar(args)
	self:Message(384699, "red")
	self:PlaySound(384699, "alarm")
	if self:Mythic() then
		self:CDBar(384699, 105.6)
	else
		self:CDBar(384699, 23.1)
	end
end

function mod:DragonStrike(args)
	if self:Tank() or self:Solo() then
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:DragonStrikeSuccess(args)
	-- this can be interrupted by Brittle but it will be recast, so only start the timer on success
	-- CD seems longer in Mythic, and it's possible there's a pattern but Brittle throws it off
	-- Normal: pull:7.5, 18.2, 10.9, 18.2, 24.3, 13.4, 18.2, 24.3, 13.4, 18.3, 24.3, 13.4, 18.3, 24.3, 13.4, 18.2, 24.3, 12.2, 18.2, 24.3, 12.2, 18.2, 24.3, 18.2, 18.2, 24.3
	-- Mythic: pull:7.6, 18.2, 26.7, 18.2, 24.3, 17.8, 24.3, 18.2, 20.8
	if self:Tank() or self:Solo() or self:Dispeller("magic", nil, args.spellId) then
		if self:Mythic() then
			self:CDBar(args.spellId, 15.3) -- 17.8-2.5 cast time
		else
			self:CDBar(args.spellId, 8.4) -- 10.9-2.5 cast time
		end
	end
end

function mod:DragonStrikeApplied(args)
	if self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "purple", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end
