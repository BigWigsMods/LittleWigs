
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
		 194325, -- Fragment
		 {198551, "SAY"}, -- FragmentApplied
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Log("SPELL_CAST_START", "ShackledServitor", 194231) --cd varies between 23-26
	self:Log("SPELL_CAST_START", "NetherRip", 194668)
	self:Log("SPELL_CAST_START", "Fragment", 194325)
	self:Log("SPELL_AURA_APPLIED", "FragmentApplied", 198551) -- aura apply id
	self:Death("Win", 96754)
end

function mod:OnEngage()
	self:Bar(194216, 3.6) -- Cosmic scythe
	self:CDBar(194231, 8) -- Shackled
	self:CDBar(194668, 12.5) -- nether rip
	self:CDBar(194325, 18) -- fragment
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:Fragment(args)
	self:Bar(args.spellId, 30)
end

function mod:FragmentApplied(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:Message(args.spellId, "Attention", "Warning", CL.incoming:format(args.spellName))
	end
end

function mod:NetherRip(args)
	self:CDBar(194668, 13.5)
end

function mod:ShackledServitor(args)
	self:CDBar(194231, 24)
	self:Message(args.spellId, "Attention", "Info", CL.incoming:format(args.spellName))
end
