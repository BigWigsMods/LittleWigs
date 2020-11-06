
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord Chamberlain", 2287, 2413)
if not mod then return end
mod:RegisterEnableMob(164218) -- Lord Chamberlain
mod.engageId = 2381
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local tossCount = 1
local stigmaCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		329104, -- Door of Shadows
		328791, -- Ritual of Woe
		323150, -- Telekinetic Toss
		323236, -- Unleashed Suffering
		323437, -- Stigma of Pride
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DoorofShadows", 329104)
	self:Log("SPELL_CAST_START", "RitualofWoe", 328791)
	self:Log("SPELL_CAST_START", "TelekineticToss", 323150)
	self:Log("SPELL_CAST_START", "UnleashedSuffering", 323236)
	self:Log("SPELL_AURA_APPLIED", "StigmaofPrideApplied", 323437)
end

function mod:OnEngage()
	tossCount = 1
	stigmaCount = 1

	self:CDBar(323150, 6) -- Telekinetic Toss
	self:CDBar(323236, 15.5) -- Unleashed Suffering
	self:CDBar(329104, 25) -- Door of Shadows
	self:CDBar(328791, 36) -- Ritual of Woe
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DoorofShadows(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 35)
end

function mod:RitualofWoe(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 35)
end

function mod:TelekineticToss(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	tossCount = tossCount + 1
	self:CDBar(args.spellId, tossCount == 2 and 15.5 or 35)
end


function mod:UnleashedSuffering(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:CDBar(args.spellId, 35)
end

function mod:StigmaofPrideApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	if self:Me(args.destGUID) or self:Healer() then
		self:PlaySound(args.spellId, "alert")
	end
	stigmaCount = stigmaCount + 1
	self:CDBar(args.spellId, stigmaCount == 2 and 41 or 35)
end
