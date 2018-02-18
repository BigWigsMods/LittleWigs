-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Maiden of Grief", 526, 605)
if not mod then return end
--mod.otherMenu = "The Storm Peaks"
mod:RegisterEnableMob(27975)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		50760, --Shock of Sorrow
	}
end

function mod:OnEnable()
	self:Log("SPELL_CAST_START", "ShockOfSorrow", 50760, 59726)
	self:Log("SPELL_AURA_APPLIED", "ShockOfSorrowDebuff", 50760, 59726)
	self:Death("Win", 27975)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:ShockOfSorrow(args)
	self:Message(50760, "Urgent", nil, CL.casting:format(args.spellName))
	self:Bar(50760, 4, CL.casting:format(args.spellName))
end

do
	local playerList = mod:NewTargetList()

	local function printTargets(self, duration)
		self:TargetMessage(50760, playerList, "Urgent")
		self:Bar(50760, duration)
	end

	function mod:ShockOfSorrowDebuff(args)
		playerList[#playerList + 1] = player
		if #playerList == 1 then
			self:ScheduleTimer(printTargets, 0.2, self, args.spellId == 59726 and 10 or 6)
		end
	end
end
