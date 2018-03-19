if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Elder Leaxa", 1841, 2157)
if not mod then return end
mod:RegisterEnableMob(131318)
mod.engageId = 2111

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		260879, -- Blood Bolt
		260894, -- Creeping Rot
		264603, -- Blood Mirror
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BloodBolt", 260879)
	self:Log("SPELL_CAST_SUCCESS", "CreepingRot", 260894)
	self:Log("SPELL_CAST_START", "BloodMirror", 260773)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BloodBolt(args)
	self:Message(args.spellId, "orange")
	if self:Interrupter() then
		self:PlaySound(args.spellId, "alert", "interrupt")
	end
end

function mod:CreepingRot(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info", "watchstep")
end

function mod:BloodMirror(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long", "intermission")
end