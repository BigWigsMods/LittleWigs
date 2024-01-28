--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord Chamberlain", 2287, 2413)
if not mod then return end
mod:RegisterEnableMob(164218) -- Lord Chamberlain
mod:SetEncounterID(2381)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local doorOfShadowsCount = 1

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
	self:Log("SPELL_CAST_START", "DoorOfShadows", 329104)
	self:Log("SPELL_CAST_START", "RitualOfWoe", 323393, 328791)
	self:Log("SPELL_CAST_START", "TelekineticToss", 323150)
	self:Log("SPELL_CAST_START", "UnleashedSuffering", 323236)
	self:Log("SPELL_AURA_APPLIED", "StigmaOfPrideApplied", 323437)
	self:Log("SPELL_CAST_START", "EruptingTorment", 327885)
end

function mod:OnEngage()
	doorOfShadowsCount = 1
	self:CDBar(323143, 6.0) -- Telekinetic Toss
	self:CDBar(323437, 7.5) -- Stigma of Pride
	self:CDBar(323236, 16.8) -- Unleashed Suffering
	self:CDBar(327885, 27.7) -- Erupting Torment
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DoorOfShadows(args)
	local percent = doorOfShadowsCount == 1 and 70 or 40
	self:Message(args.spellId, "cyan", CL.percent:format(percent, args.spellName))
	self:PlaySound(args.spellId, "long")
	doorOfShadowsCount = doorOfShadowsCount + 1
	self:CDBar(328791, 10.9) -- Ritual of Woe
	self:CDBar(323437, 29.4) -- Stigma of Pride
	self:CDBar(323143, 31.5) -- Telekinetic Toss
	self:CDBar(327885, 37.6) -- Erupting Torment
	self:CDBar(323236, 49.8) -- Unleashed Suffering
end

function mod:RitualOfWoe(args)
	self:StopBar(328791)
	self:Message(328791, "red")
	self:PlaySound(328791, "warning")
end

function mod:TelekineticToss(args)
	self:Message(323143, "yellow")
	self:PlaySound(323143, "alert")
	self:CDBar(323143, 9.7)
end

function mod:UnleashedSuffering(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 22.9)
end

function mod:StigmaOfPrideApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	if self:Me(args.destGUID) or self:Healer() then
		self:PlaySound(args.spellId, "alert")
	end
	self:CDBar(args.spellId, 21.8)
end

function mod:EruptingTorment(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 26.7)
end
