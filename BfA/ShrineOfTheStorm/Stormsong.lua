if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord Stormsong", 1864, 2155)
if not mod then return end
mod:RegisterEnableMob(134060)
mod.engageId = 2132

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		268347, -- Void Bolt
		269097, -- Waken the Void
		269131, -- Ancient Mindbender
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "VoidBolt", 268347)
	self:Log("SPELL_AURA_SUCCESS", "WakentheVoid", 269097)
	self:Log("SPELL_AURA_APPLIED", "AncientMindbender", 269131)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:VoidBolt(args)
	self:Message(args.spellId, "yellow")
	if self:Interrupter() then
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:WakentheVoid(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "Alarm")
end

function mod:AncientMindbender(args)
	self:TargetMessage2(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "Warning")
end
