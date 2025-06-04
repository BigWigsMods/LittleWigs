--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Foe Reaper 5000", {36, 2849}, 91)
if not mod then return end
mod:RegisterEnableMob(43778) -- Foe Reaper 5000
mod:SetEncounterID(mod:Classic() and 1063 or {2975, 2980}) -- Classic, Retail Normal, Retail Heroic
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		88481, -- Overdrive
		{88495, "SAY", "ME_ONLY_EMPHASIZE"}, -- Harvest
		88522, -- Safety Restrictions Off-line
	}
end

function mod:OnBossEnable()
	if self:Retail() then
		if self:Difficulty() == 232 then -- Dastardly Duos
			-- no encounter events in Dastardly Duos
			self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
			self:Death("Win", 43778) -- Foe Reaper 5000
		else
			-- no ENCOUNTER_END on boss reset in Retail since 11.0.5
			self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		end
	end
	self:Log("SPELL_CAST_START", "Overdrive", 88481)
	self:Log("SPELL_CAST_START", "Harvest", 88495)
	self:Log("SPELL_CAST_SUCCESS", "SafetyRestrictionsOffline", 88522)
end

function mod:OnEngage()
	self:SetStage(1)
	if self:Normal() then
		self:CDBar(88481, 6.0) -- Overdrive
		self:CDBar(88495, 30.3) -- Harvest
	else
		self:CDBar(88481, 10.9) -- Overdrive
		self:CDBar(88495, 35.1) -- Harvest
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Overdrive(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	if self:Normal() then
		self:CDBar(args.spellId, 43.5)
	else
		self:CDBar(args.spellId, 53.3)
	end
end

do
	local function printTarget(self, player, guid)
		self:TargetMessage(88495, "red", player)
		self:PlaySound(88495, "alert", nil, player)
		if self:Me(guid) then
			self:Say(88495, nil, nil, "Harvest")
		end
	end

	function mod:Harvest(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		if self:Normal() then
			self:CDBar(args.spellId, 41.2)
		else
			self:CDBar(args.spellId, 55.8)
		end
	end
end

function mod:SafetyRestrictionsOffline(args)
	self:SetStage(2)
	self:Message(args.spellId, "cyan", CL.percent:format(30, args.spellName))
	self:PlaySound(args.spellId, "long")
end
