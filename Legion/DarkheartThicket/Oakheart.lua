--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Oakheart", 1466, 1655)
if not mod then return end
mod:RegisterEnableMob(103344) -- Oakheart
mod:SetEncounterID(1837)
mod:SetRespawnTime(15)

--------------------------------------------------------------------------------
-- Locals
--

local uprootCount = 1
local shatteredEarthCount = 1
local nextCrushingGrip = 0
local nextUproot = 0
local nextStranglingRoots = 0
local nextNightmareBreath = 0
local nextShatteredEarth = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.throw = "Throw"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{204611, "SAY"}, -- Crushing Grip
		212786, -- Uproot
		{204574, "DISPEL"}, -- Strangling Roots
		204667, -- Nightmare Breath
		204666, -- Shattered Earth
	}, nil, {
		[204611] = L.throw,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CrushingGrip", 204611)
	self:Log("SPELL_CAST_SUCCESS", "CrushingGripSuccess", 204611)
	self:Log("SPELL_CAST_START", "CrushingGripThrow", 204646)
	self:Log("SPELL_CAST_START", "Uproot", 212786)
	self:Log("SPELL_CAST_START", "StranglingRoots", 204574)
	self:Log("SPELL_AURA_APPLIED", "StranglingRootsApplied", 199063)
	self:Log("SPELL_CAST_START", "NightmareBreath", 204667)
	self:Log("SPELL_CAST_START", "ShatteredEarth", 204666)
end

function mod:OnEngage()
	local t = GetTime()
	uprootCount = 1
	shatteredEarthCount = 1
	self:CDBar(204666, 7.1, CL.count:format(self:SpellName(204666), shatteredEarthCount)) -- Shattered Earth
	nextShatteredEarth = t + 7.1
	if self:Mythic() then
		self:CDBar(204574, 10.8) -- Strangling Roots
		nextStranglingRoots = t + 10.8
		self:CDBar(204667, 22.2) -- Nightmare Breath
		nextNightmareBreath = t + 22.2
		-- dungeon journal says Heroic+, in reality it's Mythic-only
		self:CDBar(212786, 30.0, CL.count:format(self:SpellName(212786), uprootCount)) -- Uproot
		nextUproot = t + 30.0
		self:CDBar(204611, 33.6) -- Crushing Grip
		nextCrushingGrip = t + 33.6
	else -- Heroic, Normal
		self:CDBar(204574, 14.3) -- Strangling Roots
		nextStranglingRoots = t + 14.3
		self:CDBar(204667, 18.1) -- Nightmare Breath
		nextNightmareBreath = t + 18.1
		self:CDBar(204611, 28.9) -- Crushing Grip
		nextCrushingGrip = t + 28.9
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CrushingGrip(args)
	local t = GetTime()
	self:Message(args.spellId, "purple")
	if self:Tank() then
		self:PlaySound(args.spellId, "alert")
	end
	if self:Mythic() then
		self:CDBar(args.spellId, 31.2)
		nextCrushingGrip = t + 31.2
	else
		self:CDBar(args.spellId, 26.7)
		nextCrushingGrip = t + 26.7
	end
	-- 6.05 minimum to Uproot or Strangling Roots
	if self:Mythic() and nextUproot - t < 6.05 then
		nextUproot = t + 6.05
		self:CDBar(212786, {6.05, 40.4}, CL.count:format(self:SpellName(212786), uprootCount)) -- Uproot
	end
	if nextStranglingRoots - t < 6.05 then
		nextStranglingRoots = t + 6.05
		self:CDBar(204574, {6.05, 20.3}) -- Strangling Roots
	end
	-- 15.7 minimum to Shattered Earth or Nightmare Breath
	if nextShatteredEarth - t < 15.7 then
		nextShatteredEarth = t + 15.7
		self:CDBar(204666, {15.7, 31.2}, CL.count:format(self:SpellName(204666), shatteredEarthCount)) -- Shattered Earth
	end
	if nextNightmareBreath - t < 15.7 then
		nextNightmareBreath = t + 15.7
		self:CDBar(204667, {15.7, 31.2}) -- Nightmare Breath
	end
end

do
	local pickedUpPlayerGUID

	function mod:CrushingGripSuccess(args)
		pickedUpPlayerGUID = args.destGUID
	end

	local function printTarget(self, name, guid)
		if guid == pickedUpPlayerGUID then
			-- tank (possibly only one standing) is just being dropped
			if not self:Tank() then -- tank gets notified in :CrushingGrip
				self:Message(204611, "orange", L.throw)
				self:PlaySound(204611, "alarm", nil, name)
			end
		else
			-- tank is being thrown at another player
			self:TargetMessage(204611, "orange", name, L.throw)
			if not self:Tank() then -- sound played for tank in :CrushingGrip
				self:PlaySound(204611, "alarm", nil, name)
			end
			if self:Me(guid) then
				self:Say(204611, L.throw, nil, "Throw")
			end
		end
		pickedUpPlayerGUID = nil
	end

	function mod:CrushingGripThrow(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
	end
end

function mod:Uproot(args)
	-- spawns one Vilethorn Sapling for each Strangling Roots spawned
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, uprootCount))
	self:Message(args.spellId, "cyan", CL.count:format(args.spellName, uprootCount))
	self:PlaySound(args.spellId, "long")
	uprootCount = uprootCount + 1
	self:CDBar(args.spellId, 40.4, CL.count:format(args.spellName, uprootCount))
	nextUproot = t + 40.4
	-- 3.62 minimum to Crushing Grip or Nightmare Breath
	if nextCrushingGrip - t < 3.62 then
		nextCrushingGrip = t + 3.62
		self:CDBar(204611, {3.62, 31.2}) -- Crushing Grip
	end
	if nextNightmareBreath - t < 3.62 then
		nextNightmareBreath = t + 3.62
		self:CDBar(204667, {3.62, 31.2}) -- Nightmare Breath
	end
	-- these might be delayed even more (7.3s?), just do 3.62s "global cooldown" for now
	if nextStranglingRoots - t < 3.62 then
		nextStranglingRoots = t + 3.62
		self:CDBar(204574, {3.62, 20.3}) -- Strangling Roots
	end
	if nextShatteredEarth - t < 3.62 then
		nextShatteredEarth = t + 3.62
		self:CDBar(204666, {3.62, 31.2}, CL.count:format(self:SpellName(204666), shatteredEarthCount)) -- Shattered Earth
	end
end

function mod:StranglingRoots(args)
	local t = GetTime()
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	if self:Mythic() then
		self:CDBar(args.spellId, 20.3)
		nextStranglingRoots = t + 20.3
	else
		self:CDBar(args.spellId, 23.0)
		nextStranglingRoots = t + 23.0
	end
	-- 2.43 minimum to any ability
	if nextCrushingGrip - t < 2.43 then
		nextCrushingGrip = t + 2.43
		self:CDBar(204611, {2.43, 31.2}) -- Crushing Grip
	end
	if nextNightmareBreath - t < 2.43 then
		nextNightmareBreath = t + 2.43
		self:CDBar(204667, {2.43, 31.2}) -- Nightmare Breath
	end
	if nextShatteredEarth - t < 2.43 then
		nextShatteredEarth = t + 2.43
		self:CDBar(204666, {2.43, 31.2}, CL.count:format(self:SpellName(204666), shatteredEarthCount)) -- Shattered Earth
	end
	-- 12.1 minimum to Uproot
	if self:Mythic() and nextUproot - t < 12.1 then
		nextUproot = t + 12.1
		self:CDBar(212786, {12.1, 40.4}, CL.count:format(self:SpellName(212786), uprootCount)) -- Uproot
	end
end

function mod:StranglingRootsApplied(args)
	if self:Player(args.destFlags) and (self:Dispeller("movement", nil, 204574) or self:Me(args.destGUID)) then
		self:TargetMessage(204574, "red", args.destName)
		self:PlaySound(204574, "alert", nil, args.destName)
	end
end

function mod:NightmareBreath(args)
	local t = GetTime()
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	if self:Mythic() then
		self:CDBar(args.spellId, 31.2)
		nextNightmareBreath = t + 31.2
	else
		self:CDBar(args.spellId, 25.6)
		nextNightmareBreath = t + 25.6
	end
	-- 3.6 minimum to Strangling Roots or Uproot
	if nextStranglingRoots - t < 3.6 then
		nextStranglingRoots = t + 3.6
		self:CDBar(204574, {3.6, 20.3}) -- Strangling Roots
	end
	if self:Mythic() and nextUproot - t < 3.6 then
		nextUproot = t + 3.6
		self:CDBar(212786, {3.6, 40.4}, CL.count:format(self:SpellName(212786), uprootCount)) -- Uproot
	end
	-- 8.5 minimum to Crushing Grip or Shattered Earth
	if nextCrushingGrip - t < 8.5 then
		nextCrushingGrip = t + 8.5
		self:CDBar(204611, {8.5, 31.2}) -- Crushing Grip
	end
	if nextShatteredEarth - t < 8.5 then
		nextShatteredEarth = t + 8.5
		self:CDBar(204666, {8.5, 31.2}, CL.count:format(self:SpellName(204666), shatteredEarthCount)) -- Shattered Earth
	end
end

function mod:ShatteredEarth(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, shatteredEarthCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, shatteredEarthCount))
	self:PlaySound(args.spellId, "alert")
	shatteredEarthCount = shatteredEarthCount + 1
	if self:Mythic() then
		self:CDBar(args.spellId, 31.2, CL.count:format(args.spellName, shatteredEarthCount))
		nextShatteredEarth = t + 31.2
	else
		self:CDBar(args.spellId, 34.0, CL.count:format(args.spellName, shatteredEarthCount))
		nextShatteredEarth = t + 34.0
	end
	-- 3.63 to Strangling Roots or Uproot
	if nextStranglingRoots - t < 3.63 then
		nextStranglingRoots = t + 3.63
		self:CDBar(204574, {3.63, 20.3}) -- Strangling Roots
	end
	if self:Mythic() and nextUproot - t < 3.63 then
		nextUproot = t + 3.63
		self:CDBar(212786, {3.63, 40.4}, CL.count:format(self:SpellName(212786), uprootCount)) -- Uproot
	end
	-- 7.3 minimum to Crushing Grip or Nightmare Breath
	if nextCrushingGrip - t < 7.3 then
		nextCrushingGrip = t + 7.3
		self:CDBar(204611, {7.3, 31.2}) -- Crushing Grip
	end
	if nextNightmareBreath - t < 7.3 then
		nextNightmareBreath = t + 7.3
		self:CDBar(204667, {7.3, 31.2}) -- Nightmare Breath
	end
end
