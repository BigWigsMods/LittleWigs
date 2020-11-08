
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Corborus", 725, 110)
if not mod then return end
mod:RegisterEnableMob(43438)
mod.engageId = 1056
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.burrow = "Burrow/emerge"
	L.burrow_desc = "Warn when Corborus burrows or emerges."
	L.burrow_message = "Corborus burrows!"
	L.burrow_warning = "Burrow in 5 sec!"
	L.emerge_message = "Corborus emerges!"
	L.emerge_warning = "Emerge in 5 sec!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"burrow",
		{86881, "FLASH"}, -- Crystal Barrage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Barrage", 81634, 81637, 81638, 86881, 92012) -- XXX do we need all this?
end

function mod:OnEngage()
	self:Bar("burrow", 30, L.burrow_message, "ABILITY_HUNTER_PET_WORM")
	self:DelayedMessage("burrow", 25, "yellow", L.burrow_warning)
	self:ScheduleTimer("Burrow", 30)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Burrow()
	self:MessageOld("burrow", "red", "info", L.burrow_message, "ABILITY_HUNTER_PET_WORM")
	self:Bar("burrow", 25, L.emerge_message, "ABILITY_HUNTER_PET_WORM")
	self:DelayedMessage("burrow", 20, "yellow", L.emerge_warning)
	self:ScheduleTimer("Emerge", 25)
end

function mod:Emerge()
	self:MessageOld("burrow", "red", "info", L.emerge_message, "ABILITY_HUNTER_PET_WORM")
	self:Bar("burrow", 90, L.burrow_message, "ABILITY_HUNTER_PET_WORM")
	self:DelayedMessage("burrow", 85, "yellow", L.burrow_warning)
	self:ScheduleTimer("Burrow", 90) --guesstimate
end

function mod:Barrage(args)
	if self:Me(args.destGUID) then
		self:TargetMessageOld(86881, args.destName, "blue", "alarm")
		self:Flash(86881)
	end
end

