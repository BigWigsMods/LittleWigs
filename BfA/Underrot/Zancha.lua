
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sporecaller Zancha", 1841, 2130)
if not mod then return end
mod:RegisterEnableMob(131383)
mod.engageId = 2112
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		259732, -- Festering Harvest
		259830, -- Boundless Rot
		272457, -- Shockwave
		{259718, "SAY", "SAY_COUNTDOWN", "FLASH"}, -- Upheaval
		273285, -- Volatile Pods
	}, {
		[259732] = "general",
		[273285] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FesteringHarvest", 259732)
	self:Log("SPELL_CAST_SUCCESS", "BoundlessRot", 259830)
	self:Log("SPELL_CAST_START", "Shockwave", 272457)
	self:Log("SPELL_AURA_APPLIED", "Upheaval", 259718)
	self:Log("SPELL_AURA_REMOVED", "UpheavalRemoved", 259718)

	-- Heroic+
	self:Log("SPELL_CAST_SUCCESS", "VolatilePods", 273285)
end

function mod:OnEngage()
	self:Bar(272457, 10.5) -- Shockwave
	self:ScheduleTimer("Bar", 10.5, 272457, 14) -- Second Shockwave, 24.5 sec total
	self:Bar(259718, 16) -- Upheaval
	self:Bar(259732, 45) -- Festering Harvest
	if not self:Normal() then
		self:Bar(273285, 46) -- Volatile Pods
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FesteringHarvest(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 51)
	self:Bar(259718, 15) -- Upheaval
	self:Bar(272457, 24.3) -- Shockwave
	self:ScheduleTimer("Bar", 24.3, 272457, 20.6) -- Second Shockwave, 44.9 sec total
end

function mod:BoundlessRot(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info", "watchstep")
end

function mod:Shockwave(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
end

do
	local playerList = mod:NewTargetList()
	function mod:Upheaval(args)
		playerList[#playerList+1] = args.destName
		if #playerList == 1 then
			self:Bar(args.spellId, 20)
		end
		if self:Me(args.destGUID) then
			self:PlaySound(args.spellId, "warning", "runout")
			self:Say(args.spellId)
			self:Flash(args.spellId)
			self:SayCountdown(args.spellId, 6)
		end
		self:TargetsMessage(args.spellId, "orange", playerList, 2)
	end
end

function mod:UpheavalRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

do
	local prev = 0
	function mod:VolatilePods(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "long")
			self:CDBar(args.spellId, 25)
		end
	end
end
