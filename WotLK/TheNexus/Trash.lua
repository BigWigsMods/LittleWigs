--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Nexus Trash", 576)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	26730, -- Mage Slayer
	26729 -- Steward
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.slayer = "Mage Slayer"
	L.steward = "Steward"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Mage Slayer ]]--
		30849, -- Spell Lock

		--[[ Steward ]]--
		47779, -- Arcane Torrent
	}, {
		[30849] = L.slayer,
		[47779] = L.steward,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_AURA_APPLIED", "SpellLock", 30849)
	self:Log("SPELL_AURA_APPLIED", "ArcaneTorrent", 47779)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SpellLock(args)
	if self:Dispeller("magic") or self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "yellow", "alarm", nil, nil, true)
	end
end

do
	local playerList, isOnMe = {}, false

	local function announce(self, spellId)
		if self:Dispeller("magic") or isOnMe then
			self:TargetMessageOld(spellId, self:ColorName(playerList), "orange", "alert", nil, nil, true)
		else
			playerList = {} -- TargetMessage wipes the table; if we don't call it, we should do the same manually
		end
		isOnMe = false
	end

	function mod:ArcaneTorrent(args)
		if not self:Player(args.destFlags) then return end -- filter out pets
		if self:Me(args.destGUID) then
			isOnMe = true
		end
		playerList[#playerList+1] = args.destName
		if #playerList == 1 then
			self:ScheduleTimer(announce, 0.3, self, args.spellId)
		end
	end
end
