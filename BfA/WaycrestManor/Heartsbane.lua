if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Todo:
-- - Mark the boss with Focusing Iris?
--

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Heartsbane Triad", 1862, 2125)
if not mod then return end
mod:RegisterEnableMob(131825, 131823, 131824) -- Sister Briar, Sister Malady, Sister Solena
mod.engageId = 2113

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		260741, -- Jagged Nettles
		{260703, "SAY"}, -- Unstable Runic Mark
		260907, -- Soul Manipulation
		260805, -- Focusing Iris
		260773, -- Dire Ritual
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "JaggedNettles", 260741)
	-- self:Log("SPELL_CAST_SUCCESS", "UnstableRunicMark", 260703)
	self:Log("SPELL_AURA_APPLIED", "UnstableRunicMarkApplied", 260703)
	self:Log("SPELL_AURA_APPLIED", "SoulManipulation", 260907)
	self:Log("SPELL_AURA_APPLIED", "FocusingIris", 260805)
	self:Log("SPELL_CAST_START", "DireRitual", 260773)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:JaggedNettles(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 13.5)
end

-- function mod:UnstableRunicMark()
-- 	self:Bar(args.spellId, 13.5) XXX Need a timer
-- end

do
	local playerList = mod:NewTargetList()
	function mod:UnstableRunicMarkApplied(args)
		playerList[#playerList+1] = args.destName
		if self:Me(args.destGUID) then
			self:PlaySound(args.spellId, "alarm", nil, playerList)
			self:Say(args.spellId)
			self:Flash(args.spellId)
		end
		self:TargetsMessage(args.spellId, "orange", playerList)
	end
end

function mod:SoulManipulation(args)
	self:TargetMessage2(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	self:Bar(args.spellId, 24)
end

function mod:FocusingIris(args)
	self:TargetMessage2(args.spellId, "cyan", args.destName)
	self:PlaySound(args.spellId, "long", nil, args.destName)
	self:StopBar(260741) -- Jagged Nettles
	self:StopBar(260703) -- Unstable Runic Mark
	self:StopBar(260907) -- Soul Manipulation

	if self:MobId(args.destGUID) == 131825 then -- Sister Briar
		self:Bar(260741, 8.5)  -- Jagged Nettles
	elseif self:MobId(args.destGUID) == 131823 then -- Sister Malady
		self:Bar(260703, 9) -- Unstable Runic Mark
	elseif self:MobId(args.destGUID) == 131824 then -- Sister Solena
		self:Bar(260907, 10) -- Soul Manipulation
	end
end

function mod:DireRitual(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end
