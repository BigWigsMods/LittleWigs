
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rokmora", 1065, 1662)
if not mod then return end
mod:RegisterEnableMob(91003)
mod.engageId = 1790

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		188169, -- Razor Shards
		188114, -- Shatter
		192800, -- Choking Dust
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RazorShards", 188169)
	self:Log("SPELL_CAST_START", "Shatter", 188114)

	self:Log("SPELL_AURA_APPLIED", "ChokingDustDamage", 192800)
	self:Log("SPELL_PERIODIC_DAMAGE", "ChokingDustDamage", 192800)
	self:Log("SPELL_PERIODIC_MISSED", "ChokingDustDamage", 192800)
end

function mod:OnEngage()
	self:CDBar(188169, 25) -- Razor Shards
	self:CDBar(188169, 20) -- Shatter
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RazorShards(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 29) -- pull:25.6, 29.1, 29.9
end

function mod:Shatter(args)
	self:Message(args.spellId, "Attention", "Alert")
	self:CDBar(args.spellId, 24) -- pull:20.7, 24.3, 25.1
end

do
	local prev = 0
	function mod:ChokingDustDamage(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 2 then
			prev = t
			self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
		end
	end
end

