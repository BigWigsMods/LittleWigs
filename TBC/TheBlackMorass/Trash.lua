
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Black Morass Trash", 269)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	20201, -- Sa'at
	15608, -- Medivh
	17879, -- Chrono Lord Deja
	17880, -- Temporus
	17881 -- Aeonus
)

--------------------------------------------------------------------------------
-- Locals
--

local prevWave = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.wave = "Wave Warnings"
	L.wave_desc = "Announce approximate warning messages for the waves."

	L.medivh = "Medivh"
	L.rift = "Time Rift"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"wave",
	}
end

function mod:OnBossEnable()
	self:RegisterWidgetEvent(self:Classic() and 3120 or 527, "UpdateWaveTimers")

	self:Death("BossDeath", 17879, 17880) -- Chrono Lord Deja, Temporus
	self:Death("Disable", 17881) -- Aeonus
	self:Death("MedivhDies", 15608)
end

function mod:OnBossDisable()
	prevWave = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UpdateWaveTimers(id, text)
	local wave = text:match("(%d+).+18")
	if wave then
		local currentWave = tonumber(wave)
		if currentWave and currentWave ~= prevWave then
			prevWave = currentWave
			self:Bar("wave", 15, CL.count:format(L.rift, currentWave), "INV_Misc_ShadowEgg")
			if currentWave == 6 then
				local chronoLordDeja = self:BossName(552) -- Chrono Lord Deja
				self:Message("wave", "yellow", CL.custom_sec:format(chronoLordDeja, 15), false)
			elseif currentWave == 12 then
				local temporus = self:BossName(553) -- Temporus
				self:Message("wave", "yellow", CL.custom_sec:format(temporus, 15), false)
			elseif currentWave == 18 then
				self:UnregisterWidgetEvent(id)
				local aeonus = self:BossName(554) -- Aeonus
				self:Message("wave", "yellow", CL.custom_sec:format(aeonus, 15), false)
			else
				self:Message("wave", "yellow", CL.custom_sec:format(CL.count:format(L.rift, currentWave), 15), false)
				self:Bar("wave", self:Classic() and 137 or 135, CL.count:format(L.rift, currentWave+1), "INV_Misc_ShadowEgg") -- (Retail 120s, Classic 122s) + 15s
			end
			self:PlaySound("wave", "info")
		end
	end
end

function mod:BossDeath(args)
	self:Bar("wave", self:Classic() and 137 or 45, CL.count:format(L.rift, args.mobId == 17879 and 7 or 13), "INV_Misc_ShadowEgg") -- (Retail 30s, Classic 122s) + 15s
end

do
	local function Reset()
		prevWave = 0
	end
	function mod:MedivhDies()
		self:SimpleTimer(Reset, 15)
		self:SendMessage("BigWigs_StopBars", self)
		self:Bar("wave", 300, L.medivh, "spell_nature_timestop")
	end
end
