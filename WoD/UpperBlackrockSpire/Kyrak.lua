
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kyrak", 1358, 1227)
if not mod then return end
mod:RegisterEnableMob(76021)
mod.engageId = 1758
mod.respawnTime = 25

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		161199, -- Debilitating Fixation
		161203, -- Rejuvenating Serum
		161288, -- Vileblood Serum
		{155037, "TANK"}, -- Eruption
	}, {
		[161199] = -10260,
		[155037] = CL.adds,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DebilitatingFixation", 161199)
	self:Log("SPELL_CAST_START", "RejuvenatingSerumIncoming", 161203)
	self:Log("SPELL_CAST_SUCCESS", "RejuvenatingSerum", 161203)
	self:Log("SPELL_AURA_APPLIED", "VilebloodSerum", 161288)
	self:Log("SPELL_CAST_START", "Eruption", 155037)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DebilitatingFixation(args)
	self:MessageOld(args.spellId, "yellow", "alert", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 20) -- 20-23
end

function mod:RejuvenatingSerumIncoming(args)
	self:MessageOld(args.spellId, "orange", "long", CL.incoming:format(args.spellName))
end

function mod:RejuvenatingSerum(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", "warning", nil, nil, self:Dispeller("magic", true))
end

function mod:VilebloodSerum(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "blue", "alarm", CL.underyou:format(args.spellName))
	end
end

function mod:Eruption(args)
	local raidIcon = self:GetIconTexture(self:GetIcon(args.sourceRaidFlags))
	if raidIcon then
		self:MessageOld(args.spellId, "red", "info", raidIcon.. args.spellName)
	else
		self:MessageOld(args.spellId, "red", "info")
	end
end
