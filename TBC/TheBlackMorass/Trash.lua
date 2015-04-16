
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

	L.wave_bar = "Wave %s"
	L.multiwave_bar = "Multiple waves"

	L.wave_message15s = "%s in 15 seconds!"
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
					self:CDBar("wave", 15, L.wave_bar:format(currentWave), "INV_Misc_ShadowEgg")
					if currentWave == 6 then
						local chronoLordDeja = EJ_GetEncounterInfo(552)
						self:Message("wave", "Attention", nil, L.wave_message15s:format(chronoLordDeja), false)
					elseif currentWave == 12 then
						local temporus = EJ_GetEncounterInfo(553)
						self:Message("wave", "Attention", nil, L.wave_message15s:format(temporus), false)
					elseif currentWave == 18 then
						local aeonus = EJ_GetEncounterInfo(554)
						self:Message("wave", "Attention", nil, L.wave_message15s:format(aeonus), false)
					else
						self:Message("wave", "Attention", nil, L.wave_message15s:format(L.wave_bar:format(currentWave)), false)
						self:CDBar("wave", 135, L.wave_bar:format(currentWave+1), "INV_Misc_ShadowEgg") -- 120s + 15s
					end
				end
			end
		end
	end
end

function mod:BossDeath(args)
	-- XXX both these timers might be based on something else
	if args.mobId == 17879 then -- Chrono Lord Deja
		self:CDBar("wave", 135, L.wave_bar:format(7), "INV_Misc_ShadowEgg") -- 120s + 15s
	elseif args.mobId == 17880 then -- Temporus
		self:CDBar("wave", 108, L.wave_bar:format(13), "INV_Misc_ShadowEgg") -- 93s + 15s
	end
	--self:Message("wave", "Attention", nil, L.wave_message140s:format(L.wave_bar:format(waveCount)), false)
end

