--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("High Adjudicator Aleez", 2287, 2411)
if not mod then return end
mod:RegisterEnableMob(165410) -- High Adjudicator Aleez
mod:SetEncounterID(2403)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- High Adjudicator Aleez
		{323538, "OFF"}, -- Bolt of Power
		323552, -- Volley of Power
		329340, -- Anima Fountain
		-- Ghastly Parishioner
		323650, -- Haunting Fixation
	}, {
		[323538] = self.displayName, -- High Adjudicator Aleez
		[323650] = -21861, -- Ghastly Parishioner
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BoltOfPower", 323538)
	self:Log("SPELL_CAST_START", "VolleyOfPower", 323552)
	self:Log("SPELL_AURA_APPLIED", "HauntingFixation", 323650)
	self:Log("SPELL_CAST_START", "AnimaFountain", 329340)
end

function mod:OnEngage()
	self:CDBar(323552, 12.0) -- Volley of Power
	self:CDBar(323650, 17.2) -- Haunting Fixation
	self:CDBar(329340, 19.1) -- Anima Fountain
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BoltOfPower(args)
	if self:Interrupter() then
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:VolleyOfPower(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 10.9)
	local _, ready = self:Interrupter()
	if ready then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:HauntingFixation(args)
	self:TargetMessage(args.spellId, "cyan", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
	end
	self:CDBar(args.spellId, 20.5)
end

function mod:AnimaFountain(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 24.2)
end
