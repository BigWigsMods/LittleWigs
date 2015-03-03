
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Azzakel", 984, 1216)
if not mod then return end
mod:RegisterEnableMob(75927)

--------------------------------------------------------------------------------
-- Locals
--

local curtainPlayers = {}
local curtainOnMe = nil

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		153764, -- Claws of Argus
		{153392, "FLASH", "ICON", "PROXIMITY"}, -- Curtain of Flame
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "ClawsOfArgus", 153764)
	self:Log("SPELL_AURA_APPLIED", "CurtainOfFlame", 153392)
	self:Log("SPELL_AURA_REMOVED", "CurtainOfFlameRemoved", 153392)

	self:Death("Win", 75927)
end

function mod:OnEngage()
	self:CDBar(153764, 32) -- Claws of Argus
	self:CDBar(153392, 15) -- Curtain of Flame
	curtainOnMe = nil
	wipe(curtainPlayers)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ClawsOfArgus(args)
	self:Message(args.spellId, "Attention")
	self:Bar(args.spellId, 91)
	self:Bar(args.spellId, 20, CL.cast:format(args.spellName))
end


function mod:CurtainOfFlame(args)
	curtainPlayers[args.destName] = true
	self:TargetMessage(args.spellId, args.destName, "Important", "Warning")
	self:TargetBar(args.spellId, self:Normal() and 9 or 12, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
		self:OpenProximity(args.spellId, 5)
		curtainOnMe = true
	elseif not curtainOnMe then
		self:OpenProximity(args.spellId, 5, curtainPlayers)
	end
end

function mod:CurtainOfFlameRemoved(args)
	curtainPlayers[args.destName] = nil
	if self:Me(args.destGUID) then
		curtainOnMe = nil
		if next(curtainPlayers) then
			self:OpenProximity(args.spellId, 5, curtainPlayers)
			return
		end
	end
	-- It can spread, so only remove after it has wore off from the last person it affected.
	if not next(curtainPlayers) then
		self:PrimaryIcon(args.spellId)
		self:CloseProximity(args.spellId)
	end
end

