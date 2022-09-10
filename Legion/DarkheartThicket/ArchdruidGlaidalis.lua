
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Archdruid Glaidalis", 1466, 1654)
if not mod then return end
mod:RegisterEnableMob(96512)
mod.engageId = 1836

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		198379, -- Primal Rampage
		198408, -- Nightfall
		{196376, "FLASH"}, -- Grievous Tear
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "PrimalRampage", 198379)

	self:Log("SPELL_AURA_APPLIED", "NightfallDamage", 198408)
	self:Log("SPELL_PERIODIC_DAMAGE", "NightfallDamage", 198408)
	self:Log("SPELL_PERIODIC_MISSED", "NightfallDamage", 198408)

	self:Log("SPELL_AURA_APPLIED", "GrievousTearApplied", 196376)
end

function mod:OnEngage()
	self:CDBar(198379, 12) -- Primal Rampage
	self:CDBar(196376, 5) -- Grievous Tear
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PrimalRampage(args)
	self:MessageOld(args.spellId, "red", "warning")
	self:CDBar(args.spellId, 30) -- pull:12.7, 30.3 / m pull:12.6, 31.6, 29.9, 27.9
end

do
	local prev = 0
	function mod:NightfallDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end

function mod:GrievousTearApplied(args)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
	self:TargetMessageOld(args.spellId, args.destName, "yellow")
	self:CDBar(args.spellId, 13) -- pull:5.7, 14.5, 13.3 / m pull:6.8, 15.5, 16.1, 15.3, 12.5, 14.3
end

