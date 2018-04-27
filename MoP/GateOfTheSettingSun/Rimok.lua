
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Commander Ri'mok", 962, 676)
if not mod then return end
mod:RegisterEnableMob(56636)
mod.engageId = 1406
mod.respawnTime = 20

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-5666, -- Viscous Fluid
		107120, -- Frenzied Assault
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FrenziedAssault", 107120)
	self:Log("SPELL_DAMAGE", "FrenziedAssaultDamage", 107121)
	self:Log("SPELL_MISSED", "FrenziedAssaultDamage", 107121)
	self:Log("SPELL_AURA_APPLIED", "ViscousFluid", 107122)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ViscousFluid", 107122)
end

function mod:OnEngage()
	self:CDBar(107120, 5.7) -- Frenzied Assault
	if self:Tank() then
		self:RegisterUnitEvent("UNIT_AURA", nil, "boss1")
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FrenziedAssault(args)
	self:Message(args.spellId, "Attention", "Long", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 7) -- 1s cast + 6s channel
	self:CDBar(args.spellId, 17)
end

do
	local prev = 0
	function mod:FrenziedAssaultDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if (not self:Tank() and t-prev > 1.5) or t-prev > 6 then -- the tank might want to bring adds in front of Ri'mok
				prev = t
				self:Message(107120, "Personal", "Alert", CL.you:format(args.spellName))
			end
		end
	end
end

function mod:ViscousFluid(args)
	local amount = args.amount or 1
	if self:Me(args.destGUID) and amount % 2 == 1 then
		self:StackMessage(-5666, args.destName, amount, "Important", "Alarm")
	end
end

do
	local laststacks = 0
	function mod:UNIT_AURA(unit) -- no SPELL_AURA_ events for the boss's buffs
		local _, _, _, stacks = UnitBuff(unit, self:SpellName(107122)) -- Viscous Fluid
		if stacks then
			if (stacks % 2 == 0 or stacks == 5) and stacks ~= laststacks then
				self:StackMessage(-5666, self.displayName, stacks, "Urgent", "Info")
			end
			laststacks = stacks
		else
			laststacks = 0
		end
	end
end
