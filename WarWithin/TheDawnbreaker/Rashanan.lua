--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rasha'nan Dawnbreaker", 2662, 2593)
if not mod then return end
mod:RegisterEnableMob(213937) -- Rasha'nan
mod:SetEncounterID(2839)
mod:SetRespawnTime(30)
mod:SetStage(1)
mod:SetPrivateAuraSounds({
	434406, -- Rolling Acid
	434090, -- Spinneret's Strands
})

--------------------------------------------------------------------------------
-- Locals
--

local throwArathiBombCount = 1
local rollingAcidCount = 1
local erosiveSprayCount = 1
local expelWebsCount = 1
local acidicEruptionCount = 1
local spinneretsStrandsCount = 1
local radiantLightOnGroup = false
local nextRollingAcid = 0
local nextErosiveSpray = 0
local nextExpelWebs = 0
local nextSpinneretsStrands = 0

-- in Stage 2 Rolling Acid and Erosive Spray cooldowns are not based off the previous cast, but are on a repeating
-- cadence starting from the very first cast in Stage 2. so if either of these abilities is delayed by another ability,
-- the following cast will happen early as if the delay never happened.
local nextRollingAcidRepeater = 0
local nextErosiveSprayRepeater = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Stage 1: The Dawnbreaker
		434655, -- Arathi Bomb
		{434407, "PRIVATE"}, -- Rolling Acid
		448888, -- Erosive Spray
		448213, -- Expel Webs (Mythic)
		435793, -- Tacky Burst
		-- Intermission: Escape!
		449528, -- Radiant Light
		{449332, "COUNTDOWN"}, -- Encroaching Shadows
		449734, -- Acidic Eruption
		-- Stage 2: The Veneration Grounds
		{434089, "PRIVATE"}, -- Spinneret's Strands
	}, {
		[434655] = -28814, -- Stage 1: The Dawnbreaker
		[449528] = -29591, -- Intermission: Escape!
		[434089] = -28821, -- Stage 2: The Veneration Grounds
	}, {
		[434655] = CL.bombs, -- Arathi Bomb (Bombs)
		[448213] = CL.mythic, -- Expel Webs (Mythic mode)
		[449528] = CL.flying_available, -- Radiant Light (You can fly now)
	}
end

function mod:OnBossEnable()
	-- Stage 1: The Dawnbreaker
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Arathi Bomb, Intermission trigger
	self:Log("SPELL_AURA_APPLIED", "SparkingArathiBomb", 434668)
	self:Log("SPELL_CAST_SUCCESS", "ThrowArathiBomb", 438875)
	self:Log("SPELL_CAST_START", "RollingAcid", 434407)
	self:Log("SPELL_CAST_START", "ErosiveSpray", 448888)
	self:Log("SPELL_CAST_START", "ExpelWebs", 448213)
	self:Log("SPELL_CAST_SUCCESS", "TackyBurst", 435793)

	-- Intermission: Escape!
	self:Log("SPELL_CAST_SUCCESS", "RadiantLight", 449498)
	self:Log("SPELL_AURA_APPLIED", "EncroachingShadowsApplied", 449332)
	self:Log("SPELL_AURA_REMOVED", "EncroachingShadowsRemoved", 449332)
	self:Log("SPELL_CAST_START", "AcidicEruption", 449734)
	self:Log("SPELL_INTERRUPT", "AcidicEruptionInterrupted", 449734)

	-- Stage 2: The Veneration Grounds
	self:Log("SPELL_CAST_START", "SpinneretsStrands", 434089)
end

function mod:OnEngage()
	local t = GetTime()
	throwArathiBombCount = 1
	rollingAcidCount = 1
	erosiveSprayCount = 1
	acidicEruptionCount = 1
	spinneretsStrandsCount = 1
	radiantLightOnGroup = false
	nextRollingAcidRepeater = 0
	nextErosiveSprayRepeater = 0
	nextSpinneretsStrands = 0
	self:SetStage(1)
	if self:Mythic() then
		expelWebsCount = 1
		nextExpelWebs = t + 6.7
		self:CDBar(448213, 6.7, CL.count:format(self:SpellName(448213), expelWebsCount)) -- Expel Webs
		nextRollingAcid = t + 10.7
		self:CDBar(434407, 10.7, CL.count:format(self:SpellName(434407), rollingAcidCount)) -- Rolling Acid
	else
		nextRollingAcid = t + 9.3
		self:CDBar(434407, 9.3, CL.count:format(self:SpellName(434407), rollingAcidCount)) -- Rolling Acid
	end
	self:CDBar(434655, 13.5, CL.spawning:format(CL.bombs)) -- Arathi Bomb
	nextErosiveSpray = t + 20.0
	self:CDBar(448888, 20.0, CL.count:format(self:SpellName(448888), erosiveSprayCount)) -- Erosive Spray
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage 1: The Dawnbreaker

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("434655", nil, true) then -- Arathi Bomb
		-- |TInterface\\ICONS\\INV_Eng_BombFire.blp:20|t A %s arrives to throw |cFFFF0000|Hspell:434655|h[Arathi Bomb]|h|rs!#Nightfall Bomber
		self:Message(434655, "cyan", CL.spawning:format(CL.bombs))
		self:CDBar(434655, 33.3, CL.spawning:format(CL.bombs))
		self:PlaySound(434655, "long")
	elseif msg:find("INV_Icon_wing07b", nil, true) then -- Intermission: Escape!
		-- |TInterface\\ICONS\\INV_Icon_wing07b.BLP:20|t %s begins to flee! |TInterface\\ICONS\\Ability_DragonRiding_DragonRiding01.BLP:20|t Take flight!#Rasha'nan
		self:StopBar(CL.count:format(self:SpellName(434407), rollingAcidCount)) -- Rolling Acid
		self:StopBar(CL.spawning:format(CL.bombs)) -- Arathi Bomb
		self:StopBar(CL.count:format(self:SpellName(448888), erosiveSprayCount)) -- Erosive Spray
		if self:Mythic() then
			self:StopBar(CL.count:format(self:SpellName(448213), expelWebsCount)) -- Expel Webs
		end
		self:SetStage(1.5)
		self:Message("stages", "cyan", self:SpellName(-29591), "INV_Icon_wing07b") -- Intermission: Escape!
		self:CDBar(449734, 49.3) -- Acidic Eruption
		self:PlaySound("stages", "long")
	end
end

function mod:SparkingArathiBomb(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(434655, nil, CL.bomb)
		self:PlaySound(434655, "info", nil, args.destName)
	end
end

function mod:ThrowArathiBomb(args)
	if self:Mythic() then
		self:Message(434655, "green", CL.count_amount:format(args.spellName, throwArathiBombCount, 6))
	elseif self:Heroic() then
		self:Message(434655, "green", CL.count_amount:format(args.spellName, throwArathiBombCount, 5))
	else -- Normal
		self:Message(434655, "green", CL.count_amount:format(args.spellName, throwArathiBombCount, 3))
	end
	throwArathiBombCount = throwArathiBombCount + 1
	if self:Me(args.sourceGUID) then
		self:PlaySound(434655, "info", nil, args.sourceName)
	end
end

function mod:RollingAcid(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, rollingAcidCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, rollingAcidCount))
	rollingAcidCount = rollingAcidCount + 1
	if self:GetStage() == 1 then
		if self:Mythic() then
			nextRollingAcid = t + 20.0
			self:CDBar(args.spellId, 20.0, CL.count:format(args.spellName, rollingAcidCount))
		else
			nextRollingAcid = t + 18.7
			self:CDBar(args.spellId, 18.7, CL.count:format(args.spellName, rollingAcidCount))
		end
		-- 6.01 to next ability
		if nextErosiveSpray - t < 6.01 then
			nextErosiveSpray = t + 6.01
			self:CDBar(448888, {6.01, 23.3}, CL.count:format(self:SpellName(448888), erosiveSprayCount)) -- Erosive Spray
		end
		if self:Mythic() and nextExpelWebs - t < 6.01 then
			nextExpelWebs = t + 6.01
			self:CDBar(448213, {6.01, 10.0}, CL.count:format(self:SpellName(448213), expelWebsCount)) -- Expel Webs
		end
	else -- Stage 2
		local delay = 0
		if nextRollingAcidRepeater ~= 0 and nextRollingAcidRepeater < t then
			-- Rolling Acid is late, so the next one will be early
			delay = t - nextRollingAcidRepeater
		end
		nextRollingAcid = t + 37.03 - delay
		nextRollingAcidRepeater = nextRollingAcid
		self:CDBar(args.spellId, 37.03 - delay, CL.count:format(args.spellName, rollingAcidCount))
		-- 6.67 to next ability
		if nextErosiveSpray - t < 6.67 then
			nextErosiveSpray = t + 6.67
			self:CDBar(448888, {6.67, 31.11}, CL.count:format(self:SpellName(448888), erosiveSprayCount)) -- Erosive Spray
		end
		if self:Mythic() and nextExpelWebs - t < 6.67 then
			nextExpelWebs = t + 6.67
			self:CDBar(448213, {6.67, 14.0}, CL.count:format(self:SpellName(448213), expelWebsCount)) -- Expel Webs
		end
		-- Rolling Acid adds 5.17 to Spinneret's Strands, but there's still the minimum of 6.67
		if spinneretsStrandsCount ~= 1 then
			if nextSpinneretsStrands - t > 1.5 then
				nextSpinneretsStrands = nextSpinneretsStrands + 5.17
				self:CDBar(434089, {nextSpinneretsStrands - t, 31.07}, CL.count:format(self:SpellName(434089), spinneretsStrandsCount)) -- Spinneret's Strands
			else
				nextSpinneretsStrands = t + 6.67
				self:CDBar(434089, {6.67, 25.9}, CL.count:format(self:SpellName(434089), spinneretsStrandsCount)) -- Spinneret's Strands
			end
		end
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:ErosiveSpray(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, erosiveSprayCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, erosiveSprayCount))
	erosiveSprayCount = erosiveSprayCount + 1
	if self:GetStage() == 1 then
		if self:Mythic() then
			nextErosiveSpray = t + 28.0
			self:CDBar(args.spellId, 28.0, CL.count:format(args.spellName, erosiveSprayCount))
		else
			nextErosiveSpray = t + 23.3
			self:CDBar(args.spellId, 23.3, CL.count:format(args.spellName, erosiveSprayCount))
		end
		-- 6.67 to next ability
		if nextRollingAcid - t < 6.67 then
			nextRollingAcid = t + 6.67
			self:CDBar(434407, {6.67, 18.7}, CL.count:format(self:SpellName(434407), rollingAcidCount)) -- Rolling Acid
		end
		if self:Mythic() and nextExpelWebs - t < 6.67 then
			nextExpelWebs = t + 6.67
			self:CDBar(448213, {6.67, 10.0}, CL.count:format(self:SpellName(448213), expelWebsCount)) -- Expel Webs
		end
	else -- Stage 2
		local delay = 0
		if nextErosiveSprayRepeater ~= 0 and nextErosiveSprayRepeater < t then
			-- Erosive Spray is late, so the next one will be early
			delay = t - nextErosiveSprayRepeater
		end
		nextErosiveSpray = t + 31.11 - delay
		nextErosiveSprayRepeater = nextErosiveSpray
		self:CDBar(args.spellId, 31.11 - delay, CL.count:format(args.spellName, erosiveSprayCount))
		-- 7.41 to next ability
		if nextRollingAcid - t < 7.41 then
			nextRollingAcid = t + 7.41
			self:CDBar(434407, {7.41, 37.03}, CL.count:format(self:SpellName(434407), rollingAcidCount)) -- Rolling Acid
		end
		if self:Mythic() and nextExpelWebs - t < 7.41 then
			nextExpelWebs = t + 7.41
			self:CDBar(448213, {7.41, 14.0}, CL.count:format(self:SpellName(448213), expelWebsCount)) -- Expel Webs
		end
		if nextSpinneretsStrands - t < 7.41 then
			nextSpinneretsStrands = t + 7.41
			self:CDBar(434089, {7.41, 25.9}, CL.count:format(self:SpellName(434089), spinneretsStrandsCount)) -- Spinneret's Strands
		end
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:ExpelWebs(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, expelWebsCount))
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, expelWebsCount))
	expelWebsCount = expelWebsCount + 1
	if self:GetStage() == 1 then
		nextExpelWebs = t + 10.0
		self:CDBar(args.spellId, 10.0, CL.count:format(args.spellName, expelWebsCount))
		-- 4.0 to next ability
		if nextRollingAcid - t < 4.0 then
			nextRollingAcid = t + 4.0
			self:CDBar(434407, {4.0, 20.0}, CL.count:format(self:SpellName(434407), rollingAcidCount)) -- Rolling Acid
		end
		if nextErosiveSpray - t < 4.0 then
			nextErosiveSpray = t + 4.0
			self:CDBar(448888, {4.0, 28.0}, CL.count:format(self:SpellName(448888), erosiveSprayCount)) -- Erosive Spray
		end
	else -- Stage 2
		nextExpelWebs = t + 15.5
		self:CDBar(args.spellId, 15.5, CL.count:format(args.spellName, expelWebsCount))
		-- 4.45 to next ability
		if nextRollingAcid - t < 4.45 then
			nextRollingAcid = t + 4.45
			self:CDBar(434407, {4.45, 37.03}, CL.count:format(self:SpellName(434407), rollingAcidCount)) -- Rolling Acid
		end
		if nextErosiveSpray - t < 4.45 then
			nextErosiveSpray = t + 4.45
			self:CDBar(448888, {4.45, 31.11}, CL.count:format(self:SpellName(448888), erosiveSprayCount)) -- Erosive Spray
		end
		if nextSpinneretsStrands - t < 4.45 then
			nextSpinneretsStrands = t + 4.45
			self:CDBar(434089, {4.45, 25.9}, CL.count:format(self:SpellName(434089), spinneretsStrandsCount)) -- Spinneret's Strands
		end
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:TackyBurst(args)
	-- spammed when no one is in melee range
	self:Message(args.spellId, "purple")
	if self:Tank() then
		self:PlaySound(args.spellId, "warning")
	end
end

-- Intermission: Escape!

function mod:RadiantLight()
	if not radiantLightOnGroup then
		-- this is cast more than once, and allows you to fly. we only care about the very first cast.
		radiantLightOnGroup = true
		self:Message(449528, "green", CL.flying_available, "Ability_DragonRiding_DragonRiding01")
		self:PlaySound(449528, "info")
	end
end

function mod:EncroachingShadowsApplied(args)
	if self:Me(args.destGUID) then
		-- if this bar runs out, you die
		self:Bar(args.spellId, 10)
	end
end

function mod:EncroachingShadowsRemoved(args)
	if self:Me(args.destGUID) then
		self:StopBar(args.spellId)
	end
end

function mod:AcidicEruption(args)
	-- spammed until interrupted
	if acidicEruptionCount == 1 then
		self:StopBar(args.spellId)
	end
	self:Message(args.spellId, "yellow", CL.count:format(CL.casting:format(args.spellName), acidicEruptionCount))
	acidicEruptionCount = acidicEruptionCount + 1
	self:PlaySound(args.spellId, "alert")
end

function mod:AcidicEruptionInterrupted(args)
	local t = GetTime()
	rollingAcidCount = 1
	erosiveSprayCount = 1
	self:Message(449734, "green", CL.interrupted_by:format(args.extraSpellName, self:ColorName(args.sourceName)))
	self:SetStage(2)
	nextRollingAcid = t + 4.0
	self:CDBar(434407, 4.0, CL.count:format(self:SpellName(434407), rollingAcidCount)) -- Rolling Acid
	nextSpinneretsStrands = t + 12.0
	self:CDBar(434089, 12.0, CL.count:format(self:SpellName(434089), spinneretsStrandsCount)) -- Spinneret's Strands
	if self:Mythic() then
		expelWebsCount = 1
		nextExpelWebs = t + 17.3
		self:CDBar(448213, 17.3, CL.count:format(self:SpellName(448213), expelWebsCount)) -- Expel Webs
		nextErosiveSpray = t + 21.3
		self:CDBar(448888, 21.3, CL.count:format(self:SpellName(448888), erosiveSprayCount)) -- Erosive Spray
	else
		nextErosiveSpray = t + 29.3
		self:CDBar(448888, 29.3, CL.count:format(self:SpellName(448888), erosiveSprayCount)) -- Erosive Spray
	end
	self:PlaySound(449734, "info")
end

-- Stage 2: The Veneration Grounds

function mod:SpinneretsStrands(args)
	local t = GetTime()
	if self:GetStage() ~= 2 then
		self:SetStage(2) -- in case of reloads
	end
	self:StopBar(CL.count:format(args.spellName, spinneretsStrandsCount))
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, spinneretsStrandsCount))
	spinneretsStrandsCount = spinneretsStrandsCount + 1
	nextSpinneretsStrands = t + 25.9
	self:CDBar(args.spellId, 25.9, CL.count:format(args.spellName, spinneretsStrandsCount))
	-- minimum 5.92 to next ability
	if nextRollingAcid - t < 5.92 then
		nextRollingAcid = t + 5.92
		self:CDBar(434407, {5.92, 37.03}, CL.count:format(self:SpellName(434407), rollingAcidCount)) -- Rolling Acid
	end
	if nextErosiveSpray - t < 5.92 then
		nextErosiveSpray = t + 5.92
		self:CDBar(448888, {5.92, 31.11}, CL.count:format(self:SpellName(448888), erosiveSprayCount)) -- Erosive Spray
	end
	if self:Mythic() and nextExpelWebs - t < 5.92 then
		nextExpelWebs = t + 5.92
		self:CDBar(448213, {5.92, 14.0}, CL.count:format(self:SpellName(448213), expelWebsCount)) -- Expel Webs
	end
	self:PlaySound(args.spellId, "alert")
end
