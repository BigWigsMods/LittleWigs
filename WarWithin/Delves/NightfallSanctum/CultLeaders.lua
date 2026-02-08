--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Cult Leaders", 2686)
if not mod then return end
mod:RegisterEnableMob(
	229854, -- Inquisitor Speaker
	229855, -- Shadeguard Speaker
	230904 -- Shadeguard Speaker
)
mod:SetEncounterID(3050)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local bossCollector = {}
local bossesEngaged = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.cult_leaders = "Cult Leaders"
	L.inquisitor_speaker = "Inquisitor Speaker"
	L.shadeguard_speaker = "Shadeguard Speaker"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.cult_leaders
end

function mod:GetOptions()
	return {
		-- Inquisitor Speaker
		{434740, "NAMEPLATE"}, -- Shadow Barrier
		-- Shadeguard Speaker
		{458874, "NAMEPLATE"}, -- Shadow Wave
		{443482, "DISPEL", "NAMEPLATE"}, -- Blessing of Dusk
	}, {
		[434740] = L.inquisitor_speaker,
		[458874] = L.shadeguard_speaker,
	}
end

function mod:OnBossEnable()
	-- Inquisitor Speaker
	self:Log("SPELL_CAST_START", "ShadowBarrier", 434740)
	self:Death("InquisitorSpeakerDeath", 229854)

	-- Shadeguard Speaker
	self:Log("SPELL_CAST_START", "ShadowWave", 458874)
	self:Log("SPELL_CAST_START", "BlessingOfDusk", 443482)
	self:Log("SPELL_AURA_APPLIED", "BlessingOfDuskApplied", 443482)
	self:Death("ShadeguardSpeakerDeath", 229855, 230904)
end

function mod:OnEngage()
	bossCollector = {}
	bossesEngaged = 0
	-- timers started in IEEU
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	for i = 1, 3 do
		local guid = self:UnitGUID(("boss%d"):format(i))
		if guid and not bossCollector[guid] then
			bossCollector[guid] = true
			local mobId = self:MobId(guid)
			if mobId == 229855 or mobId == 230904 then -- Shadeguard Speaker
				bossesEngaged = bossesEngaged + 1
				self:Nameplate(458874, 2.4, guid) -- Shadow Wave
				self:Nameplate(443482, 10.6, guid) -- Blessing of Dusk
			end
			if bossesEngaged == 2 then
				-- there are 3 bosses but we only need to start timers for the 2 Shadeguard Speakers.
				-- Shadow Barrier is cast by the Inquisitor Speaker on pull.
				self:UnregisterEvent(event)
				break
			end
		end
	end
end

-- Inquisitor Speaker

function mod:ShadowBarrier(args)
	-- also cast by trash
	if self:MobId(args.sourceGUID) == 229854 then -- Inquisitor Speaker
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:Nameplate(args.spellId, 24.0, args.sourceGUID)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:InquisitorSpeakerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Shadeguard Speaker

function mod:ShadowWave(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 12.1, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:BlessingOfDusk(args)
		-- also cast by trash
		local mobId = self:MobId(args.sourceGUID)
		if mobId == 229855 or mobId == 230904 and args.time - prev > 1.5 then -- Shadeguard Speaker
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:Nameplate(args.spellId, 25.4, args.sourceGUID)
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:BlessingOfDuskApplied(args)
		-- also cast by trash
		local mobId = self:MobId(args.destGUID)
		if (mobId == 229855 or mobId == 230904) and args.time - prev > 2
				and self:Dispeller("magic", true, args.spellId) then -- Shadeguard Speaker
			prev = args.time
			self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:ShadeguardSpeakerDeath(args)
	self:ClearNameplate(args.destGUID)
end
