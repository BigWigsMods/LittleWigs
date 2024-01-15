
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Serpentrix", 1456, 1479)
if not mod then return end
mod:RegisterEnableMob(91808)
mod.engageId = 1813

--------------------------------------------------------------------------------
-- Locals
--

local submergeHp = 66

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		191873, -- Submerge
		{191855, "SAY", "ICON"}, -- Toxic Wound
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")

	self:Log("SPELL_AURA_APPLIED", "ToxicWound", 191855)
	self:Log("SPELL_AURA_REMOVED", "ToxicWoundOver", 191855)
end

function mod:OnEngage()
	submergeHp = 66
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("191873", nil, true) then
		self:MessageOld(191873, "yellow", "long", CL.percent:format(submergeHp, self:SpellName(191873)))
		submergeHp = submergeHp - 33
	end
end

function mod:ToxicWound(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "alarm")
	--self:CDBar(args.spellId, 25) -- pull:27.8, 25.5, 29.2 -- pull:5.9, 25.1, 41.0
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Toxic Wound")
	end
end

function mod:ToxicWoundOver(args)
	self:PrimaryIcon(args.spellId)
end

