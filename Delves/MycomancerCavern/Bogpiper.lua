--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Bogpiper", 2679)
if not mod then return end
mod:RegisterEnableMob(220314) -- Bogpiper
mod:SetEncounterID(2960)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.bogpiper = "Bogpiper"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.bogpiper
	self:SetSpellRename(454213, CL.charge) -- Muck Charge (Charge)
end

function mod:GetOptions()
	return {
		454213, -- Muck Charge
		470582, -- Swamp Bolt
		453897, -- Sporesong
	},nil,{
		[454213] = CL.charge, -- Muck Charge (Charge)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "MuckCharge", 454213)
	self:Log("SPELL_CAST_START", "SwampBolt", 470582)
	self:Log("SPELL_CAST_START", "Sporesong", 453897)
end

function mod:OnEngage()
	self:CDBar(454213, 5.7, CL.charge) -- Muck Charge
	self:CDBar(470582, 10.5) -- Swamp Bolt
	self:CDBar(453897, 15.0) -- Sporesong
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MuckCharge(args)
	self:Message(args.spellId, "red", CL.charge)
	self:CDBar(args.spellId, 25.0, CL.charge)
	self:PlaySound(args.spellId, "alarm")
end

function mod:SwampBolt(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 26.7)
	self:PlaySound(args.spellId, "alert")
end

function mod:Sporesong(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 27.9)
	self:PlaySound(args.spellId, "long")
end
