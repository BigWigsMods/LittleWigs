
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Priestess Delrissa", 585, 532)
if not mod then return end
mod:RegisterEnableMob(24553, -- Apoko
	24554, -- Eramas Brightblaze
	24555, -- Garaxxas
	24556, -- Zelfan
	24557, -- Kagani Nightstrike
	24558, -- Ellrys Duskhallow
	24559, -- Warlord Salaris
	24560, -- Priestess Delrissa
	24561 -- Yazzai
)
mod.engageId = 1895
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Locals
--

local deaths = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Priestess Delrissa
		46192, -- Renew
		46193, -- Power Word: Shield
		-- Apoko
		27621, -- Windfury Totem
		-- Yazzai
		44178, -- Blizzard
		13323, -- Polymorph
		-- Ellrys Duskhallow
		{44141, "ICON"}, -- Seed of Corruption
	}, {
		[46192] = self.displayName, -- Priestess Delrissa
		[27621] = -5104, -- Apoko
		[44178] = -5101, -- Yazzai
		[44141] = -5099, -- Ellrys Duskhallow
	}
end

function mod:OnBossEnable()
	-- Priestess Delrissa
	self:Log("SPELL_AURA_APPLIED", "Renew", 44174, 46192) -- normal, heroic
	self:Log("SPELL_AURA_APPLIED", "PowerWordShield", 44291, 46193) -- normal, heroic

	-- Apoko
	self:Log("SPELL_CAST_SUCCESS", "WindfuryTotem", 27621)

	-- Yazzai
	self:Log("SPELL_CAST_SUCCESS", "Blizzard", 44178, 46195) -- normal, heroic
	self:Log("SPELL_AURA_APPLIED", "Polymorph", 13323)

	-- Ellrys Duskhallow
	self:Log("SPELL_AURA_APPLIED", "SeedOfCorruption", 44141)

	-- General _AURA_REMOVED events:
	self:Log("SPELL_AURA_REMOVED", "Removed", 13323, 44141, 44174, 46192) -- Polymorh, Seed of Corruption, normal/heroic Renew
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Priestess Delrissa
function mod:Renew(args)
	self:TargetMessage(46192, args.destName, "Attention")
	self:TargetBar(46192, 15, args.destName)
end

function mod:PowerWordShield(args)
	self:TargetMessage(46193, args.destName, "Attention")
end

-- Apoko
function mod:WindfuryTotem(args)
	self:Message(args.spellId, "Attention")
end

-- Yazzai
function mod:Blizzard(args)
	self:Message(44178, "Important", nil, CL.casting:format(args.spellName))
end

function mod:Polymorph(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent")
	self:TargetBar(args.spellId, 8, args.destName)
end

-- Ellrys Duskhallow
function mod:SeedOfCorruption(args)
	self:TargetMessage(args.spellId, args.destName, "Important")
	self:TargetBar(args.spellId, 18, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

-- General _AURA_REMOVED events:
function mod:Removed(args)
	if args.spellId == 44141 then -- Seed of Corruption
		self:PrimaryIcon(args.spellId)
	end
	self:StopBar(args.spellName, args.destName)
end
