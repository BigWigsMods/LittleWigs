--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ahn'kahet Trash", 619)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	30278, -- Ahn'kahar Spell Flinger
	30285, -- Eye of Taldaram
	30319 -- Twilight Darkcaster
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.spellflinger = "Ahn'kahar Spell Flinger"
	L.eye = "Eye of Taldaram"
	L.darkcaster = "Twilight Darkcaster"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Ahn'kahar Spell Flinger ]]--
		59102, -- Shadow Blast

		--[[ Eye of Taldaram ]]--
		56728, -- Eyes in the Dark

		--[[ Twilight Darkcaster ]]--
		13338, -- Curse of Tongues
	}, {
		[59102] = L.spellflinger,
		[56728] = L.eye,
		[13338] = L.darkcaster,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_CAST_START", "ShadowBlast", 59102) -- does inadequate amount of damage since The Great Squish
	self:Log("SPELL_AURA_APPLIED", "EyesInTheDark", 56728) -- 10s long debuff that can interrupt you randomly
	self:Log("SPELL_AURA_APPLIED", "CurseOfTongues", 13338)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:ShadowBlast(args)
		local t = GetTime()
		if t-prev > 1 then
			prev = t
			self:MessageOld(args.spellId, "red", self:Interrupter() and "warning" or "long", CL.casting:format(args.spellName))
		end
	end
end

function mod:EyesInTheDark(args)
	if self:Dispeller("magic") or self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "red", "alert", nil, nil, true)
	end
end

function mod:CurseOfTongues(args)
	if self:Dispeller("curse") or self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "yellow", "alarm", nil, nil, true)
	end
end
