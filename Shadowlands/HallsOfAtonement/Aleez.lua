
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("High Adjudicator Aleez", 2287, 2411)
if not mod then return end
mod:RegisterEnableMob(165410) -- High Adjudicator Aleez
mod.engageId = 2403
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		323538, -- Bolt of Power
		323552, -- Volley of Power
		{323650, "FLASH"}, -- Haunting Fixation
		329340, -- Anima Fountain
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BoltofPower", 323538)
	self:Log("SPELL_CAST_START", "VolleyofPower", 323552)
	self:Log("SPELL_AURA_APPLIED", "HauntingFixation", 323650)
	self:Log("SPELL_CAST_START", "AnimaFountain", 329340)
end

function mod:OnEngage()
	self:CDBar(323552, 12) -- Volley of Power
	self:CDBar(323650, 16) -- Haunting Fixation
	self:CDBar(329340, 22) -- Anima Fountain
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BoltofPower(args)
	if self:Interrupter() then
		self:Message(args.spellId, "yellow")
	end
end

function mod:VolleyofPower(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 14.5)
	local _, ready = self:Interrupter()
	if ready then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:HauntingFixation(args)
	self:TargetMessage(args.spellId, "cyan", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
		self:Flash(args.spellId)
	end
	self:CDBar(args.spellId, 20.5)
end

function mod:AnimaFountain(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 25)
end
