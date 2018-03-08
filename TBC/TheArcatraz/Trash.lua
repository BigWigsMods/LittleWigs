--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Arcatraz Trash", 731)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	20898 -- Gargantuan Abyssal
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.abyssal = "Gargantuan Abyssal"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Gargantuan Abyssal ]]--
		38903, -- Meteor
	}, {
		[38903] = L.abyssal,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_CAST_START", "Meteor", 38903)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0

	function mod:Meteor(args)
		local t = GetTime()
		if t - prev > 1 then
			self:Message(args.spellId, "Important", "Warning", CL.incoming:format(args.spellName))
		end
		self:Bar(args.spellId, 2)
	end
end
