
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Vanessa VanCleef", 36, 95)
if not mod then return end
mod:RegisterEnableMob(49541)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		92614, -- Deflection
		95542, -- Vengeance of VanCleef
		--{90961, "FLASH", "SAY", "ICON"},
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_AURA_APPLIED", "Deflection", 92614)
	self:Log("SPELL_CAST_SUCCESS", "VengeanceOfVanCleef", 95542)
	--self:Log("SPELL_AURA_APPLIED", "Blades", 90961) -- actually used by Defias Shadowguards
	--self:Log("SPELL_AURA_REMOVED", "BladesRemoved", 90961)

	self:Death("Win", 49541)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Deflection(args)
	self:MessageOld(args.spellId, "orange")
	self:Bar(args.spellId, 10)
end

function mod:VengeanceOfVanCleef(args)
	self:MessageOld(args.spellId, "yellow", "long")
end

--function mod:Blades(player, spellId, _, _, spellName)
--	if UnitIsUnit(player, "player") then
--		self:LocalMessage(90961, BCL["you"]:format(spellName), "blue", spellId, "alarm")
--		self:Say(90961, BCL["say"]:format(spellName))
--		self:FlashShake(90961)
--	end
--	self:PrimaryIcon(90961, player)
--end
--
--function mod:BladesRemoved()
--	self:PrimaryIcon(90961)
--end

