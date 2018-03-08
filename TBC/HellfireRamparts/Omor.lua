-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Omor the Unscarred", 797, 528)
if not mod then return end
mod:RegisterEnableMob(17308)
-- mod.engageId = 1891 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--


function mod:GetOptions()
	return {
		{30695, "SAY", "ICON"}, -- Treacherous Aura
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TreacherousAura", 30695, 37566) -- Treacherous Aura, Bane of Treachery (heroic version)
	self:Log("SPELL_AURA_REMOVED", "TreacherousAuraRemoved", 30695, 37566)
	self:Death("Win", 17308)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:TreacherousAura(args)
	if self:Me(args.destGUID) then
		self:Say(30695)
	end
	self:TargetMessage(30695, args.destName, "Urgent", nil, args.spellId)
	self:TargetBar(30695, 15, args.destName, args.spellId)
	self:PrimaryIcon(30695, args.destName)
end

function mod:TreacherousAuraRemoved(args)
	self:PrimaryIcon(30695)
	self:StopBar(30695, args.destName)
end
