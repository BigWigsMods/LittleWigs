
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hymdall", 1477, 1485)
if not mod then return end
mod:RegisterEnableMob(94960)
mod.engageId = 1805

--------------------------------------------------------------------------------
-- Locals
--

local bladeCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		193235, -- Dancing Blade
		191284, -- Horn of Valor
		193092, -- Bloodletting Sweep
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DancingBlade", 193235)
	self:Log("SPELL_CAST_START", "HornOfValor", 191284)

	self:Log("SPELL_PERIODIC_DAMAGE", "DancingBladeDamage", 193234)
	self:Log("SPELL_PERIODIC_MISSED", "DancingBladeDamage", 193234)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	bladeCount = 1
	self:CDBar(193235, 3.3) -- Dancing Blade
	self:CDBar(191284, 8) -- Horn of Valor
	self:CDBar(193092, 16) -- Bloodletting Sweep
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DancingBlade(args)
	self:MessageOld(args.spellId, "orange", "alert", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, bladeCount % 2 == 0 and 10 or 31) -- pull:5.2, 31.5, 10.9, 31.6, 10.9, 32.4, 10.1
	bladeCount = bladeCount + 1
end

function mod:HornOfValor(args)
	self:MessageOld(args.spellId, "red", "long", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 42) -- pull:10.1, 42.4, 43.3
end

do
	local prev = 0
	function mod:DancingBladeDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:MessageOld(193235, "blue", "alarm", CL.you:format(args.spellName))
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 193092 then -- Bloodletting Sweep
		self:MessageOld(spellId, "yellow", self:Tank() and "info")
		self:CDBar(spellId, 18) -- 18.2 - 23
	end
end

