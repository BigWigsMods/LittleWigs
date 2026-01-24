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
	{427378, sound = "underyou"}, -- Dark Scars
})

--------------------------------------------------------------------------------
-- Locals
--

local terrifyingSlamCount = 1
local darkOrbCount = 1
local shadowyDecayCount = 1
local animateShadowsCount = 1
-- ability order follows these tables, looping to the beginning if the end is reached
local mythicAbilityOrder = {
	426860, -- 1: Dark Orb
	427001, -- 2: Terrifying Slam
	426787, -- 3: Shadowy Decay
	452127, -- 4: Animate Shadows
	426860, -- 5: Dark Orb
	427001, -- 6: Terrifying Slam
	426787, -- 7: Shadowy Decay
	426860, -- 8: Dark Orb
	{[1] = 427001, [2] = 452127, [427001] = true, [452127] = true}, -- 9: Terrifying Slam OR Animate Shadows
	{[1] = 427001, [2] = 452127, [427001] = true, [452127] = true}, -- 10: Terrifying Slam OR Animate Shadows
	426860, -- 11: Dark Orb
	426787, -- 12: Shadowy Decay
	427001, -- 13: Terrifying Slam
	452127, -- 14: Animate Shadows
	426860, -- 15: Dark Orb
	427001, -- 16: Terrifying Slam
	426787, -- 17: Shadowy Decay
	426860, -- 18: Dark Orb
	427001, -- 19: Terrifying Slam
	452127, -- 20: Animate Shadows
	426787, -- 21: Shadowy Decay
	426860, -- 22: Dark Orb
	427001, -- 23: Terrifying Slam
	{[1] = 426860, [2] = 452127, [426860] = true, [452127] = true}, -- 24: Dark Orb OR Animate Shadows
	{[1] = 426860, [2] = 452127, [426860] = true, [452127] = true}, -- 25: Dark Orb OR Animate Shadows
	426787, -- 26: Shadowy Decay
	427001, -- 27: Terrifying Slam
}
local easyAbilityOrder = {
	426860, -- 1: Dark Orb
	427001, -- 2: Terrifying Slam
	426787, -- 3: Shadowy Decay
	426860, -- 4: Dark Orb
	427001, -- 5: Terrifying Slam
	426787, -- 6: Shadowy Decay
	426860, -- 7: Dark Orb
	427001, -- 8: Terrifying Slam
	426860, -- 9: Dark Orb
	426787, -- 10: Shadowy Decay
	427001, -- 11: Terrifying Slam
}
local icdByAbility = {
	[426860] = 9, -- Dark Orb
	[427001] = 7, -- Terrifying Slam
	[426787] = 11, -- Shadowy Decay
	[452127] = 7.5, -- Animate Shadows
}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		427001, -- Terrifying Slam
		{426860, "SAY", "SAY_COUNTDOWN", "ME_ONLY_EMPHASIZE", "PRIVATE"}, -- Dark Orb
		427378, -- Dark Scars
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
	self:Log("SPELL_AURA_APPLIED", "DarkScarsApplied", 427378)
	self:Log("SPELL_AURA_APPLIED_DOSE", "DarkScarsApplied", 427378)
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
	self:CDBar(426860, 6.0, CL.count:format(self:SpellName(426860), darkOrbCount)) -- Dark Orb
	self:CDBar(427001, 15.0, CL.count:format(self:SpellName(427001), terrifyingSlamCount)) -- Terrifying Slam
	self:CDBar(426787, 22.0, CL.count:format(self:SpellName(426787), shadowyDecayCount)) -- Shadowy Decay
	if self:Mythic() then
		self:CDBar(452127, 33.0, CL.count:format(self:SpellName(452127), animateShadowsCount)) -- Animate Shadows
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

local function findNextCast(self, spellId)
	local abilityOrder = self:Mythic() and mythicAbilityOrder or easyAbilityOrder
	local tableLength = #abilityOrder
	local startIndex = darkOrbCount + terrifyingSlamCount + shadowyDecayCount + animateShadowsCount - 3
	local duration = icdByAbility[spellId] -- start with the ICD of the spell just cast
	local pairedSpell, icd -- used to delay the second spell in a pair
	for i = startIndex, startIndex + tableLength do
		local tableIndex = (i - 1) % tableLength + 1
		local ability = abilityOrder[tableIndex]
		if type(ability) == "table" then -- ambiguous (Mythic only)
			if ability[spellId] then -- if the table contains the spell just cast
				if i == startIndex then -- special case when the first of an ambiguous pair was just cast
					for j = 1, 2 do
						if ability[j] ~= spellId then -- for the paired spell which was not just cast
							-- we need to add the ICD of the spell that was not just cast, since that spell will always be next
							duration = duration + icdByAbility[ability[j]]
							-- set these so the bar of the paired spell can be restarted by the caller (since it's now at 0s)
							pairedSpell = ability[j]
							icd = icdByAbility[spellId]
							break
						end
					end
				else
					return duration, pairedSpell, icd
				end
			else
				-- the table doesn't contain our target spell, so just add the ICD of each spell in the table (one at a time)
				duration = duration + icdByAbility[ability[tableIndex % 2 + 1]]
			end
		else -- unambiguous
			if ability == spellId then
				return duration, pairedSpell, icd
			else
				duration = duration + icdByAbility[ability]
			end
		end
	end
end

function mod:TerrifyingSlam(args)
	self:StopBar(CL.count:format(args.spellName, terrifyingSlamCount))
	self:Message(args.spellId, "purple", CL.count:format(args.spellName, terrifyingSlamCount))
	terrifyingSlamCount = terrifyingSlamCount + 1
	local duration, pairedSpell, icd = findNextCast(self, args.spellId)
	self:CDBar(args.spellId, duration, CL.count:format(args.spellName, terrifyingSlamCount))
	if pairedSpell == 452127 then -- Animate Shadows
		self:CDBar(452127, icd, CL.count:format(self:SpellName(452127), animateShadowsCount))
	end
	self:PlaySound(args.spellId, "alarm")
end

do
	local startTime = 0

	function mod:DarkOrb(args)
		startTime = GetTime()
		self:StopBar(CL.count:format(args.spellName, darkOrbCount))
		darkOrbCount = darkOrbCount + 1
		local duration, pairedSpell, icd = findNextCast(self, args.spellId)
		self:CDBar(args.spellId, duration, CL.count:format(args.spellName, darkOrbCount))
		if pairedSpell == 452127 then -- Animate Shadows
			self:CDBar(452127, icd, CL.count:format(self:SpellName(452127), animateShadowsCount))
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

do
	local prev = 0
	function mod:DarkScarsApplied(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then -- 1s stack rate
			prev = args.time
			self:StackMessage(args.spellId, "blue", args.destName, args.amount, 1)
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:ShadowyDecay(args)
	self:StopBar(CL.count:format(args.spellName, shadowyDecayCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, shadowyDecayCount))
	shadowyDecayCount = shadowyDecayCount + 1
	local duration = findNextCast(self, args.spellId)
	self:CDBar(args.spellId, duration, CL.count:format(args.spellName, shadowyDecayCount))
	self:PlaySound(args.spellId, "alert")
end

-- Mythic

do
	local function printTarget(self, name)
		self:TargetMessage(452127, "cyan", name, CL.count:format(self:SpellName(452127), animateShadowsCount - 1))
		self:PlaySound(452127, "info", nil, name)
	end

	function mod:AnimateShadows(args)
		self:StopBar(CL.count:format(args.spellName, animateShadowsCount))
		animateShadowsCount = animateShadowsCount + 1
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		local duration, pairedSpell, icd = findNextCast(self, args.spellId)
		self:CDBar(args.spellId, duration, CL.count:format(args.spellName, animateShadowsCount))
		if pairedSpell == 426860 then -- Dark Orb
			self:CDBar(426860, icd, CL.count:format(self:SpellName(426860), darkOrbCount))
		elseif pairedSpell == 427001 then -- Terrifying Slam
			self:CDBar(427001, icd, CL.count:format(self:SpellName(427001), terrifyingSlamCount))
		end
	end
end
