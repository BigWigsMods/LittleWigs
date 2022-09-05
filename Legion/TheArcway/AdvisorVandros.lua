
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Advisor Vandros", 1516, 1501)
if not mod then return end
mod:RegisterEnableMob(98208)
mod.engageId = 1829

--------------------------------------------------------------------------------
-- Locals
--

local blastCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		203176, -- Accelerating Blast
		202974, -- Force Bomb
		220871, -- Unstable Mana
		203882, -- Banish In Time
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AcceleratingBlast", 203176)
	self:Log("SPELL_AURA_APPLIED", "AcceleratingBlastApplied", 203176)
	self:Log("SPELL_CAST_START", "ForceBomb", 202974)
	self:Log("SPELL_AURA_APPLIED", "UnstableMana", 220871)
	self:Log("SPELL_CAST_START", "BanishInTime", 203882)
end

function mod:OnEngage()
	blastCount = 1

	self:CDBar(202974, 29) -- Force Bomb
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AcceleratingBlast(args)
	if self:Interrupter() then
		self:MessageOld(args.spellId, "yellow", nil, CL.count:format(args.spellName, blastCount))
	end
	blastCount = blastCount + 1
	if blastCount > 3 then blastCount = 1 end
end

function mod:AcceleratingBlastApplied(args)
	local count = args.amount or 1
	if self:Dispeller("magic", true) and count > 5 and count % 3 == 0 then
		self:StackMessageOld(args.spellId, args.destName, count, "orange", "alert")
	end
end

function mod:ForceBomb(args)
	self:MessageOld(args.spellId, "yellow", "info")
	-- self:CDBar(args.spellId, 30) -- never in p1 long enough to get a second cast :\
end

function mod:UnstableMana(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", "alarm")
	self:TargetBar(args.spellId, 8, args.destName)
end

function mod:BanishInTime(args)
	self:StopBar(202974) -- Force Bomb
	blastCount = 1

	self:MessageOld(args.spellId, "red", "long")
end
