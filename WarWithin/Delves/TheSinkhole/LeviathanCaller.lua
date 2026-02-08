--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Leviathan Caller", 2687)
if not mod then return end
mod:RegisterEnableMob(
	220738, -- Leviathan Caller
	220742 -- Guardian Tentacle
)
mod:SetEncounterID(3002)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.leviathan_caller = "Leviathan Caller"
	L.guardian_tentacle = "Guardian Tentacle"
	L.slamming_tentacles = "Slamming Tentacles"
end

--------------------------------------------------------------------------------
-- Locals
--

local encounterEventCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.leviathan_caller
end

function mod:GetOptions()
	return {
		-- Leviathan Caller
		446079, -- Call of the Abyss
		-- Guardian Tentacle
		442422, -- Abyssal Embrace
	}, {
		[446079] = L.leviathan_caller,
		[442422] = L.guardian_tentacle,
	}, {
		[446079] = L.slamming_tentacles,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CallOfTheAbyss", 446079)
	self:Log("SPELL_CAST_SUCCESS", "EncounterEvent", 181089) -- extra tentacles spawning
	self:Death("GuardianTentacleDeath", 220742)
end

function mod:OnEngage()
	encounterEventCount = 1
	self:CDBar(446079, 2.5, L.slamming_tentacles) -- Call of the Abyss
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CallOfTheAbyss(args)
	self:Message(args.spellId, "cyan", CL.spawning:format(L.slamming_tentacles))
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 34.0, L.slamming_tentacles)
end

function mod:EncounterEvent() -- extra tentacles spawning
	if encounterEventCount == 1 or encounterEventCount == 3 then
		-- two extra Slamming Tentacles spawn at 75% and 25%
		local percent = encounterEventCount == 1 and 75 or 25
		self:Message(446079, "cyan", CL.percent:format(percent, CL.spawning:format(L.slamming_tentacles))) -- Call of the Abyss
		self:PlaySound(446079, "long")
	else -- 2
		-- one Guardian Tentacle spawns at 50%, which immediately channels Abyssal Embrace
		self:Message(442422, "red", CL.percent:format(50, CL.spawning:format(L.guardian_tentacle))) -- Abyssal Embrace
		self:PlaySound(442422, "warning")
	end
	encounterEventCount = encounterEventCount + 1
end

function mod:GuardianTentacleDeath()
	self:Message(442422, "green", CL.removed:format(self:SpellName(442422))) -- Abyssal Embrace
	self:PlaySound(442422, "info")
end
