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
		323142, -- Telekinetic Toss
		323236, -- Unleashed Suffering
		1236973, -- Erupting Torment
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DoorOfShadows", 329104)
	self:Log("SPELL_CAST_START", "RitualOfWoe", 323393, 328791) -- Normal/Heroic, Mythic
	self:Log("SPELL_CAST_SUCCESS", "TelekineticToss", 323142)
	self:Log("SPELL_CAST_START", "UnleashedSuffering", 323236)
	self:Log("SPELL_CAST_START", "EruptingTorment", 1236973)
end

function mod:OnEngage()
	doorOfShadowsCount = 1
	self:CDBar(323142, 8.5) -- Telekinetic Toss
	self:CDBar(323236, 14.6) -- Unleashed Suffering
	self:CDBar(1236973, 25.1) -- Erupting Torment
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DoorOfShadows(args)
	local percent = doorOfShadowsCount == 1 and 70 or 40
	doorOfShadowsCount = doorOfShadowsCount + 1
	self:Message(args.spellId, "cyan", CL.percent:format(percent, args.spellName))
	self:CDBar(328791, 11.0) -- Ritual of Woe
	self:CDBar(1236973, 24.3) -- Erupting Torment
	self:CDBar(323142, 30.4) -- Telekinetic Toss
	self:CDBar(323236, 36.5) -- Unleashed Suffering
	self:PlaySound(args.spellId, "long")
end

function mod:RitualOfWoe()
	self:StopBar(328791)
	self:Message(328791, "red")
	self:PlaySound(328791, "warning")
end

function mod:TelekineticToss(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 10.5)
	self:PlaySound(args.spellId, "alert")
end

function mod:UnleashedSuffering(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 22.8)
	self:PlaySound(args.spellId, "alarm")
end

function mod:EruptingTorment(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 25.6)
	self:PlaySound(args.spellId, "alarm")
end
