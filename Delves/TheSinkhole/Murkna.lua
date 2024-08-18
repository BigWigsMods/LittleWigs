--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mirror Master Murkna", 2687)
if not mod then return end
mod:RegisterEnableMob(219763) -- Mirror Master Murkna
mod:SetEncounterID(2999)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.mirror_master_murkna = "Mirror Master Murkna"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.mirror_master_murkna
end

function mod:GetOptions()
	return {
		445860, -- Drowned Illusions
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DrownedIllusions", 445860)
end

--function mod:OnEngage()
	-- Drowned Illusions is cast immediately, no point in starting a bar
--end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DrownedIllusions(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 14.6)
end
