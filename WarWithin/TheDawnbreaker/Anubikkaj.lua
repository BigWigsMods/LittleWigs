if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Anub'ikkaj", 2662, 2581)
if not mod then return end
mod:RegisterEnableMob(211089) -- Anub'ikkaj
mod:SetEncounterID(2838)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	426865, -- Dark Orb
})

--------------------------------------------------------------------------------
-- Locals
--

-- rules:
--- Terrifying Slam and Dark Orb always alternate
--- Shadowy Decay and Animate Shadows always alternate (Mythic)
local nextTerrifyingSlam = 0
local nextDarkOrb = 0
local nextShadowyDecay = 0
local nextAnimateShadows = 0
local terrifyingSlamLast = false -- vs Dark Orb
local shadowyDecayLast = false -- vs Animate Shadows
local slamOrOrbCount = 1 -- currently only used in non-Mythic

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		427001, -- Terrifying Slam
		{426860, "SAY", "PRIVATE"}, -- Dark Orb
		426787, -- Shadowy Decay
		-- Mythic
		452127, -- Animate Shadows
	}, {
		[452127] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "TerrifyingSlam", 427001)
	self:Log("SPELL_CAST_START", "DarkOrb", 426860)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Dark Orb
	self:Log("SPELL_CAST_START", "ShadowyDecay", 426787)

	-- Mythic
	self:Log("SPELL_CAST_START", "AnimateShadows", 452127)
end

function mod:OnEngage()
	local t = GetTime()
	terrifyingSlamLast = false
	slamOrOrbCount = 2 -- start at 2 because Shadowy Decay is always the 3rd ability cast
	nextDarkOrb = t + 6.0
	self:CDBar(426860, 6.0) -- Dark Orb
	nextTerrifyingSlam = t + 15.0
	self:CDBar(427001, 15.0) -- Terrifying Slam
	nextShadowyDecay = t + 22.0
	self:CDBar(426787, 22.0) -- Shadowy Decay
	if self:Mythic() then
		shadowyDecayLast = false
		nextAnimateShadows = t + 32.0
		self:CDBar(452127, 32.0) -- Animate Shadows
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TerrifyingSlam(args)
	local t = GetTime()
	self:Message(args.spellId, "purple")
	terrifyingSlamLast = true
	slamOrOrbCount = slamOrOrbCount + 1
	-- 7.0 minimum to next ability
	if self:Mythic() then
		nextTerrifyingSlam = t + 16.0
		self:CDBar(args.spellId, 16.0)
		if nextDarkOrb - t < 7.0 then
			nextDarkOrb = t + 7.0
			self:CDBar(426860, {7.0, 16.0}) -- Dark Orb
		end
		if shadowyDecayLast then
			if nextAnimateShadows - t < 7.0 then
				nextAnimateShadows = t + 7.0
				self:CDBar(452127, {7.0, 33.5}) -- Animate Shadows
			end
			if nextShadowyDecay - t < 14.5 then
				nextShadowyDecay = t + 14.5
				self:CDBar(426787, {14.5, 33.5}) -- Shadowy Decay
			end
		else -- Animate Shadows was more recent than Shadowy Decay
			if nextShadowyDecay - t < 7.0 then
				nextShadowyDecay = t + 7.0
				self:CDBar(426787, {7.0, 33.5}) -- Shadowy Decay
			end
			if nextAnimateShadows - t < 17.0 then
				nextAnimateShadows = t + 17.0
				self:CDBar(452127, {17.0, 33.5}) -- Animate Shadows
			end
		end
	else -- Normal / Heroic
		if slamOrOrbCount == 2 then
			-- Terrifying Slam will race Shadowy Decay
			nextTerrifyingSlam = t + 16.0
			self:CDBar(args.spellId, 16.0)
		else
			-- guaranteed Shadowy Decay before the next Terrifying Slam
			nextTerrifyingSlam = t + 26.0
			self:CDBar(args.spellId, 26.0)
		end
		if nextShadowyDecay - t < 7.0 then
			nextShadowyDecay = t + 7.0
			self:CDBar(426787, {7.0, 26.0}) -- Shadowy Decay
		end
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:DarkOrb(args)
	local t = GetTime()
	terrifyingSlamLast = false
	slamOrOrbCount = slamOrOrbCount + 1
	-- 9.0 minimum to next ability
	if self:Mythic() then
		nextDarkOrb = t + 16.0
		self:CDBar(args.spellId, 16.0)
		if nextTerrifyingSlam - t < 9.0 then
			nextTerrifyingSlam = t + 9.0
			self:CDBar(427001, {9.0, 16.0}) -- Terrifying Slam
		end
		if shadowyDecayLast then
			if nextAnimateShadows - t < 9.0 then
				nextAnimateShadows = t + 9.0
				self:CDBar(452127, {9.0, 33.5}) -- Animate Shadows
			end
			if nextShadowyDecay - t < 16.5 then
				nextShadowyDecay = t + 16.5
				self:CDBar(426787, {16.5, 33.5}) -- Shadowy Decay
			end
		else -- Animate Shadows was more recent than Shadowy Decay
			if nextShadowyDecay - t < 9.0 then
				nextShadowyDecay = t + 9.0
				self:CDBar(426787, {9.0, 33.5}) -- Shadowy Decay
			end
			if nextAnimateShadows - t < 19.0 then
				nextAnimateShadows = t + 19.0
				self:CDBar(452127, {19.0, 33.5}) -- Animate Shadows
			end
		end
	else
		if slamOrOrbCount == 2 then
			-- Dark Orb will race Shadowy Decay in 16.0
			nextDarkOrb = t + 16.0
			self:CDBar(args.spellId, 16.0)
		else
			-- guaranteed Shadowy Decay before the next Dark Orb
			nextDarkOrb = t + 26.0
			self:CDBar(args.spellId, 26.0)
		end
		if nextShadowyDecay - t < 9.0 then
			nextShadowyDecay = t + 9.0
			self:CDBar(426787, {9.0, 26.0}) -- Shadowy Decay
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, destName)
	if msg:find("426860", nil, true) then -- Dark Orb
		-- [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\Spell_Shadow_SoulGem.blp:20|t %s begins to cast |cFFFF0000|Hspell:426860|h[Dark Orb]|h|r at Foryou!#Anub'ikkaj###playerName
		self:TargetMessage(426860, "orange", destName)
		if self:Me(self:UnitGUID(destName)) then
			self:Say(426860, nil, nil, "Dark Orb")
			-- private aura sound (426865) plays
		else
			self:PlaySound(426860, "alarm", nil, destName)
		end
	end
end

function mod:ShadowyDecay(args)
	local t = GetTime()
	self:Message(args.spellId, "yellow")
	slamOrOrbCount = 1
	shadowyDecayLast = true
	-- 10.0 minimum to next ability
	if self:Mythic() then
		nextShadowyDecay = t + 33.5
		self:CDBar(args.spellId, 33.5)
		if terrifyingSlamLast then
			if nextDarkOrb - t < 10.0 then
				nextDarkOrb = t + 10.0
				self:CDBar(426860, {10.0, 16.0}) -- Dark Orb
			end
			if nextTerrifyingSlam - t < 19.0 then
				nextTerrifyingSlam = t + 19.0
				self:CDBar(427001, {19.0, 26.0}) -- Terrifying Slam
			end
		else -- Dark Orb was more recent than Terrifying Slam
			if nextTerrifyingSlam - t < 10.0 then
				nextTerrifyingSlam = t + 10.0
				self:CDBar(427001, {10.0, 16.0}) -- Terrifying Slam
			end
			if nextDarkOrb - t < 17.0 then
				nextDarkOrb = t + 17.0
				self:CDBar(426860, {17.0, 26.0}) -- Dark Orb
			end
		end
		if nextAnimateShadows - t < 10.0 then
			nextAnimateShadows = t + 10.0
			self:CDBar(452127, {10.0, 33.5}) -- Animate Shadows
		end
	else
		nextShadowyDecay = t + 26.0
		self:CDBar(args.spellId, 26.0)
		if terrifyingSlamLast then
			if nextDarkOrb - t < 10.0 then
				nextDarkOrb = t + 10.0
				self:CDBar(426860, {10.0, 16.0}) -- Dark Orb
			end
			if nextTerrifyingSlam - t < 19.0 then
				nextTerrifyingSlam = t + 19.0
				self:CDBar(427001, {19.0, 26.0}) -- Terrifying Slam
			end
		else -- Dark Orb was more recent than Terrifying Slam
			if nextTerrifyingSlam - t < 10.0 then
				nextTerrifyingSlam = t + 10.0
				self:CDBar(427001, {10.0, 16.0}) -- Terrifying Slam
			end
			if nextDarkOrb - t < 17.0 then
				nextDarkOrb = t + 17.0
				self:CDBar(426860, {17.0, 26.0}) -- Dark Orb
			end
		end
	end
	self:PlaySound(args.spellId, "alert")
end

-- Mythic

function mod:AnimateShadows(args)
	local t = GetTime()
	self:Message(args.spellId, "cyan")
	slamOrOrbCount = 1
	shadowyDecayLast = false
	nextAnimateShadows = t + 33.5
	self:CDBar(args.spellId, 33.5)
	-- 7.5 minimum to next ability
	if terrifyingSlamLast then
		if nextDarkOrb - t < 7.5 then
			nextDarkOrb = t + 7.5
			self:CDBar(426860, {7.5, 16.0}) -- Dark Orb
		end
		if nextTerrifyingSlam - t < 16.5 then
			nextTerrifyingSlam = t + 16.5
			self:CDBar(427001, 16.5) -- Terrifying Slam
		end
	else
		if nextTerrifyingSlam - t < 7.5 then
			nextTerrifyingSlam = t + 7.5
			self:CDBar(427001, {7.5, 16.0}) -- Terrifying Slam
		end
		if nextDarkOrb - t < 14.5 then
			nextDarkOrb = t + 14.5
			self:CDBar(426860, {14.5, 16.0}) -- Dark Orb
		end
	end
	if nextShadowyDecay - t < 7.5 then
		nextShadowyDecay = t + 7.5
		self:CDBar(426787, {7.5, 33.5}) -- Shadowy Decay
	end
	self:PlaySound(args.spellId, "info")
end
