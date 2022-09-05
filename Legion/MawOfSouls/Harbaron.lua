
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Harbaron", 1492, 1512)
if not mod then return end
mod:RegisterEnableMob(96754)
mod.engageId = 1823

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		194216, -- Cosmic Scythe
		194231, -- Summon Shackled Servitor
		194668, -- Nether Rip
		{194325, "SAY"}, -- Fragment
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SummonShackledServitor", 194231)
	self:Log("SPELL_CAST_START", "NetherRip", 194668)
	self:Log("SPELL_CAST_START", "Fragment", 194325)
	self:Log("SPELL_CAST_START", "CosmicScythe", 194216)

	self:Log("SPELL_PERIODIC_DAMAGE", "NetherRipDamage", 194235)
	self:Log("SPELL_PERIODIC_MISSED", "NetherRipDamage", 194235)
end

function mod:OnEngage()
	self:Bar(194216, 3.6) -- Cosmic Scythe
	self:CDBar(194231, 8) -- Summon Shackled Servitor
	if not self:Normal() then
		self:CDBar(194668, 12.5) -- Nether Rip
	end
	self:CDBar(194325, 18) -- Fragment
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(194325)
		end
		self:TargetMessageOld(194325, player, "red", "warning")
	end
	function mod:Fragment(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 30)
	end
end

function mod:NetherRip(args)
	self:CDBar(args.spellId, 13.5)
end

function mod:SummonShackledServitor(args)
	self:CDBar(args.spellId, 25) -- cd varies between 23-26
	self:MessageOld(args.spellId, "yellow", "info", CL.incoming:format(args.spellName))
end

function mod:CosmicScythe(args)
	self:MessageOld(args.spellId, "orange", "alert")
end

do
	local prev = 0
	function mod:NetherRipDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:MessageOld(194668, "blue", "alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end
