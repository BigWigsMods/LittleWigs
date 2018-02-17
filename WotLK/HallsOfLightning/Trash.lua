--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Halls of Lightning Trash", 525)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	28836, -- Stormforged Runeshaper
	28837 -- Stormforged Sentinel
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.runeshaper = "Stormforged Runeshaper"
	L.sentinel = "Stormforged Sentinel"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Stormforged Runeshaper ]]--
		61581, -- Charged Flurry

		--[[ Stormforged Sentinel ]]--
		53045, -- Sleep
	}, {
		[61581] = L.runeshaper,
		[53045] = L.sentinel,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_AURA_APPLIED", "ChargedFlurry", 61581) -- does inadequate amount of damage since The Great Squish
	self:Log("SPELL_AURA_APPLIED", "Sleep", 53045)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:ChargedFlurry(args)
		local t = GetTime()
		if t-prev > 1 then
			prev = t
			self:Message(args.spellId, "Important", self:Interrupter() and "Warning" or "Long", CL.casting:format(args.spellName))
		end
	end
end

function mod:Sleep(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alarm")
end
