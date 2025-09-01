--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nerl'athekk the Skulking", 2685)
if not mod then return end
mod:RegisterEnableMob(
	219676, -- Nerl'athekk the Skulking
	247475 -- Nerl'athekk the Skulking (Ethereal Routing Station)
)
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
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3") -- Dark Abatement, Teleported
	self:Log("SPELL_CAST_START", "DarkriftSmash", 440806)

	-- Ethereal Routing Station
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
end

function mod:OnEngage()
	self:CDBar(454762, 2.0) -- Dark Abatement
	self:CDBar(440806, 8.5) -- Darkrift Smash
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
	if spellId == 458183 and self:MobId(self:UnitGUID(unit)) == 219676 then -- Dark Abatement
		-- Dark Abatement only works for the normal version of Nerl'athekk, not the Ethereal Routing Station version
		self:Message(454762, "red")
		self:PlaySound(454762, "alert")
		self:CDBar(454762, 20.1)
	elseif spellId == 1243416 and self:MobId(self:UnitGUID(unit)) == 247475 then -- Teleported
		-- check mobId because Ethereal Routing Station can have up to 3 bosses engaged at once
		self:Win()
	end
end

function mod:DarkriftSmash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 12.2)
end
