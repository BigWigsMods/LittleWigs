--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Waxface", 2683)
if not mod then return end
mod:RegisterEnableMob(214263) -- Waxface
mod:SetEncounterID(2894)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.waxface = "Waxface"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.waxface
end

function mod:GetOptions()
	return {
		450142, -- Burn Away
		450128, -- Noxious Gas
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "NoxiousGas", 450128)
	self:Log("SPELL_CAST_START", "BurnAway", 450142)
end

function mod:OnEngage()
	self:CDBar(450128, 3.5) -- Noxious Gas
	self:CDBar(450142, 18.1) -- Burn Away
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:NoxiousGas(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 20.6)
end

function mod:BurnAway(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 21.8)
end
