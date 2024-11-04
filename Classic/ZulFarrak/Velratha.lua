--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hydromancer Velratha", 209, 482)
if not mod then return end
mod:RegisterEnableMob(7795) -- Hydromancer Velratha
mod:SetEncounterID(593)
--mod:SetRespawnTime(0) -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		15982, -- Healing Wave
		78802, -- Crashing Wave
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "HealingWave", 15982)
	self:Log("SPELL_INTERRUPT", "HealingWaveInterrupt", 15982)
	self:Log("SPELL_CAST_SUCCESS", "HealingWaveSuccess", 15982)
	self:Log("SPELL_CAST_START", "CrashingWave", 78802)
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 7795)
	end
end

function mod:OnEngage()
	self:CDBar(78802, 8.5) -- Crashing Wave
end

--------------------------------------------------------------------------------
-- Vanilla Initialization
--

if mod:Vanilla() then
	function mod:GetOptions()
		return {
			12491, -- Healing Wave
			15245, -- Shadow Bolt Volley
		}
	end

	function mod:OnBossEnable()
		self:Log("SPELL_CAST_START", "HealingWave", 12491)
		self:Log("SPELL_CAST_START", "ShadowBoltVolley", 15245)
	end

	function mod:OnEngage()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:HealingWave(args)
	if self:MobId(args.sourceGUID) == 7795 then -- Hydromancer Velratha
		-- on Retail this is only cast when the boss is below 50% health
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:HealingWaveInterrupt(args)
	if self:MobId(args.destGUID) == 7795 then -- Hydromancer Velratha
		self:CDBar(15982, 10.4)
	end
end

function mod:HealingWaveSuccess(args)
	if self:MobId(args.sourceGUID) == 7795 then -- Hydromancer Velratha
		self:CDBar(args.spellId, 10.4)
	end
end

function mod:CrashingWave(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 8.5)
	self:PlaySound(args.spellId, "alarm")
end

--------------------------------------------------------------------------------
-- Vanilla Event Handlers
--

function mod:ShadowBoltVolley(args)
	if self:MobId(args.sourceGUID) == 7795 then -- Hydromancer Velratha
		self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alarm")
	end
end
