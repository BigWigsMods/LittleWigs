-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("High Priest Venoxis", 859, 175)
if not mod then return end
mod:RegisterEnableMob(52155)
mod.engageId = 1178
mod.respawnTime = 30

--------------------------------------------------------------------------------
--  Locals
--

local breathsLeft = 2

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{96477, "ICON", "FLASH"}, -- Toxic Link
		96509, -- Breath of Hethiss
		96466, -- Whispers of Hethiss
		96842, -- Bloodvenom
		96653, -- Venom Withdrawal (triggered by 96512)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ToxicLink", 96477)
	self:Log("SPELL_AURA_REMOVED", "ToxicLinkRemoved", 96477)
	self:Log("SPELL_AURA_APPLIED", "BreathOfHethiss", 96509)
	self:Log("SPELL_AURA_APPLIED", "WhispersOfHethiss", 96466)
	self:Log("SPELL_AURA_REMOVED", "WhispersOfHethissRemoved", 96466)
	self:Log("SPELL_CAST_START", "Bloodvenom", 96842)
	self:Log("SPELL_AURA_APPLIED", "BlessingOfTheSnakeGod", 96512)
	self:Log("SPELL_AURA_REMOVED", "BlessingOfTheSnakeGodRemoved", 96512)
end

function mod:OnEngage()
	breathsLeft = 2
end

-------------------------------------------------------------------------------
--  Event Handlers
--

do
	local linkTargets = mod:NewTargetList()

	function mod:ToxicLink(args)
		if self:Me(args.destGUID) then
			self:Flash(args.spellId)
		end
		linkTargets[#linkTargets + 1] = args.destName
		if #linkTargets == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.2, args.spellId, linkTargets, "orange", "alarm")
			self:PrimaryIcon(args.spellId, args.destName)
		else
			self:SecondaryIcon(args.spellId, args.destName)
		end
	end

	function mod:ToxicLinkRemoved(args)
		self:PrimaryIcon(args.spellId)
		self:SecondaryIcon(args.spellId)
	end
end

function mod:BreathOfHethiss(args)
	breathsLeft = breathsLeft - 1
	self:MessageOld(args.spellId, "red")
	if (breathsLeft > 0) then
		self:CDBar(args.spellId, 12)
	end
end

function mod:WhispersOfHethiss(args)
	if self:MobId(args.destGUID) == 52155 then return end -- applies this to himself as well
	self:MessageOld(args.spellId, "orange", "alert", CL.casting:format(args.spellName))
	self:TargetBar(args.spellId, 8, args.destName)
end

function mod:WhispersOfHethissRemoved(args)
	if self:MobId(args.destGUID) == 52155 then return end -- applies this to himself as well
	self:StopBar(args.spellName, args.destName)
end

function mod:Bloodvenom(args)
	self:MessageOld(args.spellId, "red", "alert", CL.casting:format(args.spellName))
	self:ScheduleTimer("Bar", 3, args.spellId, 14)
end

function mod:BlessingOfTheSnakeGod()
	breathsLeft = 2
	self:CDBar(96842, 38) -- Bloodvenom
	self:CDBar(96509, 5.5) -- Breath of Hethiss
end

function mod:BlessingOfTheSnakeGodRemoved()
	self:MessageOld(96653, "green", "info") -- Venom Withdrawal
	self:Bar(96653, 10)
end
