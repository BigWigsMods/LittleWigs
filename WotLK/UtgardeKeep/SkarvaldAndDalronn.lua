-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Skarvald & Dalronn", 574, 639)
if not mod then return end
mod:RegisterEnableMob(24200, 24201) -- Skarvald the Constructor, Dalronn the Controller
mod.engageId = 2024
mod.respawnTime = 10

-------------------------------------------------------------------------------
--  Locals
--

local deaths = 0

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"stages",
		43650, -- Debilitate
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Debilitate", 43650)
	self:Death("Deaths", 24200, 24201)
end

function mod:OnEngage()
	deaths = 0
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Debilitate(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow")
	self:TargetBar(args.spellId, 8, args.destName)
end

function mod:Deaths(args)
	deaths = deaths + 1
	if deaths < 2 then
		self:MessageOld("stages", "green", "info", CL.mob_killed:format(args.destName, deaths, 2), false)
	end
end
