--------------------------------------------------------------------------------
-- TODO List:
-- - Do we need warnings for the add spells?
-- - Mythic Abilities

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Domatrax", 1677, 1904)
if not mod then return end
mod:RegisterEnableMob(
	118884, -- Aegis of Aggramar
	118804  -- Domatrax
)
mod.engageId = 2053

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects the Aegis of Aggramar's gossip option to start the Domatrax encounter."
	L.custom_on_autotalk_icon = "ui_chat"

	L.missing_aegis = "You're not standing in Aegis" -- Aegis is a short name for Aegis of Aggramar
	L.aegis_healing = "Aegis: Reduced Healing Done"
	L.aegis_damage = "Aegis: Reduced Damage Done"
end

--------------------------------------------------------------------------------
-- Locals
--

local felPortalGuardianCollector = {}
local felPortalGuardiansCounter = 1
local isCastingChaoticEnergy = false

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_autotalk", -- Aegis of Aggramar
		238410, -- Aegis of Aggramar
		236543, -- Felsoul Cleave
		{234107, "CASTBAR"}, -- Chaotic Energy
		-15076, -- Fel Portal Guardian
		241622, -- Approaching Doom
	},{
		["custom_on_autotalk"] = "general",
		[236543] = -15011,
		[241622] = "mythic",
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "FelsoulCleave", 236543)
	self:Log("SPELL_CAST_START", "ChaoticEnergy", 234107)
	self:Log("SPELL_CAST_SUCCESS", "ChaoticEnergySuccess", 234107)

	self:RegisterEvent("GOSSIP_SHOW")
	self:Log("SPELL_AURA_APPLIED", "AegisApplied", 238410)
	self:Log("SPELL_AURA_REMOVED", "AegisRemoved", 238410)
end

function mod:OnEngage()
	isCastingChaoticEnergy = false
	if self:Mythic() then
		felPortalGuardiansCounter = 1
		felPortalGuardianCollector = {}
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	end
	self:CDBar(236543, 8.3) -- Felsoul Cleave
	self:CDBar(234107, 32.5) -- Chaotic Energy
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 235822 or spellId == 235862 then -- Start Wave 1 + 2
		self:MessageOld(-15076, "red", "alarm", CL.incoming:format(self:SpellName(-15076)))
	end
end

function mod:FelsoulCleave(args)
	self:MessageOld(args.spellId, "yellow", "alert")
	self:CDBar(args.spellId, 18.5)
end

do
	local aegisCheck, isOnMe = nil, false

	local function periodicCheckForAegisOfAggramar(self)
		if isOnMe then
			self:MessageOld(238410, "blue", "alert", self:Healer() and L.aegis_healing or L.aegis_damage)
			aegisCheck = self:ScheduleTimer(periodicCheckForAegisOfAggramar, 1.5, self)
		end
	end

	local function checkForLackOfAegis(self)
		if not isOnMe and self:MobId(self:UnitGUID("boss2")) == 118884 then -- make sure the Aegis is not depleted
			self:MessageOld(238410, "orange", "warning", L.missing_aegis)
		end
	end

	function mod:ChaoticEnergy(args)
		if aegisCheck then
			self:CancelTimer(aegisCheck)
			aegisCheck = nil
		end
		isCastingChaoticEnergy = true
		self:MessageOld(args.spellId, "orange", "warning")
		self:CDBar(args.spellId, 37.6)
		self:CastBar(args.spellId, 5)

		-- give a warning if the player is not in the Aegis during the last 2 seconds of the cast:
		self:ScheduleTimer(checkForLackOfAegis, 3, self)
	end

	function mod:ChaoticEnergySuccess()
		isCastingChaoticEnergy = false
		aegisCheck = self:ScheduleTimer(periodicCheckForAegisOfAggramar, 1, self)
	end

	function mod:AegisApplied(args)
		if self:Me(args.destGUID) then
			isOnMe = true
			if not isCastingChaoticEnergy then
				periodicCheckForAegisOfAggramar(self)
			end
		end
	end

	function mod:AegisRemoved(args)
		if self:Me(args.destGUID) then
			isOnMe = false
			if aegisCheck then
				self:CancelTimer(aegisCheck)
				aegisCheck = nil
			end
		end
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	local felPortalGuardians = {}

	for i = 1, 5 do
		local guid = self:UnitGUID(("boss%d"):format(i))
		if guid then
			local mobId = self:MobId(guid)
			if mobId == 118834 then -- Fel Portal Guardian
				if not felPortalGuardianCollector[guid] then
					-- New Fel Portal Guardian
					felPortalGuardianCollector[guid] = felPortalGuardiansCounter
					self:CDBar(241622, 20, CL.cast:format(CL.count:format(self:SpellName(241622), felPortalGuardiansCounter)))
					felPortalGuardiansCounter = felPortalGuardiansCounter + 1
				end
				felPortalGuardians[guid] = true
			end
		end
	end

	for guid,_ in pairs(felPortalGuardianCollector) do
		if not felPortalGuardians[guid] then
			-- Fel Portal Guardian Died
			self:StopBar(CL.cast:format(CL.count:format(self:SpellName(241622), felPortalGuardianCollector[guid])))
			felPortalGuardianCollector[guid] = nil
		end
	end
end

-- Aegis of Aggramar
function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") and self:MobId(self:UnitGUID("npc")) == 118884 then
		if self:GetGossipOptions() then
			self:SelectGossipOption(1, true) -- auto confirm it
		end
	end
end
