-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("High Priest Venoxis", 859, 175)
if not mod then return end
mod:RegisterEnableMob(52155)
mod:SetEncounterID(1178)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
--  Locals
--

local breathsLeft = 3

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{96477, "ICON"}, -- Toxic Link
		96509, -- Breath of Hethiss
		96466, -- Whispers of Hethiss
		96842, -- Bloodvenom
		96653, -- Venom Withdrawal (triggered by 96512)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ToxicLink", 96475)
	self:Log("SPELL_AURA_APPLIED", "ToxicLinkApplied", 96477)
	self:Log("SPELL_AURA_REMOVED", "ToxicLinkRemoved", 96477)
	self:Log("SPELL_CAST_START", "BreathOfHethiss", 96509)
	self:Log("SPELL_AURA_APPLIED", "WhispersOfHethiss", 96466)
	self:Log("SPELL_AURA_REMOVED", "WhispersOfHethissRemoved", 96466)
	self:Log("SPELL_CAST_START", "Bloodvenom", 96842)
	self:Log("SPELL_AURA_APPLIED", "BlessingOfTheSnakeGod", 96512)
	self:Log("SPELL_AURA_REMOVED", "BlessingOfTheSnakeGodRemoved", 96512)
end

function mod:OnEngage()
	breathsLeft = 3
end

-------------------------------------------------------------------------------
--  Event Handlers
--

do
	local playerList = {}

	function mod:ToxicLink()
		playerList = {}
	end

	function mod:ToxicLinkApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "yellow", playerList, 2)
		if #playerList == 1 then
			self:PrimaryIcon(args.spellId, args.destName)
		else
			self:SecondaryIcon(args.spellId, args.destName)
		end
		if self:Me(args.destGUID) then
			self:PlaySound(args.spellId, "alarm")
		end
	end

	function mod:ToxicLinkRemoved(args)
		self:PrimaryIcon(args.spellId)
		self:SecondaryIcon(args.spellId)
	end
end

function mod:BreathOfHethiss(args)
	self:Message(args.spellId, "red")
	breathsLeft = breathsLeft - 1
	if breathsLeft > 0 then
		self:CDBar(args.spellId, 13.0)
	else
		self:StopBar(args.spellId)
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:WhispersOfHethiss(args)
	if self:MobId(args.destGUID) == 52155 then return end -- applies this to himself as well
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:TargetBar(args.spellId, 8, args.destName)
	self:PlaySound(args.spellId, "alert")
end

function mod:WhispersOfHethissRemoved(args)
	if self:MobId(args.destGUID) == 52155 then return end -- applies this to himself as well
	self:StopBar(args.spellName, args.destName)
end

function mod:Bloodvenom(args)
	self:StopBar(96509) -- Breath of Hethiss
	self:StopBar(args.spellId)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end

function mod:BlessingOfTheSnakeGod()
	breathsLeft = 3
	self:CDBar(96509, 5.5) -- Breath of Hethiss
	self:CDBar(96842, 38) -- Bloodvenom
end

function mod:BlessingOfTheSnakeGodRemoved()
	self:Message(96653, "green") -- Venom Withdrawal
	self:Bar(96653, 10, CL.onboss:format(self:SpellName(96653)))
	self:PlaySound(96653, "info")
end
