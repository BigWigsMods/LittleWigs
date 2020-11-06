
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Oblivion Elemental", 2212)
if not mod then return end
mod:RegisterEnableMob(153244)
mod:SetAllowWin(true)
mod.engageId = 2372

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.oblivion_elemental = "Oblivion Elemental"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		297574, -- Hopelessness
	}
end

function mod:OnRegister()
	self.displayName = L.oblivion_elemental
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Hopelessness", 297574)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Hopelessness(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end
