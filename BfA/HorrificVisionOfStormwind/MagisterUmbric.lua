
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Magister Umbric", 2213)
if not mod then return end
mod:RegisterEnableMob(158035)
mod:SetAllowWin(true)
mod.engageId = 2377

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.magister_umbric = "Magister Umbric"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		309373, -- Entropic Missiles
		309648, -- Tainted Polymorph
	}
end

function mod:OnRegister()
	self.displayName = L.magister_umbric
end

function mod:OnBossEnable()
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:Log("SPELL_CAST_START", "TaintedPolymorph", 309648)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, castGUID, spellId)
		if castGUID ~= prev and spellId == 309373 then -- Entropic Missiles
			-- UNIT_SPELLCAST_SUCCEEDED fires when the channel starts.
			-- CLEU fires for every tick of the channel.
			prev = castGUID
			self:Message(309373, "orange")
			self:PlaySound(309373, "alert")
		end
	end
end

function mod:TaintedPolymorph(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
