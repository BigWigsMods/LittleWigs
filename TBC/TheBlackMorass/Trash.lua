
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Black Morass Trash", 733)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	20201, -- Sa'at
	15608, -- Medivh
	17879, -- Chrono Lord Deja
	17880, -- Temporus
	17881 -- Aeonus
)

local prevWave = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.wave = "Wave Warnings"
	L.wave_desc = "Announce approximate warning messages for the waves."

	--L.disable_trigger = "We will triumph. It is only a matter... of time."
	--L.reset_trigger = "No! Damn this feeble, mortal coil!"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"wave",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("UPDATE_WORLD_STATES")

	self:Death("BossDeath", 17879, 17880) -- Chrono Lord Deja, Temporus
	self:Death("Disable", 17881) -- Aeonus
end

function mod:OnDisable()
	prevWave = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UPDATE_WORLD_STATES()
	for i = 1, GetNumWorldStateUI() do
		local _, state, _, num = GetWorldStateUIInfo(i)
		if state > 0 and num then -- Check if state is visible and if text exists.
			local wave = num:match("(%d+).+18")
			if wave then
				local currentWave = tonumber(wave)
				if currentWave and currentWave ~= prevWave then
					prevWave = currentWave
					local rift = self:SpellName(147840) -- Time Rift
					self:Bar("wave", 15, CL.count:format(rift, currentWave), "INV_Misc_ShadowEgg")
					if currentWave == 6 then
						local chronoLordDeja = EJ_GetEncounterInfo(552)
						self:Message("wave", "Attention", "Info", CL.custom_sec:format(chronoLordDeja, 15), false)
					elseif currentWave == 12 then
						local temporus = EJ_GetEncounterInfo(553)
						self:Message("wave", "Attention", "Info", CL.custom_sec:format(temporus, 15), false)
					elseif currentWave == 18 then
						local aeonus = EJ_GetEncounterInfo(554)
						self:Message("wave", "Attention", "Info", CL.custom_sec:format(aeonus, 15), false)
					else
						self:Message("wave", "Attention", "Info", CL.custom_sec:format(CL.count:format(rift, currentWave), 15), false)
						self:Bar("wave", 135, CL.count:format(rift, currentWave+1), "INV_Misc_ShadowEgg") -- 120s + 15s
					end
				end
			end
		end
	end
end

function mod:BossDeath(args)
	self:Bar("wave", 45, CL.count:format(self:SpellName(147840), args.mobId == 17879 and 7 or 13), "INV_Misc_ShadowEgg") -- 30s + 15s
end

