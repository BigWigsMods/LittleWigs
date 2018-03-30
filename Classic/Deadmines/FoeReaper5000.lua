
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Foe Reaper 5000", 36, 91)
if not mod then return end
mod:RegisterEnableMob(43778)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		88481, -- Overdrive
		{88495, "SAY", "FLASH"}, -- Harvest
		88522, -- Safety Restrictions Off-line
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "Overdrive", 88481)
	self:Log("SPELL_CAST_START", "Harvest", 88495)
	self:Log("SPELL_CAST_SUCCESS", "SafetyRestrictionsOffline", 88522)

	self:Death("Win", 43778)
end

function mod:OnEngage()
	self:Bar(88481, 10)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Overdrive(args)
	self:Message(args.spellId, "Urgent", "Alarm")
	self:Bar(args.spellId, 53)
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Flash(88495)
			self:Say(88495)
		end
		self:TargetMessage(88495, player, "Important", "Alert")
	end
	function mod:Harvest(args)
		self:Bar(args.spellId, 56)
		self:GetBossTarget(printTarget, 0.2, args.sourceGUID)
	end
end

function mod:SafetyRestrictionsOffline(args) -- Enrage
	self:Message(args.spellId, "Attention", "Long", self:SpellName(8599)) -- 8599 = "Enrage"
end

