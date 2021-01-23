
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ozumat", 643, 104)
if not mod then return end
mod:RegisterEnableMob(40792, 44566) -- Neptulon, Ozumat
mod.engageId = 1047
mod.respawnTime = 26

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects the gossip option to start the fight."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_autotalk",
		"stages",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "EntanglingGrasp", 83463) -- Entangling Grasp, 3 adds that need to be killed in P2 cast this on Neptulon
	self:Log("SPELL_AURA_REMOVED", "EntanglingGraspRemoved", 83463)
	self:Log("SPELL_CAST_SUCCESS", "TidalSurge", 76133) -- the buff Neptulon applies to players in P3
	self:RegisterEvent("GOSSIP_SHOW")
end

function mod:OnEngage()
	-- this stage lasts 1:40 on both difficulties, EJ's entry is incorrect
	self:Bar("stages", 100, CL.stage:format(1), "Achievement_Dungeon_Throne of the Tides") -- Yes, " " is the correct delimiter.
	self:DelayedMessage("stages", 90, "yellow", CL.soon:format(CL.stage:format(2)))
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev, addsAlive = 0, 0
	function mod:EntanglingGrasp()
		addsAlive = addsAlive + 1

		local t = GetTime()
		if t-prev > 10 then
			prev = t
			self:MessageOld("stages", "yellow", "info", CL.stage:format(2), false)
		end
	end
	function mod:EntanglingGraspRemoved()
		addsAlive = addsAlive - 1
		self:MessageOld("stages", "green", nil, CL.add_remaining:format(addsAlive), false)
	end
end

function mod:TidalSurge()
	self:MessageOld("stages", "yellow", "info", CL.stage:format(3), false)
end

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") and self:MobId(self:UnitGUID("npc")) == 40792 then
		if self:GetGossipOptions() then
			self:SelectGossipOption(1, true) -- auto confirm it
		end
	end
end
