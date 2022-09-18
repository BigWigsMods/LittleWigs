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
	190366, -- Curious Swoglet (trash version)
	195399, -- Curious Swoglet (boss version)
	190368  -- Flamecaller Aymi
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.primalist_ravager = "Primalist Ravager"
	L.primalist_geomancer = "Primalist Geomancer"
	L.curious_swoglet = "Curious Swoglet"
	L.flamecaller_aymi = "Flamecaller Aymi"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Primalist Ravager
		374080, -- Interrupting Gust
		-- Primalist Geomancer
		374066, -- Earth Shield
		-- Curious Swoglet
		{374389, "DISPEL"}, -- Gulp Swog Toxin
		-- Flamecaller Aymi
		374724, -- Molten Subduction
	}, {
		[374080] = L.primalist_ravager,
		[374066] = L.primalist_geomancer,
		[374389] = L.curious_swoglet,
		[374724] = L.flamecaller_aymi,
	}
end

function mod:OnBossEnable()
	-- Primalist Ravager
	self:Log("SPELL_CAST_START", "InterruptingGust", 374080)
	-- Primalist Geomancer
	self:Log("SPELL_CAST_START", "EarthShield", 374066)
	-- Curious Swoglet
	self:Log("SPELL_AURA_APPLIED_DOSE", "GulpSwogToxinApplied", 374389)
	-- Flamecaller Aymi
	self:Log("SPELL_AURA_APPLIED", "MoltenSubductionApplied", 374724)
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

function mod:EarthShield(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

-- Curious Swoglet

do
	local prev = 0
	function mod:GulpSwogToxinApplied(args)
		if args.amount >= 5 and (self:Dispeller("poison", nil, args.spellId) or self:Me(args.destGUID)) then
			local t = args.time
			if t - prev > 1 then
				-- Insta-kill at 10 stacks
				self:StackMessage(args.spellId, "red", args.destName, args.amount, 8)
				self:PlaySound(args.spellId, "warning", nil, args.destName)
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
