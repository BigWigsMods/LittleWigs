if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Halls of Infusion Trash", 2527)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	190366, -- Curious Swoglet (trash version)
	195399 -- Curious Swoglet (boss version)
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.curious_swoglet = "Curious Swoglet"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{374389, "DISPEL"}, -- Gulp Swog Toxin
	}, {
		[374389] = L.curious_swoglet,
	}
end

function mod:OnBossEnable()
	-- Curious Swoglet
	self:Log("SPELL_AURA_APPLIED_DOSE", "GulpSwogToxinApplied", 374389)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Curious Swoglet

do
	local prev = 0
	function mod:GulpSwogToxinApplied(args)
		if args.amount >= 5 and (self:Dispeller("poison", nil, args.spellId) or self:Me(args.destGUID)) then
			local t = args.time
			if t - prev > 1 then
				-- Insta-kill at 10 stacks
				self:StackMessage(args.spellId, "red", args.destName, args.amount, 8)
				self:PlaySound(args.spellId, "warning")
			end
		end
	end
end