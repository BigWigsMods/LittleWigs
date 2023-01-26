--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hymdall", 1477, 1485)
if not mod then return end
mod:RegisterEnableMob(94960)
mod:SetEncounterID(1805)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local bladeCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{193092, "TANK_HEALER"}, -- Bloodletting Sweep
		193235, -- Dancing Blade
		191284, -- Horn of Valor
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BloodlettingSweep", 193092)
	self:Log("SPELL_CAST_START", "DancingBlade", 193235)
	self:Log("SPELL_AURA_APPLIED", "DancingBladeDamage", 193234)
	self:Log("SPELL_PERIODIC_DAMAGE", "DancingBladeDamage", 193234)
	self:Log("SPELL_MISSED", "DancingBladeDamage", 193234)
	self:Log("SPELL_CAST_START", "HornOfValor", 191284)
end

function mod:OnEngage()
	bladeCount = 1
	self:CDBar(193235, 4.4) -- Dancing Blade
	self:CDBar(191284, 9.3) -- Horn of Valor
	self:CDBar(193092, 15.4) -- Bloodletting Sweep
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BloodlettingSweep(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 17.1)
end

function mod:DancingBlade(args)
	self:Message(args.spellId, "orange", CL.incoming:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, bladeCount % 2 == 0 and 11 or 31.6)
	bladeCount = bladeCount + 1
end

function mod:HornOfValor(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 42.6)
end

do
	local prev = 0
	function mod:DancingBladeDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(193235, "near")
				self:PlaySound(193235, "underyou")
			end
		end
	end
end
