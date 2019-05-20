if not IsTestBuild() then return end

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("K.U.-J.0.", 2097, 2339)
if not mod then return end
mod:RegisterEnableMob(144246)
mod.engageId = 2258

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		291930, -- Air Drop XXX spell id might be wrong
		291946, -- Venting Flames
		292022, -- Explosive Leap
		{294929, "TANK_HEALER"}, -- Blazing Chomp
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "AirDrop", 291930)
	self:Log("SPELL_CAST_START", "VentingFlames", 291946)
	self:Log("SPELL_CAST_START", "ExplosiveLeap", 292022)
	self:Log("SPELL_AURA_APPLIED", "BlazingChompApplied", 294929)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AirDrop(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

function mod:VentingFlames(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 6)
end

function mod:ExplosiveLeap(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:BlazingChompApplied(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "purple")
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end
