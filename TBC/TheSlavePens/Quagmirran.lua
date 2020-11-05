
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Quagmirran", 547, 572)
if not mod then return end
mod:RegisterEnableMob(17942)
-- mod.engageId = 1940 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{38153, "SAY", "ICON"}, -- Acid Spray
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "AcidSpray", 38153)
	self:Log("SPELL_AURA_REMOVED", "AcidSprayEnded", 38153)

	self:Death("Win", 17942)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AcidSpray(args)
	if self:MobId(args.destGUID) == 17942 then return end -- applies this to himself and to his target when he starts channeling

	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
	self:TargetMessageOld(args.spellId, args.destName, "red")
	self:CastBar(args.spellId, 8)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:AcidSprayEnded(args)
	if self:MobId(args.destGUID) ~= 17942 then return end -- I'm not sure if he stops casting if his target dies but we don't need args.destName to remove icons

	self:StopBar(CL.cast:format(args.spellName))
	self:PrimaryIcon(args.spellId)
end
