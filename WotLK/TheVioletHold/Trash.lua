
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Violet Hold Trash", 608)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	30658, -- Lieutenant Sinclari
	-- Bosses
	29315, -- Erekem
	29316, -- Moragg
	29313, -- Ichoron
	29266, -- Xevozz
	29312, -- Lavanthor
	29314, -- Zuramat the Obliterator
	-- Replacements mobs for above bosses.
	-- They spawn if you kill the above bosses but fail the encounter afterwards.
	-- You don't get to kill the same bosses again.
	32226, -- Arakkoa Windwalker (Erekem)
	32235, -- Chaos Watcher (Moragg)
	32234, -- Swirling Water Revenant (Ichoron)
	32231, -- Ethereal Wind Trader (Xevozz)
	32237, -- Lava Hound (Lavanthor)
	32230 -- Void Lord (Zuramat the Obliterator)
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
	L.portals = CL.portals
	L.portals_desc = "Information about portals."
	L.portals_icon = "spell_arcane_portaldalaran"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"portals",
	}
end

function mod:OnBossEnable()
	self:RegisterWidgetEvent(self:Classic() and 3895 or 566, "UpdateWaveTimers")
	self:Death("BossDeaths", 29315, 29316, 29313, 29266, 29312, 29314, 32226, 32230, 32231, 32234, 32235, 32237)
	self:Death("Disable", 31134)
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
			if currentWave == 6 or currentWave == 12 then
				self:Message("portals", "cyan", CL.incoming:format(CL.boss), L.portals_icon)
				self:StopBar(CL.count:format(CL.portal, currentWave))
				self:PlaySound("portals", "info")
			elseif currentWave == 18 then
				self:UnregisterWidgetEvent(id)
				local cyanigosa = self:BossName(632) -- Cyanigosa
				self:Message("portals", "cyan", CL.custom_sec:format(cyanigosa, 17), L.portals_icon)
				self:Bar("portals", 17, CL.count:format(CL.portal, currentWave), L.portals_icon)
				self:PlaySound("portals", "info")
			else
				-- The single mobs (Guardian/Keeper) are 15s, the groups are about 12s. The spawn in random so stick to 15s.
				self:Bar("portals", 15, CL.count:format(CL.portal, currentWave), L.portals_icon)
				self:Message("portals", "cyan", CL.custom_sec:format(CL.count:format(CL.portal, currentWave), 15), L.portals_icon)
				self:Bar("portals", 134, CL.count:format(CL.portal, currentWave+1), L.portals_icon) -- 119s + 15s depending on spawn, sometimes it's 101s + 15s if the spawn is a group. Stick with 134s.
				self:PlaySound("portals", "info")
			end
		end
	end
end

function mod:BossDeaths()
	local count = prevWave+1
	if self:Classic() then
		self:Bar("portals", 48, CL.count:format(CL.portal, count), L.portals_icon) -- 33s + 15s
	else
		self:Bar("portals", count == 7 and 35 or 30, CL.count:format(CL.portal, count), L.portals_icon) -- (20s or 15s) + 15s
	end
end
