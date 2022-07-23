--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord Chamberlain", 2287, 2413)
if not mod then return end
mod:RegisterEnableMob(164218) -- Lord Chamberlain
mod:SetEncounterID(2381)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		329104, -- Door of Shadows
		328791, -- Ritual of Woe
		323143, -- Telekinetic Toss
		323236, -- Unleashed Suffering
		323437, -- Stigma of Pride
		327885, -- Erupting Torment
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DoorofShadows", 329104)
	self:Log("SPELL_CAST_START", "RitualofWoe", 323393, 328791)
	self:Log("SPELL_CAST_START", "TelekineticToss", 323150)
	self:Log("SPELL_CAST_START", "UnleashedSuffering", 323236)
	self:Log("SPELL_AURA_APPLIED", "StigmaofPrideApplied", 323437)
	self:Log("SPELL_CAST_START", "EruptingTorment", 327885)
end

function mod:OnEngage()
	self:CDBar(323437, 7.5) -- Stigma of Pride
	self:CDBar(323143, 7.5) -- Telekinetic Toss
	self:CDBar(323236, 16.8) -- Unleashed Suffering
	self:CDBar(327885, 27.7) -- Erupting Torment
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DoorofShadows(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:StopBar(323437) -- Stigma of Pride
	self:StopBar(323143) -- Telekinetic Toss
	self:StopBar(323236) -- Unleashed Suffering
	self:StopBar(327885) -- Erupting Torment
	self:Bar(328791, 13.9) -- Ritual of Woe
end

function mod:RitualofWoe(args)
	self:Message(328791, "red") -- Ritual of Woe
	self:PlaySound(328791, "warning") -- Ritual of Woe
end

function mod:TelekineticToss(args)
	self:Message(323143, "yellow") -- Telekinetic Toss
	self:PlaySound(323143, "alert") -- Telekinetic Toss
	self:CDBar(323143, 9.7) -- Telekinetic Toss
end

function mod:UnleashedSuffering(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 22.9)
end

function mod:StigmaofPrideApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	if self:Me(args.destGUID) or self:Healer() then
		self:PlaySound(args.spellId, "alert")
	end
	self:CDBar(args.spellId, 26.3)
end

function mod:EruptingTorment(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 26.7)
end
