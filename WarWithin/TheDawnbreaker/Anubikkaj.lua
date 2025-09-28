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
--- Terrifying Slam and Dark Orb always alternate (all difficulties)
--- Shadowy Decay and Animate Shadows always alternate (Mythic)
--- there must be 1-2 Terrifying Slam, 1-2 Dark Orb between each Shadowy Decay (non-Mythic)
--- there must be 1-2 Terrifying Slam, 1-2 Dark Orb, and 1 Animate Shadows between each Shadowy Decay (Mythic)
--- there must be 1-2 Terrifying Slam, 1-2 Dark Orb, and 1 Shadowy Decay between each Animate Shadows (Mythic)
local nextTerrifyingSlam = 0
local nextDarkOrb = 0
local nextShadowyDecay = 0
local nextAnimateShadows = 0
local terrifyingSlamLast = false -- vs Dark Orb
local terrifyingSlamCount = 1
local darkOrbCount = 1
local shadowyDecayCount = 1
local animateShadowsCount = 1
local terrifyingSlamSinceShadowyDecay = 1
local darkOrbSinceShadowyDecay = 1
local animateShadowsSinceShadowyDecay = 1
local terrifyingSlamSinceAnimateShadows = 1
local darkOrbSinceAnimateShadows = 1
local shadowyDecaySinceAnimateShadows = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		427001, -- Terrifying Slam
		{426860, "SAY", "SAY_COUNTDOWN", "ME_ONLY_EMPHASIZE", "PRIVATE"}, -- Dark Orb
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
	terrifyingSlamCount = 1
	darkOrbCount = 1
	shadowyDecayCount = 1
	animateShadowsCount = 1
	local t = GetTime()
	terrifyingSlamLast = false
	terrifyingSlamSinceShadowyDecay = 1
	darkOrbSinceShadowyDecay = 1
	animateShadowsSinceShadowyDecay = 1
	nextDarkOrb = t + 6.0
	self:CDBar(426860, 6.0, CL.count:format(self:SpellName(426860), darkOrbCount)) -- Dark Orb
	nextTerrifyingSlam = t + 15.0
	self:CDBar(427001, 15.0, CL.count:format(self:SpellName(427001), terrifyingSlamCount)) -- Terrifying Slam
	nextShadowyDecay = t + 22.0
	self:CDBar(426787, 22.0, CL.count:format(self:SpellName(426787), shadowyDecayCount)) -- Shadowy Decay
	if self:Mythic() then
		terrifyingSlamSinceAnimateShadows = 1
		darkOrbSinceAnimateShadows = 1
		shadowyDecaySinceAnimateShadows = 0
		nextAnimateShadows = t + 33.0
		self:CDBar(452127, 33.0, CL.count:format(self:SpellName(452127), animateShadowsCount)) -- Animate Shadows
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TerrifyingSlam(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, terrifyingSlamCount))
	self:Message(args.spellId, "purple", CL.count:format(args.spellName, terrifyingSlamCount))
	terrifyingSlamLast = true
	terrifyingSlamCount = terrifyingSlamCount + 1
	terrifyingSlamSinceShadowyDecay = terrifyingSlamSinceShadowyDecay + 1
	-- 7.0 minimum to next ability
	if self:Mythic() then
		terrifyingSlamSinceAnimateShadows = terrifyingSlamSinceAnimateShadows + 1
		-- there must be no more than 2 Terrifying Slam between Shadowy Decay, and no more than 2 Terrifying Slam between Animate Shadows
		local minimumTerrifyingSlam = 7.0 + 9.0 + (terrifyingSlamSinceShadowyDecay == 2 and 11.0 or 0) + (terrifyingSlamSinceAnimateShadows == 2 and 7.5 or 0)
		nextTerrifyingSlam = t + minimumTerrifyingSlam
		self:CDBar(args.spellId, minimumTerrifyingSlam, CL.count:format(args.spellName, terrifyingSlamCount))
		-- there must be no more than 2 Dark Orb between Shadowy Decay, and no more than 2 Dark Orb between Animate Shadows
		local minimumDarkOrb = 7.0 + (darkOrbSinceShadowyDecay == 2 and 11.0 or 0) + (darkOrbSinceAnimateShadows == 2 and 7.5 or 0)
		if nextDarkOrb - t < minimumDarkOrb then
			nextDarkOrb = t + minimumDarkOrb
			self:CDBar(426860, minimumDarkOrb < 16.0 and {minimumDarkOrb, 16.0} or minimumDarkOrb, CL.count:format(self:SpellName(426860), darkOrbCount)) -- Dark Orb
		end
		-- there must be 1-2 Terrifying Slam, 1-2 Dark Orb, and 1 Animate Shadows between each Shadowy Decay
		local minimumShadowyDecay = 7.0 + (darkOrbSinceShadowyDecay == 0 and 9.0 or 0) + (animateShadowsSinceShadowyDecay == 0 and 7.5 or 0)
		if nextShadowyDecay - t < minimumShadowyDecay then
			nextShadowyDecay = t + minimumShadowyDecay
			self:CDBar(426787, {minimumShadowyDecay, 34.5}, CL.count:format(self:SpellName(426787), shadowyDecayCount)) -- Shadowy Decay
		end
		-- there must be 1-2 Terrifying Slam, 1-2 Dark Orb, and 1 Shadowy Decay between each Animate Shadows
		local minimumAnimateShadows = 7.0 + (darkOrbSinceAnimateShadows == 0 and 9.0 or 0) + (shadowyDecaySinceAnimateShadows == 0 and 11.0 or 0)
		if nextAnimateShadows - t < minimumAnimateShadows then
			nextAnimateShadows = t + minimumAnimateShadows
			self:CDBar(452127, {minimumAnimateShadows, 34.5}, CL.count:format(self:SpellName(452127), animateShadowsCount)) -- Animate Shadows
		end
	else -- Normal / Heroic
		if terrifyingSlamSinceShadowyDecay + darkOrbSinceShadowyDecay == 2 then
			-- Terrifying Slam will race Shadowy Decay
			nextTerrifyingSlam = t + 16.0
			self:CDBar(args.spellId, 16.0, CL.count:format(args.spellName, terrifyingSlamCount))
		else
			-- guaranteed Shadowy Decay before the next Terrifying Slam
			nextTerrifyingSlam = t + 27.0
			self:CDBar(args.spellId, 27.0, CL.count:format(args.spellName, terrifyingSlamCount))
		end
		-- there must be 1-2 Terrifying Slam and 1-2 Dark Orb between each Shadowy Decay
		local minimumShadowyDecay = 7.0 + (darkOrbSinceShadowyDecay == 0 and 9.0 or 0)
		if nextShadowyDecay - t < minimumShadowyDecay then
			nextShadowyDecay = t + minimumShadowyDecay
			self:CDBar(426787, {minimumShadowyDecay, 26.0}, CL.count:format(self:SpellName(426787), shadowyDecayCount)) -- Shadowy Decay
		end
	end
	self:PlaySound(args.spellId, "alarm")
end

do
	local startTime = 0

	function mod:DarkOrb(args)
		local t = GetTime()
		startTime = t
		self:StopBar(CL.count:format(args.spellName, darkOrbCount))
		terrifyingSlamLast = false
		darkOrbCount = darkOrbCount + 1
		darkOrbSinceShadowyDecay = darkOrbSinceShadowyDecay + 1
		-- 9.0 minimum to next ability
		if self:Mythic() then
			darkOrbSinceAnimateShadows = darkOrbSinceAnimateShadows + 1
			-- there must be no more than 2 Dark Orb between Shadowy Decay, and no more than 2 Dark Orb between Animate Shadows
			local minimumDarkOrb = 9.0 + 7.0 + (darkOrbSinceShadowyDecay == 2 and 11.0 or 0) + (darkOrbSinceAnimateShadows == 2 and 7.5 or 0)
			nextDarkOrb = t + minimumDarkOrb
			self:CDBar(args.spellId, minimumDarkOrb, CL.count:format(args.spellName, darkOrbCount))
			-- there must be no more than 2 Terrifying Slam between Shadowy Decay, and no more than 2 Terrifying Slam between Animate Shadows
			local minimumTerrifyingSlam = 9.0 + (terrifyingSlamSinceShadowyDecay == 2 and 11.0 or 0) + (terrifyingSlamSinceAnimateShadows == 2 and 7.5 or 0)
			if nextTerrifyingSlam - t < minimumTerrifyingSlam then
				nextTerrifyingSlam = t + minimumTerrifyingSlam
				self:CDBar(427001, minimumTerrifyingSlam < 16.0 and {minimumTerrifyingSlam, 16.0} or minimumTerrifyingSlam, CL.count:format(self:SpellName(427001), terrifyingSlamCount)) -- Terrifying Slam
			end
			-- there must be 1-2 Terrifying Slam, 1-2 Dark Orb, and 1 Animate Shadows between each Shadowy Decay
			local minimumShadowyDecay = 9.0 + (terrifyingSlamSinceShadowyDecay == 0 and 7.0 or 0) + (animateShadowsSinceShadowyDecay == 0 and 7.5 or 0)
			if nextShadowyDecay - t < minimumShadowyDecay then
				nextShadowyDecay = t + minimumShadowyDecay
				self:CDBar(426787, {minimumShadowyDecay, 34.5}, CL.count:format(self:SpellName(426787), shadowyDecayCount)) -- Shadowy Decay
			end
			-- there must be 1-2 Terrifying Slam, 1-2 Dark Orb, and 1 Shadowy Decay between each Animate Shadows
			local minimumAnimateShadows = 9.0 + (terrifyingSlamSinceAnimateShadows == 0 and 7.0 or 0) + (shadowyDecaySinceAnimateShadows == 0 and 11.0 or 0)
			if nextAnimateShadows - t < minimumAnimateShadows then
				nextAnimateShadows = t + minimumAnimateShadows
				self:CDBar(452127, {minimumAnimateShadows, 34.5}, CL.count:format(self:SpellName(452127), animateShadowsCount)) -- Animate Shadows
			end
		else -- Normal / Heroic
			if terrifyingSlamSinceShadowyDecay + darkOrbSinceShadowyDecay == 2 then
				-- Dark Orb will race Shadowy Decay in 16.0
				nextDarkOrb = t + 16.0
				self:CDBar(args.spellId, 16.0, CL.count:format(args.spellName, darkOrbCount))
			else
				-- guaranteed Shadowy Decay before the next Dark Orb
				nextDarkOrb = t + 27.0
				self:CDBar(args.spellId, 27.0, CL.count:format(args.spellName, darkOrbCount))
			end
			-- there must be 1-2 Terrifying Slam and 1-2 Dark Orb between each Shadowy Decay
			local minimumShadowyDecay = 9.0 + (terrifyingSlamSinceShadowyDecay == 0 and 7.0 or 0)
			if nextShadowyDecay - t < minimumShadowyDecay then
				nextShadowyDecay = t + minimumShadowyDecay
				self:CDBar(426787, {minimumShadowyDecay, 26.0}, CL.count:format(self:SpellName(426787), shadowyDecayCount)) -- Shadowy Decay
			end
		end
	end

	function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, destName)
		if msg:find("426860", nil, true) then -- Dark Orb
			-- [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\Spell_Shadow_SoulGem.blp:20|t %s begins to cast |cFFFF0000|Hspell:426860|h[Dark Orb]|h|r at destName!#Anub'ikkaj###destName
			self:TargetMessage(426860, "orange", destName, CL.count:format(self:SpellName(426860), darkOrbCount - 1))
			if self:Me(self:UnitGUID(destName)) then
				self:Say(426860, nil, nil, "Dark Orb")
				-- guard against a missing startTime or a long delay
				local seconds = 4 + startTime - GetTime()
				if seconds > 3.2 then
					self:SayCountdown(426860, seconds)
				end
				-- private aura sound (426865) plays
			else
				self:PlaySound(426860, "alarm", nil, destName)
			end
		end
	end
end

function mod:ShadowyDecay(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, shadowyDecayCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, shadowyDecayCount))
	shadowyDecayCount = shadowyDecayCount + 1
	terrifyingSlamSinceShadowyDecay = 0
	darkOrbSinceShadowyDecay = 0
	-- 11.0 minimum to next ability
	if self:Mythic() then
		animateShadowsSinceShadowyDecay = 0
		shadowyDecaySinceAnimateShadows = shadowyDecaySinceAnimateShadows + 1
		nextShadowyDecay = t + 34.5 -- 11.0 + 7.0 + 9.0 + 7.5
		self:CDBar(args.spellId, 34.5, CL.count:format(args.spellName, shadowyDecayCount))
	else -- Normal / Heroic
		nextShadowyDecay = t + 27.0 -- 11.0 + 7.0 + 9.0
		self:CDBar(args.spellId, 27.0, CL.count:format(args.spellName, shadowyDecayCount))
	end
	-- there must be 1 Dark Orb between each Terrifying Slam, and no more than 2 Terrifying Slam between Animate Shadows
	local minimumTerrifyingSlam = 11.0 + (terrifyingSlamLast and 9.0 or 0) + (terrifyingSlamSinceAnimateShadows == 2 and 7.5 or 0)
	if nextTerrifyingSlam - t < minimumTerrifyingSlam then
		nextTerrifyingSlam = t + minimumTerrifyingSlam
		self:CDBar(427001, minimumTerrifyingSlam < 16.0 and {minimumTerrifyingSlam, 16.0} or minimumTerrifyingSlam, CL.count:format(self:SpellName(427001), terrifyingSlamCount)) -- Terrifying Slam
	end
	-- there must be 1 Terrifying Slam between each Dark Orb, and no more than 2 Dark Orb between Animate Shadows
	local minimumDarkOrb = 11.0 + (terrifyingSlamLast and 0 or 7.0) + (darkOrbSinceAnimateShadows == 2 and 7.5 or 0)
	if nextDarkOrb - t < minimumDarkOrb then
		nextDarkOrb = t + minimumDarkOrb
		self:CDBar(426860, minimumDarkOrb < 16.0 and {minimumDarkOrb, 16.0} or minimumDarkOrb, CL.count:format(self:SpellName(426860), darkOrbCount)) -- Dark Orb
	end
	if self:Mythic() then
		-- there must be 1 Shadowy Decay, 1-2 Terrifying Slam, and 1-2 Dark Orb between each Animate Shadows
		local minimumAnimateShadows = 11.0 + (terrifyingSlamSinceAnimateShadows == 0 and 7.0 or 0) + (darkOrbSinceAnimateShadows == 0 and 9.0 or 0)
		if nextAnimateShadows - t < minimumAnimateShadows then
			nextAnimateShadows = t + minimumAnimateShadows
			self:CDBar(452127, {minimumAnimateShadows, 34.5}, CL.count:format(self:SpellName(452127), animateShadowsCount)) -- Animate Shadows
		end
	end
	self:PlaySound(args.spellId, "alert")
end

-- Mythic

do
	local function printTarget(self, name)
		self:TargetMessage(452127, "cyan", name, CL.count:format(self:SpellName(452127), animateShadowsCount - 1))
		self:PlaySound(452127, "info", nil, name)
	end

	function mod:AnimateShadows(args)
		local t = GetTime()
		self:StopBar(CL.count:format(args.spellName, animateShadowsCount))
		animateShadowsCount = animateShadowsCount + 1
		terrifyingSlamSinceAnimateShadows = 0
		darkOrbSinceAnimateShadows = 0
		shadowyDecaySinceAnimateShadows = 0
		animateShadowsSinceShadowyDecay = animateShadowsSinceShadowyDecay + 1
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		-- 7.5 minimum to next ability
		nextAnimateShadows = t + 34.5 -- 7.5 + 7.0 + 9.0 + 11.0
		self:CDBar(args.spellId, 34.5, CL.count:format(args.spellName, animateShadowsCount))
		-- there must be 1 Dark Orb between each Terrifying Slam, and no more than 2 Terrifying Slam between Shadowy Decay
		local minimumTerrifyingSlam = 7.5 + (terrifyingSlamLast and 9.0 or 0) + (terrifyingSlamSinceShadowyDecay == 2 and 11.0 or 0)
		if nextTerrifyingSlam - t < minimumTerrifyingSlam then
			nextTerrifyingSlam = t + minimumTerrifyingSlam
			self:CDBar(427001, minimumTerrifyingSlam < 16.0 and {minimumTerrifyingSlam, 16.0} or minimumTerrifyingSlam, CL.count:format(self:SpellName(427001), terrifyingSlamCount)) -- Terrifying Slam
		end
		-- there must be 1 Terrifying Slam between each Dark Orb, and no more than 2 Dark Orb between Shadowy Decay
		local minimumDarkOrb = 7.5 + (terrifyingSlamLast and 0 or 7.0) + (darkOrbSinceShadowyDecay == 2 and 11.0 or 0)
		if nextDarkOrb - t < minimumDarkOrb then
			nextDarkOrb = t + minimumDarkOrb
			self:CDBar(426860, minimumDarkOrb < 16.0 and {minimumDarkOrb, 16.0} or minimumDarkOrb, CL.count:format(self:SpellName(426860), darkOrbCount)) -- Dark Orb
		end
		-- there must be 1 Animate Shadows, 1-2 Terrifying Slam, and 1-2 Dark Orb between each Shadowy Decay
		local minimumShadowyDecay = 7.5 + (terrifyingSlamSinceShadowyDecay == 0 and 7.0 or 0) + (darkOrbSinceShadowyDecay == 0 and 9.0 or 0)
		if nextShadowyDecay - t < minimumShadowyDecay then
			nextShadowyDecay = t + minimumShadowyDecay
			self:CDBar(426787, {minimumShadowyDecay, 34.5}, CL.count:format(self:SpellName(426787), shadowyDecayCount)) -- Shadowy Decay
		end
	end
end
