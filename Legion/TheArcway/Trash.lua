
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Arcway Trash", 1516)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	98756, -- Arcane Anomaly
	106059, -- Warp Shade
	105952, -- Withered Manawraith
	98770, -- Wrathguard Felblade
	105617 -- Eredar Chaosbringer
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.anomaly = "Arcane Anomaly"
	L.shade = "Warp Shade"
	L.wraith = "Withered Manawraith"
	L.blade = "Wrathguard Felblade"
	L.chaosbringer = "Eredar Chaosbringer"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Arcane Anomaly
		211217, -- Arcane Slicer
		226206, -- Arcane Reconstitution

		-- Warp Shade
		211115, -- Phase Breach

		-- Withered Manawraith
		210750, -- Collapsing Rift

		-- Wrathguard Felblade
		211745, -- Fel Strike

		-- Eredar Chaosbringer
		226285, -- Demonic Ascension
		211632, -- Brand of the Legion
		211757, -- Portal: Argus
	}, {
		[211217] = L.anomaly,
		[211115] = L.shade,
		[210750] = L.wraith,
		[211745] = L.blade,
		[226285] = L.chaosbringer,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	-- Arcane Anomaly
	self:Log("SPELL_CAST_START", "ArcaneSlicer", 211217)

	-- Arcane Anomaly and Warp Shade
	self:Log("SPELL_CAST_START", "ArcaneReconstitution", 226206)

	-- Warp Shade
	self:Log("SPELL_CAST_START", "PhaseBreach", 211115)

	-- Withered Manawraith, Wrathguard Felblade
	self:Log("SPELL_AURA_APPLIED", "PeriodicDamage", 210750, 211745) -- Collapsing Rift, Fel Strike
	self:Log("SPELL_PERIODIC_DAMAGE", "PeriodicDamage", 210750, 211745)
	self:Log("SPELL_PERIODIC_MISSED", "PeriodicDamage", 210750, 211745)

	-- Eredar Chaosbringer
	self:Log("SPELL_CAST_START", "BrandoftheLegion", 211632)
	self:Log("SPELL_CAST_START", "DemonicAscension", 226285)
	self:Log("SPELL_CAST_START", "PortalArgus", 211757)
	self:Log("SPELL_AURA_APPLIED", "DemonicAscensionApplied", 226285)
	self:Log("SPELL_DISPEL", "DemonicAscensionDispelled", "*")
	self:Log("SPELL_AURA_APPLIED", "BrandoftheLegionApplied", 211632)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Arcane Anomaly
function mod:ArcaneSlicer(args)
	self:MessageOld(args.spellId, "orange", "warning", CL.casting:format(args.spellName))
end

-- Arcane Anomaly and Warp Shade
function mod:ArcaneReconstitution(args)
	self:MessageOld(args.spellId, "orange", self:Interrupter() and "alarm", CL.casting:format(args.spellName))
end

-- Warp Shade
function mod:PhaseBreach(args)
	self:MessageOld(args.spellId, "yellow", self:Interrupter() and "alarm", CL.casting:format(args.spellName))
end

-- Withered Manawraith, Wrathguard Felblade
do
	local prev = 0
	function mod:PeriodicDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:MessageOld(args.spellId, "blue", "warning", CL.underyou:format(args.spellName))
			end
		end
	end
end

-- Eredar Chaosbringer
function mod:BrandoftheLegion(args)
	if not self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by warlocks
		self:MessageOld(args.spellId, "yellow", self:Interrupter() and "alarm", CL.casting:format(args.spellName))
	end
end

function mod:BrandoftheLegionApplied(args)
	if self:Dispeller("magic", true) and not UnitIsPlayer(args.destName) then
		self:TargetMessageOld(args.spellId, args.destName, "yellow", "alarm", nil, nil, true)
	end
end

function mod:DemonicAscension(args)
	if not self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by warlocks
		self:MessageOld(args.spellId, "orange", "alarm", CL.casting:format(args.spellName))
	end
end

function mod:DemonicAscensionApplied(args)
	if not UnitIsPlayer(args.destName) then
		self:TargetMessageOld(args.spellId, args.destName, "orange", "warning", nil, nil, true)
	end
end

function mod:DemonicAscensionDispelled(args)
	if args.extraSpellId == 226285 then
		self:MessageOld(226285, "green", "info", CL.removed_by:format(args.extraSpellName, self:ColorName(args.sourceName)))
	end
end

function mod:PortalArgus(args)
	self:MessageOld(args.spellId, "orange", self:Interrupter() and "alarm", CL.casting:format(args.spellName))
end
