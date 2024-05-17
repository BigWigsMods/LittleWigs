--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Trial of the King", 994, 708)
if not mod then return end
mod:RegisterEnableMob(
	61884, -- Xin the Weaponmaster
	61442, -- Kuai the Brute
	61444, -- Ming the Cunning
	61445 -- Haiyan the Unstoppable
)
mod:SetEncounterID(1442)
mod:SetRespawnTime(15)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local bossesEngaged = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Kuai the Brute
		119922, -- Shockwave
		-6017, -- Ravage
		-- Ming the Cunning
		119981, -- Whirling Dervish
		120100, -- Magnetic Field
		-- Haiyan the Unstoppable
		-6024, -- Conflagrate
		{120195, "SAY"}, -- Meteor
		{123655, "TANK_HEALER"}, -- Traumatic Blow
	}, {
		[119922] = -6015, -- Kuai the Brute
		[119981] = -6019, -- Ming the Cunning
		[-6024] = -6023, -- Haiyan the Unstoppable
	}
end

function mod:OnBossEnable()
	-- Kuai the Brute
	self:Log("SPELL_CAST_START", "Shockwave", 119922)
	self:Log("SPELL_CAST_SUCCESS", "Ravage", 119946)
	self:Death("MuShibaDeath", 61453)

	-- Ming the Cunning
	self:Log("SPELL_CAST_START", "WhirlingDervish", 119981)
	self:Log("SPELL_CAST_START", "MagneticField", 120100)

	-- Haiyan the Unstoppable
	self:Log("SPELL_CAST_START", "Conflagrate", 120160)
	self:Log("SPELL_AURA_APPLIED", "ConflagrateApplied", 120160)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Meteor
	self:Log("SPELL_CAST_SUCCESS", "TraumaticBlow", 123655)
end

function mod:VerifyEnable(unit)
	return self:GetHealth(unit) > 15
end

function mod:OnEngage()
	bossesEngaged = 0
	self:SetStage(1)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	self:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	local mobId = self:MobId(self:UnitGUID("boss1"))
	if mobId == 61442 then -- Kuai the Brute
		bossesEngaged = bossesEngaged + 1
		self:SetStage(bossesEngaged)
		self:CDBar(119922, 15.8) -- Shockwave
		self:CDBar(-6017, 18.6) -- Ravage
	elseif mobId == 61444 then -- Ming the Cunning
		bossesEngaged = bossesEngaged + 1
		self:SetStage(bossesEngaged)
		self:CDBar(119981, 22.7) -- Whirling Dervish
		self:CDBar(120100, 40.9) -- Magnetic Field
	elseif mobId == 61445 then -- Haiyan the Unstoppable
		bossesEngaged = bossesEngaged + 1
		self:SetStage(bossesEngaged)
		self:CDBar(-6024, 21.0) -- Conflagrate
		self:CDBar(120195, 40.6) -- Meteor
		self:CDBar(123655, 7.6) -- Traumatic Blow
	else
		-- no bosses active, clean up bars
		self:StopBar(-6017) -- Ravage
		self:StopBar(119922) -- Shockwave
		self:StopBar(119981) -- Whirling Dervish
		self:StopBar(120100) -- Magnetic Field
		self:StopBar(-6024) -- Conflagrate
		self:StopBar(120195) -- Meteor
		self:StopBar(123655) -- Traumatic Blow
	end
end

-- Kuai the Brute

function mod:Ravage(args)
	self:TargetMessage(-6017, "yellow", args.destName, nil, args.spellId)
	self:PlaySound(-6017, "alarm", nil, args.destName)
	self:CDBar(-6017, 10.9)
end

function mod:Shockwave(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 10.9)
end

function mod:MuShibaDeath(args)
	self:StopBar(-6017) -- Ravage
end

-- Ming the Cunning

function mod:WhirlingDervish(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 21.9)
end

function mod:MagneticField(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 42.6)
end

-- Haiyan the Unstoppable

function mod:Conflagrate(args)
	self:CDBar(-6024, 20.6)
end

function mod:ConflagrateApplied(args)
	self:TargetMessage(-6024, "yellow", args.destName, nil, args.spellId)
	self:PlaySound(-6024, "alert", nil, args.destName)
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, player)
	-- using the emote lets us find the targeted player sooner
	if msg:find("meteorstorm", nil, true) then -- |TInterface\\Icons\\spell_fire_meteorstorm.blp:20|tHaiyan the Unstoppable targets |cFFFF0000PLAYER|r with a |cFFFF0000|Hspell:120195|h[Meteor]|h|r!
		self:TargetMessage(120195, "red", player)
		self:PlaySound(120195, "alarm", nil, player)
		self:CDBar(120195, 43.6)
		if UnitIsUnit(player, "player") then
			self:Yell(120195, nil, nil, "Meteor")
		end
	end
end

function mod:TraumaticBlow(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	self:CDBar(args.spellId, 15.8)
end
