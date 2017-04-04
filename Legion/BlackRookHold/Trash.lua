
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Black Rook Hold Trash", 1081)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	98280, -- Risen Arcanist
	98243, -- Soul-torn Champion
	102094, -- Risen Swordsman
	98275, -- Risen Archer
	98691, -- Risen Scout
	98370 -- Ghostly Councilor
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.arcanist = "Risen Arcanist"
	L.champion = "Soul-torn Champion"
	L.swordsman = "Risen Swordsman"
	L.archer = "Risen Archer"
	L.scout = "Risen Scout"
	L.councilor = "Ghostly Councilor"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		200248, -- Arcane Blitz (Risen Arcanist)
		200261, -- Bonebreaking Strike (Soul-torn Champion)
		214003, -- Coup de Grace (Risen Swordsman)
		200343, -- Arrow Barrage (Risen Archer)
		200291, -- Knife Dance (Risen Scout)
		225573 -- Dark Mending (Ghostly Councilor)
	}, {
		[200248] = L.arcanist,
		[200261] = L.champion,
		[214003] = L.swordsman,
		[200343] = L.archer,
		[200291] = L.scout,
		[225573] = L.councilor
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_CAST_START", "ArcaneBlitz", 200248)
	self:Log("SPELL_CAST_START", "BonebreakingStrike", 200261)
	self:Log("SPELL_CAST_START", "CoupdeGrace", 214003)
	self:Log("SPELL_CAST_START", "ArrowBarrage", 200343)
	self:Log("SPELL_AURA_APPLIED", "KnifeDance", 200291)
	self:Log("SPELL_PERIODIC_DAMAGE", "KnifeDance", 200291)
	self:Log("SPELL_CAST_START", "DarkMending", 225573)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Risen Arcanist
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

-- Soul-torn Champion
function mod:BonebreakingStrike(args)
	self:Message(args.spellId, "Important", "Alarm", CL.incoming:format(args.spellName))
end

-- Risen Swordsman
function mod:CoupdeGrace(args)
	self:Message(args.spellId, "Important", "Alarm", CL.incoming:format(args.spellName))
end

-- Risen Archer
function mod:ArrowBarrage(args)
	self:Message(args.spellId, "Important", "Alarm", CL.incoming:format(args.spellName))
end

-- Risen Scout
function mod:KnifeDance(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
	end
end

-- Ghostly Councilor
function mod:DarkMending(args)
	self:Message(args.spellId, "Attention", self:Interrupter() and "Alarm", CL.casting:format(args.spellName))
end
