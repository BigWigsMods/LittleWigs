
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Bonemaw", 1176, 1140)
if not mod then return end
mod:RegisterEnableMob(75452)
mod.engageId = 1679
mod.respawnTime = 33

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{153804, "FLASH"}, -- Inhale
		154175, -- Body Slam
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "InhaleIncUnitEvent", "boss1")
	self:Log("SPELL_CAST_SUCCESS", "Inhale", 153804)
	self:Log("SPELL_CAST_START", "BodySlam", 154175)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InhaleIncUnitEvent(_, _, _, spellId)
	if spellId == 154868 then
		-- Unit event is 1s faster than emote, but only works for first Inhale, so register Emote after that.
		self:InhaleInc()
		self:ScheduleTimer("Emote", 5, "InhaleInc", "153804")
	end
end

function mod:InhaleInc()
	self:MessageOld(153804, "orange", "warning", CL.incoming:format(self:SpellName(153804)))
	self:Flash(153804)
end

function mod:Inhale(args)
	self:CastBar(args.spellId, 9)
	self:MessageOld(args.spellId, "orange", "alarm")
end

function mod:BodySlam(args)
	self:MessageOld(args.spellId, "yellow", "alert")
end
