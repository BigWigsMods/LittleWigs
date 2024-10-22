--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Cragpie", 2687)
if not mod then return end
mod:RegisterEnableMob(220008) -- Cragpie
mod:SetEncounterID(3001)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local nextCorrosiveBile = 0
local nextSwiftness = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.cragpie = "Cragpie"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.cragpie
end

function mod:GetOptions()
	return {
		{470612, "DISPEL"}, -- Corrosive Bile
		{359016, "DISPEL"}, -- Swiftness
		390943, -- Electric Cataclysm
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CorrosiveBile", 470612)
	self:Log("SPELL_AURA_APPLIED", "CorrosiveBileApplied", 470612)
	self:Log("SPELL_CAST_START", "Swiftness", 359016)
	self:Log("SPELL_AURA_APPLIED", "SwiftnessApplied", 359016)
	self:Log("SPELL_CAST_START", "ElectricCataclysm", 390943)
end

function mod:OnEngage()
	local t = GetTime()
	nextCorrosiveBile = t + 6.0
	self:CDBar(470612, 6.0) -- Corrosive Bile
	nextSwiftness = t + 12.1
	self:CDBar(359016, 12.1) -- Swiftness
	self:CDBar(390943, 20.2) -- Electric Cataclysm
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CorrosiveBile(args)
	local t = GetTime()
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	nextCorrosiveBile = t + 23.0
	self:CDBar(args.spellId, 23.0)
	self:PlaySound(args.spellId, "alert")
end

function mod:CorrosiveBileApplied(args)
	if self:Dispeller("poison", nil, args.spellId) and self:Player(args.destFlags) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:Swiftness(args)
	local t = GetTime()
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	nextSwiftness = t + 20.7
	self:CDBar(args.spellId, 20.7)
	self:PlaySound(args.spellId, "alert")
end

function mod:SwiftnessApplied(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Player(args.destFlags) then
		self:Message(args.spellId, "red", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:ElectricCataclysm(args)
	local t = GetTime()
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 30.3)
	-- 8.5s before another spell can be cast
	if nextCorrosiveBile - t < 8.5 then
		nextCorrosiveBile = t + 8.5
		self:CDBar(470612, {8.5, 23.0}) -- Corrosive Bile
	end
	if nextSwiftness - t < 8.5 then
		nextSwiftness = t + 8.5
		self:CDBar(359016, {8.5, 20.7}) -- Swiftness
	end
	self:PlaySound(args.spellId, "long")
end
