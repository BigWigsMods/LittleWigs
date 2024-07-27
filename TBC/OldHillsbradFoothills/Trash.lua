--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Old Hillsbrad Foothills Trash", 560)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	18723, -- Erozion
	17876, -- Thrall
	18887, -- Taretha

	-- To ensure the module is loaded for Incendiary Bombs, mobs from Durnholde Keep:
	17840, -- Durnholde Tracking Hound
	18598, -- Orc Prisoner
	17820, -- Durnholde Rifleman
	17833 -- Durnholde Warden
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly select Erozion's, Thrall's and Taretha's gossip options."
	L.custom_on_autotalk_icon = "ui_chat"

	L.incendiary_bombs = "Incendiary Bombs"
	L.incendiary_bombs_desc = "Display a message when an Incendiary Bomb is planted."
	L.incendiary_bombs_icon = "inv_misc_bomb_05"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_autotalk",
		"incendiary_bombs"
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:RegisterWidgetEvent(522, "BombPlanted")
	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") then
		if C_GossipInfo.GetNumAvailableQuests() > 0 or C_GossipInfo.GetNumActiveQuests() > 0 then return end -- let the player take / turn in the quest

		-- If the player is in a group, do not free Thrall automatically,
		-- because they may deny others a chance to turn in the quest.
		local mobId = self:MobId(self:UnitGUID("npc"))
		if mobId == 17876 and not self:Solo() then
			if self:Classic() then
				-- no scenario APIs in Classic
				return
			else
				local info = C_ScenarioInfo.GetCriteriaInfo(2)
				if info and not info.completed then return end
			end
		end

		if self:GetGossipOptions() then
			-- Erozion:
			-- 33853:I need a pack of incendiary bombs.
			-- Brazen:
			-- 34081:I'm ready to go to Durnholde Keep.
			-- Thrall:
			-- 33364:We are ready to get you out of here, Thrall. Let's go!
			-- 34372:Taretha cannot see you, Thrall.
			-- 35171:The situation is rather complicated, Thrall. It would be best for you to head into the mountains now, before more of Blackmoore's men show up. We'll make sure Taretha is safe.
			-- 34362:Tarren Mill.
			-- 32900:We're ready, Thrall.
			-- Taretha
			-- 34893:Strange wizard?
			-- 33525:We'll get you out, Taretha. Don't worry. I doubt the wizard would wander too far away.
			self:SelectGossipOption(1)
		end
	end
end

function mod:BombPlanted(id, text)
	local bombText = text:match("(%d+).+5")
	if bombText then
		local bombCount = tonumber(bombText)
		if bombCount and bombCount > 0 then
			self:MessageOld("incendiary_bombs", "cyan", "info", CL.count:format(L.incendiary_bombs, bombCount), L.incendiary_bombs_icon)

			if bombCount == 5 then
				self:UnregisterWidgetEvent(id)
				local drakeModule = BigWigs:GetBossModule("Lieutenant Drake", true)
				if drakeModule then
					drakeModule:Enable()
					drakeModule:Warmup(20.5)
				end
			end
		end
	end
end
