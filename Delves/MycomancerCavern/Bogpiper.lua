if not BigWigsLoader.isBeta then return end
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
end

function mod:GetOptions()
	return {
		454213, -- Muck Charge
		449965, -- Swamp Bolt
		453897, -- Sporesong
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "MuckCharge", 454213)
	self:Log("SPELL_CAST_START", "SwampBolt", 449965)
	self:Log("SPELL_CAST_START", "Sporesong", 453897)
end

function mod:OnEngage()
	self:CDBar(454213, 6.1) -- Muck Charge
	self:CDBar(449965, 10.8) -- Swamp Bolt
	self:CDBar(453897, 15.0) -- Sporesong
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MuckCharge(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 25.4)
end

function mod:SwampBolt(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 26.7)
end

function mod:Sporesong(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 28.7)
end
