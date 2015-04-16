
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Black Morass Trash", 733)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	15608 -- Medivh
)

local prevWave = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.next_wave = "Next Wave"

	L.wave = "Wave Warnings"
	L.wave_desc = "Announce approximate warning messages for the waves."

	L.wave_bar = "%s: Wave %s"
	L.multiwave_bar = "Multiple waves"

	L.wave_message15s = "%s in ~15 seconds!"
	L.wave_message140s = "%s in ~140 seconds!"

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

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UPDATE_WORLD_STATES()
	for i = 1, GetNumWorldStateUI() do
		local _, state, _, num = GetWorldStateUIInfo(i)
		if state > 0 and num then -- Check if state is visible and if text exists.
			local wave = num:match("%d+")
			if wave then
				local currentWave = tonumber(wave)
				if currentWave and currentWave ~= prevWave then
					prevWave = currentWave
					currentWave = currentWave + 1
					self:StopBar(L.multiwave_bar)
					if currentWave == 6 then
						local chronoLordDeja = EJ_GetEncounterInfo(552)
						self:Message("wave", "Attention", nil, L.wave_message15s:format(chronoLordDeja), false)
						self:CDBar("wave", 15, L.wave_bar:format(chronoLordDeja, currentWave), "INV_Misc_ShadowEgg")
					elseif currentWave == 12 then
						local temporus = EJ_GetEncounterInfo(553)
						self:Message("wave", "Attention", nil, L.wave_message15s:format(temporus), false)
						self:CDBar("wave", 15, L.wave_bar:format(temporus, currentWave), "INV_Misc_ShadowEgg")
					elseif currentWave == 18 then
						local aeonus = EJ_GetEncounterInfo(554)
						self:Message("wave", "Attention", nil, L.wave_message15s:format(aeonus), false)
						self:CDBar("wave", 15, L.wave_bar:format(aeonus, currentWave), "INV_Misc_ShadowEgg")
					else
						self:Message("wave", "Attention", nil, L.wave_message15s:format(L.next_wave), false)
						self:CDBar("wave", 127, L.multiwave_bar, "INV_Misc_ShadowEgg")
						self:CDBar("wave", 15, L.wave_bar:format(L.next_wave, currentWave), "INV_Misc_ShadowEgg")
					end
				end
			end
		end
	end
end

function mod:BossDeath(args)
	local waveCount = 0
	if args.mobId == 17879 then -- Chrono Lord Deja
		waveCount = 7
	elseif args.mobId == 17880 then -- Temporus
		waveCount = 13
	end
	self:Message("wave", "Attention", nil, L.wave_message140s:format(L.next_wave), false)
	self:CDBar("wave", 125, L.wave_bar:format(L.next_wave, waveCount), "INV_Misc_ShadowEgg")
end

