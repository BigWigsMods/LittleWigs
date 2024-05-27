--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Helix Gearbreaker", 36, 90)
if not mod then return end
mod:RegisterEnableMob(47296, 47297) -- Helix Gearbreaker, Lumbering Oaf

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{88352, "ICON", "SAY", "FLASH"}, -- Chest Bomb
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_AURA_APPLIED", "ChestBomb", 88352)
	self:Log("SPELL_AURA_REMOVED", "ChestBombRemoved", 88352)

	self:Death("Win", 47296)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ChestBomb(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "alert")
	self:TargetBar(args.spellId, 10, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Chest Bomb")
		self:Flash(args.spellId)
	end
end

function mod:ChestBombRemoved(args)
	self:StopBar(args.spellName, args.destName)
	self:PrimaryIcon(args.spellId)
end
