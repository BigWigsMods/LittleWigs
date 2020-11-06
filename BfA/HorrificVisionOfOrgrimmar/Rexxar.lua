
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rexxar", 2212)
if not mod then return end
mod:RegisterEnableMob(155098)
mod:SetAllowWin(true)
mod.engageId = 2370

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.rexxar = "Rexxar"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		304251, -- Void Quills
	}
end

function mod:OnRegister()
	self.displayName = L.rexxar
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "VoidQuills", 304251)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:VoidQuills(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end
