-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Maiden of Grief", 599, 605)
if not mod then return end
mod:RegisterEnableMob(27975)
mod.engageId = 1996
--mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Locals
--

local playersIncapacitated, shouldBeTakingDamage = 0, false

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		59726, -- Shock of Sorrow
		59772, -- Storm of Grief
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ShockOfSorrow", 50760, 59726) -- normal, heroic
	self:Log("SPELL_AURA_APPLIED", "ShockOfSorrowDebuff", 50760, 59726)
	self:Log("SPELL_AURA_REMOVED", "ShockOfSorrowDebuffRemoved", 50760, 59726)
	self:Log("SPELL_PERIODIC_DAMAGE", "StormOfGrief", 50752, 59772) -- normal, heroic
	self:Log("SPELL_PERIODIC_MISSED", "StormOfGrief", 50752, 59772)
end

function mod:OnEngage()
	playersIncapacitated, shouldBeTakingDamage = 0, false
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:ShockOfSorrow(args)
	shouldBeTakingDamage = true
	self:MessageOld(59726, "red", "warning", CL.casting:format(args.spellName))
	self:Bar(59726, 4, CL.casting:format(args.spellName))
end

do
	local playerList = mod:NewTargetList()

	function mod:ShockOfSorrowDebuff(args)
		if bit.band(args.destFlags, 0x400) == 0 then return end -- COMBATLOG_OBJECT_TYPE_PLAYER

		playerList[#playerList + 1] = args.destName
		playersIncapacitated = playersIncapacitated + 1
		if #playerList == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.2, 59726, playerList, "orange")
			self:Bar(59726, args.spellId == 59726 and 10 or 6)
		end
	end

	function mod:ShockOfSorrowDebuffRemoved(args)
		if bit.band(args.destFlags, 0x400) == 0 then return end -- COMBATLOG_OBJECT_TYPE_PLAYER

		playersIncapacitated = playersIncapacitated - 1
		if playersIncapacitated == 0 then
			self:StopBar(args.spellName)
		end

		if self:Me(args.destGUID) then
			shouldBeTakingDamage = false
		end
	end
end

do
	local prev = 0
	function mod:StormOfGrief(args)
		if self:Me(args.destGUID) and not shouldBeTakingDamage then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:MessageOld(59772, "blue", "alert", CL.underyou:format(args.spellName))
			end
		end
	end
end
