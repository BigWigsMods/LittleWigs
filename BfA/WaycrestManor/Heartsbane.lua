
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Heartsbane Triad", 1862, 2125)
if not mod then return end
mod:RegisterEnableMob(131825, 131823, 131824) -- Sister Briar, Sister Malady, Sister Solena
mod.engageId = 2113
mod.respawnTime = 20

--------------------------------------------------------------------------------
-- Locals
--

local playersWithRunicMark = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{260805, "ICON"}, -- Focusing Iris
		260773, -- Dire Ritual
		260741, -- Jagged Nettles
		{260703, "SAY", "SAY_COUNTDOWN", "FLASH", "PROXIMITY"}, -- Unstable Runic Mark
		268086, -- Aura of Dread
		{260926, "ICON"}, -- Soul Manipulation
	}, {
		[260805] = "general",
		[260741] = -17738, -- Sister Briar,
		[260703] = -17739, -- Sister Malady
		[260926] = -17740, -- Sister Solena
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "JaggedNettles", 260741)
	self:Log("SPELL_CAST_SUCCESS", "UnstableRunicMark", 260703)
	self:Log("SPELL_AURA_APPLIED", "UnstableRunicMarkApplied", 260703)
	self:Log("SPELL_AURA_REMOVED", "UnstableRunicMarkRemoved", 260703)
	self:Log("SPELL_AURA_APPLIED", "SoulManipulation", 260926)
	self:Log("SPELL_AURA_REMOVED", "SoulManipulationRemovedFromBoss", 260923)
	self:Log("SPELL_AURA_APPLIED_DOSE", "AuraOfDread", 268086)
	self:Log("SPELL_AURA_APPLIED", "FocusingIris", 260805)
	self:Log("SPELL_CAST_START", "DireRitual", 260773)
end

function mod:OnEngage()
	playersWithRunicMark = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, name, guid)
		self:TargetMessage2(260741, "orange", name) -- Jagged Nettles
		self:PlaySound(260741, "alarm", nil, name) -- Jagged Nettles
	end

	function mod:JaggedNettles(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:Bar(args.spellId, 13.5)
	end
end

function mod:UnstableRunicMark(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	-- self:Bar(args.spellId, 13.5) XXX Need a timer
end

function mod:UnstableRunicMarkApplied(args)
	playersWithRunicMark = playersWithRunicMark + 1
	if playersWithRunicMark == 1 then
		self:OpenProximity(args.spellId, 6)
	end
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, 6)
		self:Flash(args.spellId)
	end
end

function mod:UnstableRunicMarkRemoved(args)
	playersWithRunicMark = playersWithRunicMark - 1
	if playersWithRunicMark == 0 then
		self:CloseProximity(args.spellId)
	end
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:SoulManipulation(args)
	self:TargetMessage2(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	self:PrimaryIcon(args.spellId, args.destName) -- Move icon from boss to player
end

function mod:SoulManipulationRemovedFromBoss(args)
	-- Move the icon away from the player and back to the boss
	self:PrimaryIcon(260805, self:GetBossId(args.destGUID)) -- Focusing Iris
end

function mod:AuraOfDread(args)
	if self:Me(args.destGUID) then
		if args.amount % 3 == 0 or args.amount > 6 then
			self:StackMessage(args.spellId, args.destName, args.amount, "blue")
			self:PlaySound(args.spellId, args.amount > 6 and "warning" or "alert")
		end
	end
end

function mod:FocusingIris(args)
	self:Message2(args.spellId, "cyan", CL.other:format(args.spellName, args.destName))
	self:PlaySound(args.spellId, "long")
	self:PrimaryIcon(args.spellId, self:GetBossId(args.destGUID))
	self:StopBar(260741) -- Jagged Nettles
	self:StopBar(260703) -- Unstable Runic Mark

	if self:MobId(args.destGUID) == 131825 then -- Sister Briar
		self:Bar(260741, 8.5)  -- Jagged Nettles
	elseif self:MobId(args.destGUID) == 131823 then -- Sister Malady
		self:Bar(260703, 9) -- Unstable Runic Mark
	end
end

function mod:DireRitual(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end
