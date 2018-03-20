--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Utgarde Pinnacle Trash", 575)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	26696 -- Ymirjar Berserker
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.berserker = "Ymirjar Berserker"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Ymirjar Berserker ]]--
		49106, -- Terrify
	}, {
		[49106] = L.berserker,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_AURA_APPLIED", "Terrify", 49106)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local playerList = mod:NewTargetList()

	function mod:Terrify(args)
		playerList[#playerList+1] = args.destName
		if #playerList == 1 then
			self:ScheduleTimer("TargetMessage", 0.3, args.spellId, playerList, "Urgent", "Alert", nil, nil, self:Dispeller("magic"))
		end
	end
end
