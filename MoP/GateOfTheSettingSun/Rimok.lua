
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
		106874, -- Fire Bomb
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FrenziedAssault", 107120)
	self:Log("SPELL_DAMAGE", "FrenziedAssaultDamage", 107121)
	self:Log("SPELL_MISSED", "FrenziedAssaultDamage", 107121)
	self:Log("SPELL_AURA_APPLIED", "ViscousFluid", 107122)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ViscousFluid", 107122)
	self:Log("SPELL_DAMAGE", "FireBomb", 106874)
	self:Log("SPELL_MISSED", "FireBomb", 106874)
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
	self:MessageOld(args.spellId, "yellow", "long", CL.casting:format(args.spellName))
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
				self:MessageOld(107120, "blue", "alert", CL.you:format(args.spellName))
			end
		end
	end
end

function mod:ViscousFluid(args)
	local amount = args.amount or 1
	if self:Me(args.destGUID) and amount % 2 == 1 then
		self:StackMessage(-5666, args.destName, amount, "red", "alarm")
	end
end

do
	local laststacks = 0
	function mod:UNIT_AURA(_, unit) -- no SPELL_AURA_ events for the boss's buffs
		local _, stacks = self:UnitBuff(unit, 107091) -- Viscous Fluid
		if stacks then
			if (stacks % 2 == 0 or stacks == 5) and stacks ~= laststacks then
				self:StackMessage(-5666, self.displayName, stacks, "orange", "info")
			end
			laststacks = stacks
		else
			laststacks = 0
		end
	end
end

do
	local prev = 0
	function mod:FireBomb(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alert", CL.underyou:format(args.spellName))
			end
		end
	end
end
