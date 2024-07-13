--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zilbagob", 2784)
if not mod then return end
mod:RegisterEnableMob(226922) -- Zilbagob
mod:SetEncounterID(3029)
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.zilbagob = "Zilbagob"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.zilbagob
end

function mod:GetOptions()
	return {
		460403, -- Kerosene Kick
		460408, -- Chaos Chopper
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "KeroseneKick", 460403)
	self:Log("SPELL_CAST_START", "ChaosChopper", 460408)
end

function mod:OnEngage()
	self:CDBar(460403, 11.3) -- Kerosene Kick
	self:CDBar(460408, 27.5) -- Chaos Chopper
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:KeroseneKick(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 30.8)
end

function mod:ChaosChopper(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 25.9)
end
