--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Magisters' Terrace Trash", 585)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	24683, -- Sunblade Mage Guard
	24685, -- Sunblade Magister
	24762 -- Sunblade Keeper
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.mage_guard = "Sunblade Mage Guard"
	L.magister = "Sunblade Magister"
	L.keeper = "Sunblade Keeper"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Sunblade Mage Guard ]]--
		44475, -- Magic Dampening Field
		--[[ Sunblade Magister ]]--
		44644, -- Arcane Nova
		--[[ Sunblade Keeper ]]--
		44765, -- Banish

	}, {
		[44475] = L.mage_guard,
		[44644] = L.magister,
		[44765] = L.keeper,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_AURA_APPLIED", "MagicDampeningField", 44475)
	self:Log("SPELL_CAST_START", "ArcaneNova", 44644, 46036) -- normal, heroic
	self:Log("SPELL_AURA_APPLIED", "Banish", 44765)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MagicDampeningField(args)
	if self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "orange", "alert")
	end
end

do
	local prev = 0
	function mod:ArcaneNova(args)
		local t = GetTime()
		if t - prev > 1 then
			prev = t
			self:MessageOld(44644, "orange", self:Ranged() and "warning" or "alert", CL.casting:format(args.spellName))
		end
	end
end

function mod:Banish(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow", "alarm", nil, nil, self:Dispeller("magic"))
end
