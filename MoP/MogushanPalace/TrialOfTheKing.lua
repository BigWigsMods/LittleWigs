
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Trial of the King", 994, 708)
if not mod then return end
-- Xin the Weaponmaster, Haiyan the Unstoppable, Ming the Cunning, Kuai the Brute
mod:RegisterEnableMob(61884, 61445, 61444, 61442)
mod.engageId = 1442
mod.respawnTime = 15

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		119922, -- Shockwave
		{-6017, "ICON"}, -- Ravage
		{-6024, "ICON"}, -- Conflagrate
		{120195, "ICON", "SAY", "FLASH"}, -- Meteor
		{123655, "HEALER"}, -- Traumatic Blow
	}, {
		[119922] = -6015, -- Kuai
		[-6024] = -6023, -- Haiyan
	}
end

function mod:VerifyEnable(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp > 15 then
		return true
	end
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TraumaticBlow", 123655)

	self:Log("SPELL_AURA_APPLIED", "Ravage", 119946)
	self:Log("SPELL_AURA_REMOVED", "RavageOver", 119946)

	self:Log("SPELL_AURA_APPLIED", "Conflagrate", 120160)
	self:Log("SPELL_AURA_REMOVED", "ConflagrateOver", 120160)

	self:Log("SPELL_CAST_START", "Shockwave", 119922)

	self:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "MeteorFinished", "boss1")

	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
end

function mod:OnEngage()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	self:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	local mobId = self:MobId(self:UnitGUID("boss1"))
	if mobId == 61445 then -- Haiyan the Unstoppable
		self:CDBar(120195, 40) -- Meteor
	elseif mobId == 61444 or mobId == 61442 then -- Ming the Cunning or Kuai the Brute
		self:StopBar(120195)
	end
end

function mod:TraumaticBlow(args)
	self:TargetMessageOld(args.spellId, args.destName, "green")
	self:TargetBar(args.spellId, 5, args.destName)
end

function mod:Ravage(args)
	self:TargetMessageOld(-6017, args.destName, "yellow", nil, args.spellId)
	self:TargetBar(-6017, 11, args.destName, args.spellId)
	self:PrimaryIcon(-6017, args.destName)
end

function mod:RavageOver()
	self:PrimaryIcon(-6017)
end

function mod:Conflagrate(args)
	self:TargetMessageOld(-6024, args.destName, "yellow", nil, args.spellId)
	self:TargetBar(-6024, 5, args.destName, args.spellId)
	self:SecondaryIcon(-6024, args.destName)
end

function mod:ConflagrateOver()
	self:SecondaryIcon(-6024)
end

function mod:Shockwave(args)
	self:MessageOld(args.spellId, "orange", "alert", CL.casting:format(args.spellName), args.spellId)
	self:Bar(args.spellId, 2, CL.cast:format(args.spellName), args.spellId)
end

function mod:MeteorFinished(_, _, _, spellId)
	if spellId == 120195 then
		self:PrimaryIcon(spellId)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, player)
	if msg:find("meteorstorm", nil, true) then -- |TInterface\\Icons\\spell_fire_meteorstorm.blp:20|tHaiyan the Unstoppable targets |cFFFF0000PLAYER|r with a |cFFFF0000|Hspell:120195|h[Meteor]|h|r!
		self:TargetMessageOld(120195, player, "red", "alarm")
		self:TargetBar(120195, 5, player)
		self:PrimaryIcon(120195, player)
		if UnitIsUnit(player, "player") then
			self:Flash(120195)
			self:Say(120195)
		end
	end
end

