
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Priestess Delrissa", 798, 532)
if not mod then return end
mod:RegisterEnableMob(24553,24554,24555,24556,24557,24558,24559,24560,24561)

local deaths = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		46192, -- Renew
		46193, -- Power Word: Shield
		27621, -- Apoko: Windfury Totem
		44178, -- Yazzai: Blizzard
		13323, -- Yazzai: Polymorph
		{44141, "ICON"}, -- Ellrys: Seed of Corruption
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "PriShield", 46193, 44175, 44291)
	self:Log("SPELL_AURA_APPLIED", "PriRenew", 44174, 46192)
	self:Log("SPELL_CAST_SUCCESS", "ApokoWF", 27621)
	self:Log("SPELL_AURA_APPLIED", "EllrysSoC", 44141)
	self:Log("SPELL_AURA_APPLIED", "YazzaiPoly", 13323)
	self:Log("SPELL_CAST_SUCCESS", "YazzaiBliz", 44178, 46195)
	self:Log("SPELL_AURA_REMOVED", "Removed", 13323, 44141, 44174, 46192)
	self:Death("Deaths", 24553, 24554, 24555, 24556, 24557, 24558, 24559, 24560, 24561)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
end

function mod:OnEngage()
	deaths = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PriShield(args)
	self:TargetMessage(46193, args.destName, "Attention")
end

function mod:PriRenew(args)
	self:TargetMessage(46192, args.destName, "Attention")
	self:TargetBar(46192, 15, args.destName)
end

function mod:ApokoWF(args)
	self:Message(args.spellId, "Attention")
end

function mod:EllrysSoC(args)
	self:TargetMessage(args.spellId, args.destName, "Important")
	self:TargetBar(args.spellId, 18, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:YazzaiPoly(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent")
	self:TargetBar(args.spellId, 8, args.destName)
end

function mod:YazzaiBliz(args)
	self:Message(44178, "Important", nil, CL.casting:format(args.spellName))
end

function mod:Removed(args)
	if args.spellId == 44141 then -- Seed of Corruption
		self:PrimaryIcon(args.spellId)
	end
	self:StopBar(args.spellName, args.destName)
end

function mod:Deaths()
	deaths = deaths + 1
	if deaths == 5 then
		self:Win()
	end
end

