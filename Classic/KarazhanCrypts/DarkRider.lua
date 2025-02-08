--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dark Rider", 2875)
if not mod then return end
mod:RegisterEnableMob(238055) -- Dark Rider
mod:SetEncounterID(3143)
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.dark_rider = "Dark Rider"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.dark_rider
end

function mod:GetOptions()
	return {
		1220939, -- Ethereal Charge
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "EtherealCharge", 1220939)
end

function mod:OnEngage()
	self:CDBar(1220939, 40.4) -- Ethereal Charge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:EtherealCharge(args)
		-- cast once by each clone
		if args.time - prev > 5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:CDBar(args.spellId, 53.4)
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
