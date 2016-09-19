
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Black Rook Hold Trash", 1081)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	98280, -- Risen Arcanist
	98243, -- Soul-torn Champion
	98706  -- Commander Shemdah'sohn
)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		200248, -- Arcane Blitz (Risen Arcanist)
		200261, -- Bonebreaking Strike (Soul-torn Champion)
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_CAST_START", "ArcaneBlitz", 200248)
	self:Log("SPELL_CAST_START", "BonebreakingStrike", 200261)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ArcaneBlitz(args)
	-- only show a message if stacks are getting high (6 = 300% which is around 1m damage a hit)
	local unit = self:GetUnitIdByGUID(args.sourceGUID)
	if unit then
		local _, _, _, amount = UnitBuff(unit, args.spellName)
		if amount and amount > 5 and (self:Interrupter(args.destGUID) or self:Dispeller("magic", true)) then
			self:Message(args.spellId, "Attention", "Alert", CL.count:format(args.spellName, amount))
		end
	end
end

function mod:BonebreakingStrike(args)
	self:Message(args.spellId, "Important", "Alarm", CL.incoming:format(args.spellName))
end
