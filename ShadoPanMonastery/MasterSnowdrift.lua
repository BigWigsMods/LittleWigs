
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Master Snowdrift", 877, 657)
mod:RegisterEnableMob(56541)

local phase = 1
local canEnable = true

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "Very well then, outsiders. Let us see your true strength."
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {106434, {106434, "FLASHSHAKE", "SAY"}, "bosskill"}
end

function mod:VerifyEnable()
	return canEnable
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "TornadoKick", 106434)
	self:Log("SPELL_AURA_APPLIED", "ChaseDown", 106434)
	self:Log("SPELL_AURA_REMOVED", "ChaseDownRemoved", 106434)

	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
end

function mod:OnEngage()
	self:RegisterEvent("UNIT_HEALTH_FREQUENT")
	local tornado = GetSpellInfo(106434)
	self:Bar(106434, "~"..tornado, 15, 106434)
	self:Message(106434, CL["custom_start"]:format(self.displayName, tornado, 15), "Attention")
	phase = 1
end

function mod:OnWin()
	canEnable = false
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TornadoKick(_, spellId, _, _, spellName)
	self:Message(spellId, spellName, "Urgent", spellId, "Alert")
	self:Bar(spellId, CL["cast"]:format(spellName), 5, spellId)
end

function mod:ChaseDown(player, spellId, _, _, spellName)
	self:TargetMessage(spellId, spellName, player, "Important", spellId, "Alarm")
	self:Bar(spellId, CL["other"]:format(spellName, player), 11, spellId)
	if UnitIsUnit("player", player) then
		self:FlashShake(spellId)
		self:Say(spellId, CL["say"]:format(spellName))
	end
end

function mod:ChaseDownRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, CL["other"]:format(spellName, player))
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, unitId, _, _, _, spellId)
	if unitId == "boss1" then
		if spellId == 110324 then -- Shado-pan Vanish
			if phase == 1 then
				phase = 2
				self:Message("bosskill", (CL["phase"]:format(2))..": "..GetSpellInfo(109126), "Positive", nil, "Info")
				self:RegisterEvent("UNIT_HEALTH_FREQUENT")
			else -- 109126 == Mirror Images
				self:Message("bosskill", (GetSpellInfo(109126)), "Positive")
			end
		elseif spellId == 106743 then -- Shado-pan Teleport
			self:Message("bosskill", CL["phase"]:format(3), "Positive", nil, "Info")
		elseif spellId == 50630 then -- Eject All Passengers
			self:Win()
		end
	end
end

function mod:UNIT_HEALTH_FREQUENT(_, unitId)
	if unitId == "boss1" then
		local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
		if hp < 65 and phase == 1 then
			self:Message("bosskill", CL["soon"]:format(CL["phase"]:format(2)), "Positive")
			self:UnregisterEvent("UNIT_HEALTH_FREQUENT")
		elseif hp < 35 and phase == 2 then
			self:Message("bosskill", CL["soon"]:format(CL["phase"]:format(3)), "Positive")
			self:UnregisterEvent("UNIT_HEALTH_FREQUENT")
		end
	end
end

