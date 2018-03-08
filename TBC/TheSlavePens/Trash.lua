--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Slave Pens Trash", 728)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	21128 -- Coilfang Ray
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.coilfang_ray = "Coilfang Ray"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Coilfang Ray ]]--
		{34984, "SAY"}, -- Psychic Horror
	}, {
		[34984] = L.coilfang_ray,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_AURA_APPLIED", "PsychicHorror", 34984)
	self:Log("SPELL_AURA_REMOVED", "PsychicHorrorRemoved", 34984)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PsychicHorror(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId) -- helps prioritizing dispelling those who are about to run into some pack
	end
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alert", nil, nil, self:Dispeller("magic"))
	self:TargetBar(args.spellId, 3, args.destName)
end

function mod:PsychicHorrorRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
