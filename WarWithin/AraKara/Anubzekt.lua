--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Anub'zekt", 2660, 2584)
if not mod then return end
mod:RegisterEnableMob(215405) -- Anub'zekt
mod:SetEncounterID(2906)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local inBurrowChargeCombo = false
local burrowChargeRemaining = 1
local eyeOfTheSwarmCount = 1
local bloodstainedWebmageCount = 1
local nextInfestation = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.bloodstained_webmage = -28975
	L.bloodstained_webmage_desc = "Anub'zekt summons a Bloodstained Webmage.\n\n{-28975}"
	L.bloodstained_webmage_icon = "spell_nature_web"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Anub'zekt
		435012, -- Impale
		{439506, "SAY"}, -- Burrow Charge
		{433740, "ME_ONLY", "SAY"}, -- Infestation
		433766, -- Eye of the Swarm
		433781, -- Ceaseless Swarm
		"bloodstained_webmage",
		-- Bloodstained Web Mage (Mythic)
		442210, -- Silken Restraints
	}, {
		[435012] = self.displayName,
		[442210] = CL.extra:format(self:SpellName(-28975), CL.mythic), -- Bloodstained Webmage
	}, {
		["bloodstained_webmage"] = CL.add_spawned, -- Bloodstained Webmage (Add spawned)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Impale", 435012)
	self:Log("SPELL_CAST_START", "BurrowCharge", 439506)
	self:Log("SPELL_CAST_SUCCESS", "Infestation", 433740)
	self:Log("SPELL_AURA_APPLIED", "InfestationApplied", 433740)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Eye of the Swarm
	self:Log("SPELL_CAST_START", "EyeOfTheSwarm", 433766)
	self:Log("SPELL_AURA_APPLIED", "EyeOfTheSwarmApplied", 434408)
	self:Log("SPELL_AURA_REMOVED", "EyeOfTheSwarmOver", 434408)
	self:Log("SPELL_AURA_APPLIED", "CeaselessSwarmApplied", 433781)
	self:Log("SPELL_AURA_APPLIED_DOSE", "CeaselessSwarmApplied", 433781)

	-- Bloodstained Webmage (Mythic)
	self:Log("SPELL_CAST_SUCCESS", "EncounterEvent", 181089) -- Bloodstained Webmage spawning
	self:Log("SPELL_CAST_START", "SilkenRestraints", 442210)
end

function mod:OnEngage()
	inBurrowChargeCombo = false
	burrowChargeRemaining = 1
	eyeOfTheSwarmCount = 1
	bloodstainedWebmageCount = 1
	self:SetStage(1)
	-- Infestation is cast immmediately on pull
	self:CDBar(435012, 4.6) -- Impale
	self:CDBar(439506, 14.3) -- Burrow Charge
	if self:Mythic() then
		self:CDBar("bloodstained_webmage", 17.5, CL.count:format(CL.add_spawning, bloodstainedWebmageCount), L.bloodstained_webmage_icon) -- Bloodstained Webmage
	end
	self:CDBar(433766, 29.1, CL.count:format(self:SpellName(433766), eyeOfTheSwarmCount)) -- Eye of the Swarm
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Impale(args)
	self:Message(args.spellId, "purple")
	if inBurrowChargeCombo then
		-- there is always an Impale cast at the end of Burrow Charge which occurs outside the usual Impale timer
		inBurrowChargeCombo = false
		self:CDBar(args.spellId, 5.8)
	else
		self:CDBar(args.spellId, 8.5)
	end
	-- 3.5s-5s minimum to Infestation
	-- this varies by difficulty because Impale cast time is 2.5s Mythic, 4s Normal/Heroic
	if self:Healer() then
		if self:Mythic() then
			if nextInfestation - args.time < 3.5 then
				nextInfestation = args.time + 3.5
				self:CDBar(433740, {3.5, 8.5}) -- Infestation
			end
		else -- Heroic, Normal
			if nextInfestation - args.time < 5.0 then
				nextInfestation = args.time + 5.0
				self:CDBar(433740, {5.0, 8.5}) -- Infestation
			end
		end
	end
	self:PlaySound(args.spellId, "alarm")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(439506, "orange", name)
		self:PlaySound(439506, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(439506, nil, nil, "Burrow Charge")
		end
	end

	function mod:BurrowCharge(args)
		inBurrowChargeCombo = true
		burrowChargeRemaining = burrowChargeRemaining - 1
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		if burrowChargeRemaining > 1 then
			self:CDBar(args.spellId, 30.2)
		else
			self:StopBar(args.spellId)
		end
		self:CDBar(435012, 4.8) -- Impale
		-- 8.5-9.8s minimum to Infestation
		-- this varies by difficulty because Impale cast time is 2.5s Mythic, 4s Normal/Heroic
		if self:Healer() then
			if self:Mythic() then
				nextInfestation = args.time + 8.5
				self:CDBar(433740, {8.5, 10.1}) -- Infestation
			else -- Heroic, Normal
				nextInfestation = args.time + 9.8
				self:CDBar(433740, {9.8, 10.1}) -- Infestation
			end
		end
	end
end

function mod:Infestation(args)
	if self:Healer() then
		if self:GetStage() == 1 then
			nextInfestation = args.time + 10.1
			self:CDBar(args.spellId, 10.1)
		else -- Stage 2
			nextInfestation = args.time + 8.5
			self:CDBar(args.spellId, 8.5)
		end
	end
end

function mod:InfestationApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Infestation")
	end
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("433779", nil, true) then -- Eye of the Swarm
		-- [CHAT_MSG_RAID_BOSS_EMOTE] Anub'zekt prepares to trap you within the |TInterface\\ICONS\\Spell_Shadow_UnholyFrenzy.blp:20|t |cFFFF0000|Hspell:433779|h[Eye of the Swarm]|h|r!#Anub'zekt
		-- boss runs to the center on this emote, these bars will be restarted when the cast begins
		if self:Healer() then
			self:StopBar(433740) -- Infestation
		end
		self:StopBar(435012) -- Impale
		self:StopBar(439506) -- Burrow Charge
		if self:Mythic() then
			self:StopBar(CL.count:format(CL.add_spawning, bloodstainedWebmageCount))
		end
	end
end

function mod:EyeOfTheSwarm(args)
	burrowChargeRemaining = 2
	self:StopBar(CL.count:format(args.spellName, eyeOfTheSwarmCount))
	self:SetStage(2)
	self:Message(args.spellId, "cyan", CL.count:format(args.spellName, eyeOfTheSwarmCount))
	eyeOfTheSwarmCount = eyeOfTheSwarmCount + 1
	if self:Healer() then
		nextInfestation = args.time + 7.3
		self:CDBar(433740, 7.3) -- Infestation
	end
	self:CDBar(435012, 10.9) -- Impale
	self:CDBar(439506, 46.9) -- Burrow Charge
	if self:Mythic() then
		self:CDBar("bloodstained_webmage", 49.8, CL.count:format(CL.add_spawning, bloodstainedWebmageCount), L.bloodstained_webmage_icon) -- Bloodstained Webmage
	end
	self:CDBar(args.spellId, 78.9, CL.count:format(args.spellName, eyeOfTheSwarmCount))
	self:PlaySound(args.spellId, "long")
end

function mod:EyeOfTheSwarmApplied(args)
	self:Bar(433766, 25, CL.onboss:format(args.spellName))
end

function mod:EyeOfTheSwarmOver(args)
	self:StopBar(CL.onboss:format(args.spellName))
	self:SetStage(1)
	self:Message(433766, "green", CL.over:format(args.spellName))
	self:PlaySound(433766, "info")
end

do
	local prev = 0
	function mod:CeaselessSwarmApplied(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then -- 1s application rate, but can apply 1 or 2 stacks at once
			prev = args.time
			self:StackMessage(args.spellId, "blue", args.destName, args.amount, 1)
			self:PlaySound(args.spellId, "underyou", nil, args.destName)
		end
	end
end

-- Bloodstained Webmage (Mythic)

function mod:EncounterEvent(args) -- Bloodstained Webmage spawning
	-- always spawns ~3s after Burrow Charge cast start, and there's an additional spawn ~17s after every even add spawn
	self:StopBar(CL.count:format(CL.add_spawning, bloodstainedWebmageCount))
	self:Message("bloodstained_webmage", "cyan", CL.count:format(CL.add_spawned, bloodstainedWebmageCount), L.bloodstained_webmage_icon)
	bloodstainedWebmageCount = bloodstainedWebmageCount + 1
	if bloodstainedWebmageCount % 2 == 1 then -- the 3rd, 5th, 7th... etc spawn
		self:CDBar("bloodstained_webmage", 17.4, CL.count:format(CL.add_spawning, bloodstainedWebmageCount), L.bloodstained_webmage_icon)
	end
	self:PlaySound("bloodstained_webmage", "info")
end

function mod:SilkenRestraints(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
