
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Xin the Weaponmaster", 994, 698)
if not mod then return end
mod:RegisterEnableMob(61398)
mod.engageId = 1441
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local stage = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.blades = -5972 -- Blade Trap
	L.blades_icon = 119311

	L.crossbows = -5974 -- Death From Above!
	L.crossbows_icon = 120142
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		119684, -- Ground Slam
		"blades",
		"crossbows",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GroundSlam", 119684)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
end

function mod:OnEngage()
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "StageWarn", "boss1")
	stage = 1
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GroundSlam(args)
	self:Message(args.spellId, "Urgent", "Alert", CL.casting:format(args.spellName), args.spellId)
	self:CastBar(args.spellId, 3)
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("119311", nil, true) then -- Stream of Blades (Blade Trap)
		self:Message("blades", "Attention", "Info", CL.percent:format(66, self:SpellName(L.blades)), 119311)
	elseif msg:find("120142", nil, true) then -- Crossbow (Death From Above!)
		self:Message("crossbows", "Attention", "Info", CL.percent:format(33, self:SpellName(L.crossbows)), 120142)
	end
end

function mod:StageWarn(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 70 and stage == 1 then
		self:Message("blades", "Positive", nil, CL.soon:format(self:SpellName(L.blades)), false)
		stage = 2
	elseif hp < 39 and stage == 2 then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		self:Message("crossbows", "Positive", nil, CL.soon:format(self:SpellName(L.crossbows)), false)
	end
end

