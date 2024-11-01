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
	self:Log("SPELL_AURA_APPLIED", "Infestation", 433740)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:Log("SPELL_CAST_START", "EyeOfTheSwarm", 433766)
	self:Log("SPELL_AURA_APPLIED", "EyeOfTheSwarmApplied", 434408)
	self:Log("SPELL_AURA_REMOVED", "EyeOfTheSwarmOver", 434408)

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
	end
end

function mod:Infestation(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	--self:CDBar(args.spellId, 8.1)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Infestation")
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("433779", nil, true) then -- Eye of the Swarm
		-- [CHAT_MSG_RAID_BOSS_EMOTE] Anub'zekt prepares to trap you within the |TInterface\\ICONS\\Spell_Shadow_UnholyFrenzy.blp:20|t |cFFFF0000|Hspell:433779|h[Eye of the Swarm]|h|r!#Anub'zekt
		-- boss runs to the center on this emote, these bars will be restarted when the cast begins
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
