
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Harbaron", 1042, 1512)
if not mod then return end
mod:RegisterEnableMob(96754)
--mod.engageId = 1823

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		194216, -- Cosmic Scythe
		194231, -- Summon Shackled Servitor
		194668, -- Nether Rip
		{198551, "SAY"}, -- Fragment
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Log("SPELL_CAST_START", "SummonShackledServitor", 194231)
	self:Log("SPELL_CAST_START", "NetherRip", 194668)
	self:Log("SPELL_CAST_START", "Fragment", 194325)
	self:Log("SPELL_AURA_APPLIED", "FragmentApplied", 198551)
	self:Log("SPELL_AURA_APPLIED", "NetherRipDamage", 194235)
	self:Log("SPELL_PERIODIC_DAMAGE", "NetherRipDamage", 194235)
	self:Log("SPELL_PERIODIC_MISSED", "NetherRipDamage", 194235)
	self:Death("Win", 96754)
end

function mod:OnEngage()
	self:Bar(194216, 3.6) -- Cosmic Scythe
	self:CDBar(194231, 8) -- Summon Shackled Servitor
	self:CDBar(194668, 12.5) -- Nether Rip
	self:CDBar(198551, 18) -- Fragment
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Fragment(args)
	self:Bar(198551, 34) -- Fragment
end

function mod:FragmentApplied(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:Message(args.spellId, "Attention", "Warning", CL.incoming:format(args.spellName))
	end
end

function mod:NetherRip(args)
	self:CDBar(args.spellId, 13.5)
end

function mod:SummonShackledServitor(args)
	self:CDBar(args.spellId, 25) -- cd varies between 23-26
	self:Message(args.spellId, "Attention", "Info", CL.incoming:format(args.spellName))
end

do
	local prev = 0
	function mod:NetherRipDamage(args)
		local t = GetTime()
		if t-prev > 2 and self:Me(args.destGUID) then
			prev = t
			self:Message(194668, "Personal", "Alarm", CL.underyou:format(args.spellName))
		end
	end
end
