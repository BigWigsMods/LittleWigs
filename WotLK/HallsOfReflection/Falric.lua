-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Falric", 668, 601)
if not mod then return end
mod:RegisterEnableMob(38112)
mod.engageId = 1992
mod.respawnTime = 30 -- you have to actually walk towards the altar, nothing will respawn on its own

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		{72426, "ICON"}, -- Impending Despair
		{72422, "ICON"}, -- Quivering Strike
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "DebuffApplied", 72422, 72426) -- Quivering Strike, Impending Despair
	self:Log("SPELL_AURA_REMOVED", "DebuffRemoved", 72422, 72426)
end

function mod:OnWin()
	-- There's a 60s break before the 6th wave spawns
	-- Let's show a timer for it if the user didn't disable "warmup" in Marwyn's settings
	local marwynMod = BigWigs:GetBossModule("Marwyn", true)
	if marwynMod then
		marwynMod:Enable()
		marwynMod:Bar("warmup", 60, CL.adds, "achievement_dungeon_icecrown_hallsofreflection")
	end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:DebuffApplied(args)
	local time = 5
	if args.spellId == 72422 then -- Quivering Strike
		self:PrimaryIcon(args.spellId, args.destName)
	elseif args.spellId == 72426 then -- Impending Despair
		time = 6
		self:SecondaryIcon(args.spellId, args.destName)
	end
	self:TargetMessage(args.spellId, args.destName, "Urgent")
	self:TargetBar(args.spellId, time, args.destName)
end

function mod:DebuffRemoved(args)
	self:StopBar(args.spellId, args.destName)
	self:PrimaryIcon(args.spellId)
	self:SecondaryIcon(args.spellId)
end
