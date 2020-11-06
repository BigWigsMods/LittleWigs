
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Overlord Mathias Shaw", 2213)
if not mod then return end
mod:RegisterEnableMob(158157, 158315) -- Overlord Mathias Shaw, Eye of Chaos
mod:SetAllowWin(true)
mod.engageId = 2376

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.overlord_mathias_shaw = "Overlord Mathias Shaw"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		308669, -- Dark Gaze
	}
end

function mod:OnRegister()
	self.displayName = L.overlord_mathias_shaw
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DarkGaze", 308669)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DarkGaze(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 12)
end
