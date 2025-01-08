if not BigWigsLoader.isTestBuild then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Geezle Gigazap", 2773, 2651)
if not mod then return end
mod:RegisterEnableMob(226404) -- Geezle Gigazap
mod:SetEncounterID(3054)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	468811, -- Gigazap
})

--------------------------------------------------------------------------------
-- Locals
--

local turboChargeCount = 1
local gigazapCount = 1
local thunderPunchCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		465463, -- Turbo Charge
		468841, -- Leaping Sparks
		{468813, "PRIVATE"}, -- Gigazap
		{466190, "TANK_HEALER"}, -- Thunder Punch
		468723, -- Shock Water
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "TurboCharge", 465463)
	self:Log("SPELL_CAST_START", "LeapingSparks", 468841)
	self:Log("SPELL_AURA_APPLIED", "LeapingSparkApplied", 468616)
	self:Log("SPELL_CAST_START", "Gigazap", 468813)
	self:Log("SPELL_CAST_START", "ThunderPunch", 466190)
	self:Log("SPELL_PERIODIC_DAMAGE", "ShockWaterDamage", 468723)
	self:Log("SPELL_PERIODIC_MISSED", "ShockWaterDamage", 468723)
end

function mod:OnEngage()
	turboChargeCount = 1
	gigazapCount = 1
	thunderPunchCount = 1
	self:CDBar(465463, 1.6, CL.count:format(self:SpellName(465463), turboChargeCount)) -- Turbo Charge
	self:CDBar(466190, 24.0) -- Thunder Punch
	self:CDBar(468813, 28.0, CL.count:format(self:SpellName(468813), gigazapCount)) -- Gigazap
	self:CDBar(468841, 38.0) -- Leaping Sparks
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TurboCharge(args)
	self:StopBar(CL.count:format(args.spellName, turboChargeCount))
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, turboChargeCount))
	turboChargeCount = turboChargeCount + 1
	self:CDBar(args.spellId, 60.0, CL.count:format(args.spellName, turboChargeCount))
	self:PlaySound(args.spellId, "long")
end

function mod:LeapingSparks(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 60.0)
end

function mod:LeapingSparkApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(468841, nil, args.spellName)
		self:PlaySound(468841, "warning")
	end
end

function mod:Gigazap(args)
	self:StopBar(CL.count:format(args.spellName, gigazapCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, gigazapCount))
	gigazapCount = gigazapCount + 1
	if gigazapCount % 2 == 0 then
		self:CDBar(args.spellId, 26.0, CL.count:format(args.spellName, gigazapCount))
	else
		self:CDBar(args.spellId, 34.0, CL.count:format(args.spellName, gigazapCount))
	end
	self:PlaySound(args.spellId, "info")
end

function mod:ThunderPunch(args)
	self:Message(args.spellId, "purple")
	thunderPunchCount = thunderPunchCount + 1
	if thunderPunchCount % 2 == 0 then
		self:CDBar(args.spellId, 26.0)
	else
		self:CDBar(args.spellId, 34.0)
	end
	if self:Tank() then
		self:PlaySound(args.spellId, "alarm")
	else
		self:PlaySound(args.spellId, "alert")
	end
end

do
	local prev = 0
	function mod:ShockWaterDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end
