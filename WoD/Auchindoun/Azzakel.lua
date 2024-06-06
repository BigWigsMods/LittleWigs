--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Azzakel", 1182, 1216)
if not mod then return end
mod:RegisterEnableMob(75927)
mod:SetEncounterID(1678)
mod:SetRespawnTime(33)

--------------------------------------------------------------------------------
-- Locals
--

local curtainPlayers = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		153764, -- Claws of Argus
		{153392, "FLASH", "ICON"}, -- Curtain of Flame
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ClawsOfArgus", 153764)
	self:Log("SPELL_AURA_APPLIED", "CurtainOfFlame", 153392)
	self:Log("SPELL_AURA_REMOVED", "CurtainOfFlameRemoved", 153392)
end

function mod:OnEngage()
	curtainPlayers = {}
	self:CDBar(153764, 32) -- Claws of Argus
	self:CDBar(153392, 15) -- Curtain of Flame
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ClawsOfArgus(args)
	self:MessageOld(args.spellId, "yellow")
	self:Bar(args.spellId, 91)
	self:Bar(args.spellId, 20, CL.cast:format(args.spellName))
end

function mod:CurtainOfFlame(args)
	curtainPlayers[args.destName] = true
	self:TargetMessageOld(args.spellId, args.destName, "red", "warning")
	self:TargetBar(args.spellId, self:Normal() and 9 or 12, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
end

function mod:CurtainOfFlameRemoved(args)
	curtainPlayers[args.destName] = nil
	-- It can spread, so only remove after it has wore off from the last person it affected.
	if not next(curtainPlayers) then
		self:PrimaryIcon(args.spellId)
	end
end
