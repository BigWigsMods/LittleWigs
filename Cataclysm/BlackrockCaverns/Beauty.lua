-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Beauty", 645, 108)
if not mod then return end
mod:RegisterEnableMob(39700)
mod.engageId = 1037
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{76031, "SAY", "SAY_COUNTDOWN", "ICON", "PROXIMITY"}, -- Magma Spit
		76028, -- Terrifying Roar
		76628, -- Lava Drool
	}, {
		[76031] = "general",
		[76628] = -2382, -- Lucky, Spot and Buster
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "MagmaSpit", 76031)
	self:Log("SPELL_AURA_REMOVED", "MagmaSpitRemoved", 76031)

	self:Log("SPELL_CAST_SUCCESS", "TerrifyingRoar", 76028)
	self:Log("SPELL_AURA_APPLIED", "TerrifyingRoarApplied", 76028)

	self:Log("SPELL_AURA_APPLIED", "LavaDrool", 76628) -- this might be bugged, does not fire any _DAMAGE events but it's supposed to do damage
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:MagmaSpit(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, 9)
		self:OpenProximity(args.spellId, 5)
	else
		self:OpenProximity(args.spellId, 5, args.destName)
	end
	self:TargetMessageOld(args.spellId, args.destName, "orange")
	self:TargetBar(args.spellId, 9, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:MagmaSpitRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
	self:CloseProximity(args.spellId)
	self:StopBar(args.spellName, args.destName)
	self:PrimaryIcon(args.spellId)
end

function mod:TerrifyingRoar(args)
	self:CDBar(args.spellId, 30)
end

do
	local playerList = mod:NewTargetList()
	function mod:TerrifyingRoarApplied(args)
		playerList[#playerList+1] = args.destName
		if #playerList == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.3, args.spellId, playerList, "yellow")
		end
	end
end

do
	local prev = 0
	function mod:LavaDrool(args)
		if not self:Me(args.destGUID) then return end
		local t = GetTime()
		if t - prev > 1.5 then
			prev = t
			self:MessageOld(args.spellId, "blue", "alert", CL.underyou:format(args.spellName))
		end
	end
end
