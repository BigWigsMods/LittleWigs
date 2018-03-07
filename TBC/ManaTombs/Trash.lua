--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mana-Tombs Trash", 732)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	19307 -- Nexus Terror
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.nexus_terror = "Nexus Terror"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Nexus Terror ]]--
		{34322, "SAY"}, -- Psychic Scream
	}, {
		[34322] = L.nexus_terror,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_AURA_APPLIED", "PsychicScream", 34322)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local playerList = mod:NewTargetList()

	function mod:PsychicScream(args)
		if self:Me(args.destGUID) then
			self:Say(args.spellId) -- helps prioritizing dispelling those who are about to run into some pack
		end
		playerList[#playerList+1] = args.destName
		if #playerList == 1 then
			self:ScheduleTimer("TargetMessage", 0.3, args.spellId, playerList, "Urgent", "Alert", nil, nil, self:Dispeller("magic"))
		end
	end
end
