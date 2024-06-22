if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nerl'athekk the Skulking", 2685)
if not mod then return end
mod:RegisterEnableMob(219676) -- Nerl'athekk the Skulking
mod:SetEncounterID(2946)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.nerlathekk_the_skulking = "Nerl'athekk the Skulking"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.nerlathekk_the_skulking
end

function mod:GetOptions()
	return {
		454762, -- Dark Abatement
		440806, -- Darkrift Smash
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") -- Dark Abatement
	self:Log("SPELL_CAST_START", "DarkriftSmash", 440806)
end

function mod:OnEngage()
	self:CDBar(454762, 2.0) -- Dark Abatement
	self:CDBar(440806, 8.5) -- Darkrift Smash
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, castGUID, spellId)
		if castGUID ~= prev and spellId == 458183 then -- Dark Abatement
			prev = castGUID
			self:Message(454762, "red")
			self:PlaySound(454762, "alert")
			self:CDBar(454762, 20.1)
		end
	end
end

function mod:DarkriftSmash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 12.2)
end
