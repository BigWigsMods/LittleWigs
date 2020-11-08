-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Murmur", 555, 547)
if not mod then return end
mod:RegisterEnableMob(18708)
-- mod.engageId = 1910 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{38794, "ICON", "SAY", "SAY_COUNTDOWN"}, -- Murmur's Touch
		33923, -- Sonic Boom
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "MurmursTouch", 33711, 38794) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "MurmursTouchRemoved", 33711, 38794)
	self:Log("SPELL_CAST_START", "SonicBoom", 33923, 38796) -- normal, heroic
	self:Death("Win", 18708)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:MurmursTouch(args)
	local duration = self:Normal() and 14 or 7
	if self:Me(args.destGUID) then
		self:Say(38794)
		self:SayCountdown(38794, duration)
	end
	self:TargetMessageOld(38794, args.destName, "yellow", "alarm")
	self:TargetBar(38794, duration, args.destName)
	self:PrimaryIcon(38794, args.destName)
end

function mod:MurmursTouchRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(38794)
	end
	self:StopBar(args.spellName, args.destName)
	self:PrimaryIcon(38794)
end

function mod:SonicBoom(args)
	self:MessageOld(33923, "red", nil, CL.casting:format(args.spellName))
	self:CastBar(33923, 5)
end
