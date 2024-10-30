--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("General Umbriss", 670, 131)
if not mod then return end
if mod:Retail() then
	mod:SetJournalID(2617) -- Journal ID was changed in The War Within
end
mod:RegisterEnableMob(39625) -- General Umbriss
mod:SetEncounterID(1051)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local commandingRoarCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		448847, -- Commanding Roar
		448877, -- Rock Spike
		{447261, "TANK_HEALER"}, -- Skullsplitter
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CommandingRoar", 448847)
	self:Log("SPELL_CAST_START", "RockSpike", 448877)
	self:Log("SPELL_CAST_START", "Skullsplitter", 447261)
end

function mod:OnEngage()
	commandingRoarCount = 1
	self:CDBar(448847, 6.0, CL.count:format(self:SpellName(448847), commandingRoarCount)) -- Commanding Roar
	self:CDBar(448877, 16.0) -- Rock Spike
	self:CDBar(447261, 24.0) -- Skullsplitter
end

function mod:VerifyEnable()
	-- don't enable if the player is still flying around in a drake
	return not UnitInVehicle("player")
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			{74670, "ICON"}, -- Blitz
			74634, -- Ground Siege
			74853, -- Frenzy
			74846, -- Wound
		}
	end

	function mod:OnBossEnable()
		self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
		self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE", "Blitz")

		self:Log("SPELL_CAST_START", "Siege", 74634)
		self:Log("SPELL_AURA_APPLIED", "Frenzy", 74853)
		self:Log("SPELL_AURA_APPLIED", "Wound", 74846)
		self:Log("SPELL_AURA_REMOVED", "WoundRemoved", 74846)
	end

	function mod:OnEngage()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CommandingRoar(args)
	self:StopBar(CL.count:format(args.spellName, commandingRoarCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, commandingRoarCount))
	self:PlaySound(args.spellId, "long")
	commandingRoarCount = commandingRoarCount + 1
	self:CDBar(args.spellId, 25.0, CL.count:format(args.spellName, commandingRoarCount))
end

function mod:RockSpike(args)
	-- impossible to get targets, aura 448870 is hidden
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 25.0)
end

function mod:Skullsplitter(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 25.0)
end

--------------------------------------------------------------------------------
-- Classic Event Handlers
--

function mod:Blitz(_, msg, _, _, _, player)
	if msg:find(self:SpellName(74670)) then
		if player then
			self:TargetMessage(74670, "red", player)
			self:PlaySound(74670, "alert", nil, player)
			self:PrimaryIcon(74670, player)
			self:ScheduleTimer("PrimaryIcon", 3.5, 74670)
		else
			self:Message(74670, "red")
			self:PlaySound(74670, "alert")
		end
	end
end

function mod:Siege(args)
	self:Message(args.spellId, "orange")
end

function mod:UNIT_HEALTH(event, unit)
	if self:GetHealth(unit) < 36 then
		self:UnregisterUnitEvent(event, unit)
		self:Message(74853, "cyan", CL.soon:format(self:SpellName(74853)))
	end
end

function mod:Frenzy(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
end

function mod:Wound(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:WoundRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
