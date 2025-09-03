--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mirror Master Murkna", 2687)
if not mod then return end
mod:RegisterEnableMob(
	219763, -- Mirror Master Murkna
	247458 -- Mirror Master Murkna (Ethereal Routing Station)
)
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

	-- Ethereal Routing Station
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3") -- Teleported
end

--function mod:OnEngage()
	-- Drowned Illusions is cast immediately, no point in starting a bar
--end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
	if spellId == 1243416 and self:MobId(self:UnitGUID(unit)) == 247458 then -- Teleported
		-- check mobId because Ethereal Routing Station can have up to 3 bosses engaged at once
		self:Win()
	end
end

function mod:DrownedIllusions(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 14.6)
	self:PlaySound(args.spellId, "info")
end
