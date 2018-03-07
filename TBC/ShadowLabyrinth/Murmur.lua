-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Murmur", 724, 547)
if not mod then return end
--mod.otherMenu = "Auchindoun"
mod:RegisterEnableMob(18708)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		{33711, "ICON"}, -- Murmur's Touch
		33923, -- Sonic Boom
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "MurmursTouch", 33711, 38794)
	self:Log("SPELL_CAST_START", "SonicBoom", 33923, 38796)
	self:Death("Win", 18708)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:MurmursTouch(args)
	self:TargetMessage(33711, args.destName, "Personal", "Alarm")
	self:Bar(33711, 13, args.destName)
	self:PrimaryIcon(33711, args.destName)
end

function mod:SonicBoom(args)
	self:Message(33923, "Important", nil, CL.casting:format(args.spellName))
	self:Bar(33923, 5)
end
