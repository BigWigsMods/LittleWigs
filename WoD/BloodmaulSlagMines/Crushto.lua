
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Slave Watcher Crushto", 1175, 888)
if not mod then return end
mod:RegisterEnableMob(74787)
mod.engageId = 1653
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local yellCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		150753, -- Wild Slam
		150759, -- Ferocious Yell
		153679, -- Earth Crush
		{150751, "FLASH", "ICON"}, -- Crushing Leap
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FerociousYell", 150759)
	self:Log("SPELL_CAST_START", "WildSlam", 150753)
	self:Log("SPELL_CAST_START", "EarthCrush", 153679)
	self:Log("SPELL_AURA_APPLIED", "CrushingLeap", 150751)
	self:Log("SPELL_AURA_REMOVED", "CrushingLeapOver", 150751)
end

function mod:OnEngage()
	yellCount = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FerociousYell(args)
	yellCount = yellCount + 1
	self:MessageOld(args.spellId, "orange", "warning", CL.count:format(args.spellName, yellCount))
	self:CDBar(args.spellId, 13.3) -- Something will randomly delay this up to 19s
end

function mod:WildSlam(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
end

function mod:EarthCrush(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

function mod:CrushingLeap(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "alert")
	self:TargetBar(args.spellId, 8, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
end

function mod:CrushingLeapOver(args)
	self:PrimaryIcon(args.spellId)
end
