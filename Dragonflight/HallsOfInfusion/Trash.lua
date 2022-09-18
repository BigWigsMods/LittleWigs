if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Halls of Infusion Trash", 2527)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	190348, -- Primalist Ravager
	190345, -- Primalist Geomancer
	190342, -- Containment Apparatus
	190340, -- Refti Defender
	190362, -- Dazzling Dragonfly
	190366, -- Curious Swoglet (trash version)
	195399, -- Curious Swoglet (boss version)
	190368, -- Flamecaller Aymi
	190401, -- Gusting Proto-Dragon
	190403, -- Oceanic Proto-Dragon
	190404  -- Earthen Proto-Dragon
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.primalist_ravager = "Primalist Ravager"
	L.primalist_geomancer = "Primalist Geomancer"
	L.containment_apparatus = "Containment Apparatus"
	L.refti_defender = "Refti Defender"
	L.dazzling_dragonfly = "Dazzling Dragonfly"
	L.curious_swoglet = "Curious Swoglet"
	L.flamecaller_aymi = "Flamecaller Aymi"
	L.gusting_protodragon = "Gusting Proto-Dragon"
	L.oceanic_protodragon = "Oceanic Proto-Dragon"
	L.earthen_protodragon = "Earthen Proto-Dragon"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Primalist Ravager
		374080, -- Interrupting Gust
		-- Primalist Geomancer
		--374066, -- Earth Shield
		-- Containment Apparatus
		374045, -- Expulse
		-- Refti Defender
		374339, -- Demoralizing Shout
		-- Dazzling Dragonfly
		374563, -- Dazzle
		-- Curious Swoglet
		{374389, "DISPEL"}, -- Gulp Swog Toxin
		-- Flamecaller Aymi
		374724, -- Molten Subduction
		-- Gusting Proto-Dragon
		375348, -- Gusting Breath
		-- Oceanic Proto-Dragon
		375351, -- Oceanic Breath
		-- Earthen Proto-Dragon
		375327, -- Tectonic Breath
	}, {
		[374080] = L.primalist_ravager,
		--[374066] = L.primalist_geomancer,
		[374045] = L.containment_apparatus,
		[374339] = L.refti_defender,
		[374563] = L.dazzling_dragonfly,
		[374389] = L.curious_swoglet,
		[374724] = L.flamecaller_aymi,
		[375348] = L.gusting_protodragon,
		[375351] = L.oceanic_protodragon,
		[375327] = L.earthen_protodragon,
	}
end

function mod:OnBossEnable()
	-- Primalist Ravager
	self:Log("SPELL_CAST_START", "InterruptingGust", 374080)

	-- Primalist Geomancer
	--self:Log("SPELL_CAST_START", "EarthShield", 374066)

	-- Containment Apparatus
	self:Log("SPELL_CAST_START", "Expulse", 374045)

	-- Refti Defender
	self:Log("SPELL_CAST_START", "DemoralizingShout", 374339)

	-- Dazzling Dragonfly
	self:Log("SPELL_CAST_START", "Dazzle", 374563)

	-- Curious Swoglet
	self:Log("SPELL_AURA_APPLIED_DOSE", "GulpSwogToxinApplied", 374389)

	-- Flamecaller Aymi
	self:Log("SPELL_AURA_APPLIED", "MoltenSubductionApplied", 374724)

	-- Gusting Proto-Dragon
	self:Log("SPELL_CAST_START", "GustingBreath", 375348)

	-- Oceanic Proto-Dragon
	self:Log("SPELL_CAST_START", "OceanicBreath", 375351)

	-- Earthen Proto-Dragon
	self:Log("SPELL_CAST_START", "TectonicBreath", 375327)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Primalist Ravager

function mod:InterruptingGust(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
end

-- Primalist Geomancer

-- TODO this is cast during rp fighting and UnitAffectingCombat is always true
function mod:EarthShield(args)
	local unit = self:GetUnitIdByGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) then
		--self:Message(args.spellId, "orange")
		--self:PlaySound(args.spellId, "alert")
	end
end

-- Containment Apparatus

function mod:Expulse(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Refti Defender

function mod:DemoralizingShout(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

-- Dazzling Dragonfly

function mod:Dazzle(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Curious Swoglet

do
	local prev = 0
	function mod:GulpSwogToxinApplied(args)
		if args.amount >= 6 and args.amount % 2 == 0 and (self:Dispeller("poison", nil, args.spellId) or self:Me(args.destGUID)) then
			local t = args.time
			if t - prev > 1 then
				-- Insta-kill at 10 stacks
				self:StackMessage(args.spellId, "red", args.destName, args.amount, 8)
				if args.amount <= 6 then
					self:PlaySound(args.spellId, "alert", nil, args.destName)
				else
					self:PlaySound(args.spellId, "warning", nil, args.destName)
				end
			end
		end
	end
end

-- Flamecaller Aymi

function mod:MoltenSubductionApplied(args)
	-- either movement dispel the target, target immunes, or everyone stacks on target (meteor)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end

-- Gusting Proto-Dragon

function mod:GustingBreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Oceanic Proto-Dragon

function mod:OceanicBreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Earthen Proto-Dragon

function mod:TectonicBreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end
