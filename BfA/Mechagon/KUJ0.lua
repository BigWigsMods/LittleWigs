--------------------------------------------------------------------------------
-- TODO
-- Proximity for Explosive Leap (debuff is 291972)
-- Air Drop timers pull:7.3, 28.3, 28.7, 15.8, 19.7, 30.3, 27.8, 15.8
--

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
		291918, -- Air Drop
		291946, -- Venting Flames
		291973, -- Explosive Leap
		{294929, "TANK_HEALER"}, -- Blazing Chomp
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "AirDrop", 291918)
	self:Log("SPELL_CAST_START", "VentingFlames", 291946)
	self:Log("SPELL_CAST_START", "ExplosiveLeap", 291973)
	self:Log("SPELL_AURA_APPLIED", "BlazingChompApplied", 294929)
end

function mod:OnEngage()
	self:Bar(291918, 7.3) -- Air Drop
	self:Bar(291946, 18.3) -- Venting Flames
	self:Bar(291973, 30.4) -- Explosive Leap
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
	self:Bar(args.spellId, 31.6)
end

function mod:ExplosiveLeap(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 30.4)
end

function mod:BlazingChompApplied(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "purple")
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end
