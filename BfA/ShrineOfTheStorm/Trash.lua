
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Shrine of the Storm Trash", 1864)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	134139, -- Shrine Templar
	136186, -- Tidesage Spiritualist
	139800, -- Galecaller Apprentice
	136214, -- Windspeaker Heldis
	139799, -- Ironhull Apprentice
	134150, -- Runecarver Sorn
	136249, -- Guardian Elemental
	134417, -- Deepsea Ritualist
	134514, -- Abyssal Cultist
	134418, -- Drowned Depthbringer
	134144, -- Living Current
	134338  -- Tidesage Enforcer
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.templar = "Shrine Templar"
	L.spiritualist = "Tidesage Spiritualist"
	L.galecaller_apprentice = "Galecaller Apprentice"
	L.windspeaker = "Windspeaker Heldis"
	L.ironhull_apprentice = "Ironhull Apprentice"
	L.runecarver = "Runecarver Sorn"
	L.guardian_elemental = "Guardian Elemental"
	L.ritualist = "Deepsea Ritualist"
	L.cultist = "Abyssal Cultist"
	L.depthbringer = "Drowned Depthbringer"
	L.living_current = "Living Current"
	L.enforcer = "Tidesage Enforcer"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Shrine Templar
		276268, -- Heaving Blow
		267977, -- Tidal Surge
		267981, -- Protective Aura
		-- Tidesage Spiritualist
		268050, -- Anchor of Binding
		{276265, "DISPEL"}, -- Swiftness
		268030, -- Mending Rapids
		-- Galecaller Apprentice
		274437, -- Tempest
		-- Living Current
		268027, -- Rising Tides
		-- Windspeaker Heldis
		268177, -- Windblast
		268187, -- Gale Winds
		268184, -- Minor Swiftness Ward
		-- Ironhull Apprentice
		274631, -- Lesser Blessing of Ironsides
		{274633, "TANK"}, -- Sundering Blow
		276292, -- Whirling Slam
		-- Runecarver Sorn
		268211, -- Minor Reinforcing Ward
		268214, -- Carve Flesh
		-- Guardian Elemental
		268239, -- Shipbreaker Storm
		{268233, "DISPEL"}, -- Electrifying Shock
		-- Tidesage Enforcer
		268273, -- Deep Smash
		-- Deepsea Ritualist
		268309, -- Unending Darkness
		{276297, "SAY_COUNTDOWN"}, -- Void Seed
		-- Abyssal Cultist
		268391, -- Mental Assault
		268375, -- Detect Thoughts
		-- Drowned Depthbringer
		268322, -- Touch of the Drowned
	}, {
		[276268] = L.templar,
		[268050] = L.spiritualist,
		[274437] = L.galecaller_apprentice,
		[268027] = L.living_current,
		[268177] = L.windspeaker,
		[274631] = L.ironhull_apprentice,
		[268211] = L.runecarver,
		[268239] = L.guardian_elemental,
		[268273] = L.enforcer,
		[268309] = L.ritualist,
		[268391] = L.cultist,
		[268322] = L.depthbringer,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "HeavingBlow", 276268)
	self:Log("SPELL_CAST_START", "TidalSurge", 267977)
	self:Log("SPELL_CAST_START", "ProtectiveAura", 267981)
	self:Log("SPELL_CAST_SUCCESS", "AnchorOfBinding", 268050)
	self:Log("SPELL_AURA_APPLIED", "Swiftness", 276265)
	self:Log("SPELL_CAST_START", "MendingRapids", 268030)
	self:Log("SPELL_CAST_START", "Tempest", 274437)
	self:Log("SPELL_CAST_START", "Windblast", 268177)
	self:Log("SPELL_CAST_START", "GaleWinds", 268187)
	self:Log("SPELL_CAST_START", "MinorSwiftnessWard", 268184)
	self:Log("SPELL_CAST_START", "LesserBlessingOfIronsides", 274631)
	self:Log("SPELL_AURA_APPLIED", "SunderingBlow", 274633)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SunderingBlow", 274633)
	self:Log("SPELL_CAST_START", "WhirlingSlam", 276292)
	self:Log("SPELL_CAST_START", "MinorReinforcingWard", 268211)
	self:Log("SPELL_CAST_START", "CarveFlesh", 268214)
	self:Log("SPELL_CAST_START", "ShipbreakerStorm", 268239)
	self:Log("SPELL_AURA_APPLIED", "ElectrifyingShock", 268233)
	self:Log("SPELL_CAST_START", "UnendingDarkness", 268309)
	self:Log("SPELL_AURA_APPLIED", "VoidSeedApplied", 276297)
	self:Log("SPELL_AURA_REMOVED", "VoidSeedRemoved", 276297)
	self:Log("SPELL_CAST_START", "MentalAssault", 268391)
	self:Log("SPELL_CAST_START", "DetectThoughts", 268375)
	self:Log("SPELL_CAST_START", "TouchOfTheDrowned", 268322)
	self:Log("SPELL_AURA_APPLIED", "TouchOfTheDrownedApplied", 268322)
	self:Log("SPELL_CAST_START", "RisingTides", 268027)
	self:Log("SPELL_CAST_START", "DeepSmash", 268273)
	self:Log("SPELL_CAST_SUCCESS", "DeepSmashSuccess", 268273)

	self:Death("WindspeakerDeath", 136214)
	self:Death("RunecarverDeath", 134150)
	self:Death("LivingCurrentDeath", 134144)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:HeavingBlow(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:TidalSurge(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:ProtectiveAura(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:AnchorOfBinding(args)
		local t = args.time
		if t-prev > 1.5 then
			local unit = self:GetUnitIdByGUID(args.sourceGUID)
			if unit and IsItemInRange(37727, unit .. "target") then -- Ruby Acorn, 5yd
				prev = t
				self:Message(args.spellId, "blue", CL.near:format(args.spellName))
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end

function mod:Swiftness(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Player(args.destFlags) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:MendingRapids(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:Tempest(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:Windblast(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:GaleWinds(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 22)
end

function mod:WindspeakerDeath(args)
	self:StopBar(268187) -- Gale Winds
	self:StopBar(268184) -- Minor Swiftness Ward
end

function mod:MinorSwiftnessWard(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 32)
end

function mod:LesserBlessingOfIronsides(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:SunderingBlow(args)
	if self:Me(args.destGUID) then
		self:StackMessageOld(args.spellId, args.destName, args.amount, "purple")
		self:PlaySound(args.spellId, "info")
	end
end

function mod:WhirlingSlam(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:MinorReinforcingWard(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(268214, "orange", name) -- Carve Flesh
		self:PlaySound(268214, "alert") -- Carve Flesh
	end

	local prev = 0
	function mod:CarveFlesh(args)
		self:Bar(args.spellId, args.time - prev > 16 and 11 or 18)
		prev = args.time
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
	end
end

function mod:RunecarverDeath(args)
	self:StopBar(268214)
end

function mod:ShipbreakerStorm(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 13)
end

function mod:ElectrifyingShock(args)
	if self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info")
		self:CDBar(args.spellId, 15)
	end
end

function mod:UnendingDarkness(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:VoidSeedApplied(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "blue", args.destName)
		self:PlaySound(args.spellId, "alarm")
		-- Duration seems to vary, so we can't hardcode a fixed duration
		local count = 0
		local maxExpirationTime = 0
		for i = 1, 100 do
			local _, _, _, _, _, expirationTime, _, _, _, spellId = UnitAura(args.destName, i, "HARMFUL")
			if spellId == args.spellId then
				count = count + 1
				if count > 1 then
					BigWigs:Error(string.format(
						"Void seed applied: count: %d, duration: %d, previous max duration: %d. Tell the authors!",
						count, expirationTime - GetTime(), maxExpirationTime - GetTime()
					))
				end
				if expirationTime > maxExpirationTime then
					maxExpirationTime = expirationTime
				end
			elseif not spellId then
				break
			end
		end
		local duration = maxExpirationTime - GetTime()
		if duration >= 0 then
			self:TargetBar(args.spellId, duration, args.destName)
			self:SayCountdown(args.spellId, duration)
		end
	end
end

function mod:VoidSeedRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "blue", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
		self:StopBar(args.spellId, args.destName)
		self:CancelSayCountdown(args.spellId)
	end
end

do
	local prev = 0
	function mod:MentalAssault(args)
		local t = args.time
		if t-prev > 1 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:DetectThoughts(args)
		local t = args.time
		if t-prev > 1 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "info")
		end
	end
end

do
	local prev = 0
	function mod:TouchOfTheDrowned(args)
		local t = args.time
		if t-prev > 1 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:TouchOfTheDrownedApplied(args)
	if self:UnitBuff(args.destName, 5697) then return end -- Warlock Unending Breath
	if self:Dispeller("magic") or IsSpellKnown(5697) then -- Warlock Unending Breath
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:RisingTides(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 23)
end

function mod:LivingCurrentDeath(args)
	self:StopBar(268027)
end

do
	local prev = 0
	function mod:DeepSmash(args)
		local t = args.time
		if self:Tank() and t-prev > 1 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end

	function mod:DeepSmashSuccess(args)
		local t = args.time
		if not self:Tank() and t-prev > 1 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end
