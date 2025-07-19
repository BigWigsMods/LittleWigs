local isElevenDotTwo = BigWigsLoader.isNext -- XXX remove in 11.2
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Timecap'n Hooktail", 2441, 2449)
if not mod then return end
mod:RegisterEnableMob(175546) -- Timecap'n Hooktail
mod:SetEncounterID(2419)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local timeBombsCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

if isElevenDotTwo then -- XXX remove check in 11.2
	function mod:GetOptions()
		return {
			347149, -- Infinite Breath
			{352345, "ME_ONLY"}, -- Anchor Shot
			--347371, -- Grapeshot XXX no longer logs in 11.2
			358947, -- Burning Tar
			350517, -- Double Time
			{1240102, "DISPEL"}, -- Time Bombs
		}
	end
else -- XXX remove block in 11.2
	function mod:GetOptions()
		return {
			347149, -- Infinite Breath
			347151, -- Hook Swipe
			354334, -- Hook'd!
			{352345, "ME_ONLY"}, -- Anchor Shot
			347371, -- Grapeshot
			350517, -- Double Time
		}
	end
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "InfiniteBreathApplied", 350134)
	self:Log("SPELL_CAST_START", "InfiniteBreath", 347149)
	if isElevenDotTwo then -- XXX remove check in 11.2
		self:Log("SPELL_CAST_SUCCESS", "AnchorShot", 352345)
	else -- XXX remove block in 11.2
		self:Log("SPELL_AURA_APPLIED", "AnchorShot", 352345)
		self:Log("SPELL_CAST_START", "HookSwipe", 347151)
		self:Log("SPELL_AURA_APPLIED", "HookdApplied", 354334)
		self:Log("SPELL_CAST_SUCCESS", "Grapeshot", 347371) -- XXX no longer logs in 11.2
	end
	self:Log("SPELL_PERIODIC_DAMAGE", "BurningTarDamage", 358947)
	self:Log("SPELL_PERIODIC_MISSED", "BurningTarDamage", 358947)
	if isElevenDotTwo then -- XXX remove check in 11.2
		self:Log("SPELL_CAST_SUCCESS", "TimeBombs", 1240102)
		self:Log("SPELL_AURA_APPLIED", "TimeBombApplied", 1240097)
	else -- XXX remove block in 11.2
		self:Log("SPELL_CAST_START", "DoubleTime", 350517)
	end
end

function mod:OnEngage()
	if isElevenDotTwo then -- XXX remove check in 11.2
		timeBombsCount = 1
		self:CDBar(347149, 12.0) -- Infinite Breath
		self:CDBar(352345, 15.0) -- Anchor Shot
		self:CDBar(1240102, 22.0) -- Time Bombs
	else -- XXX remove block in 11.2
		self:CDBar(347151, 8.1) -- Hook Swipe
		self:CDBar(347149, 15) -- Infinite Breath
		self:CDBar(350517, 55) -- Double Time
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InfiniteBreathApplied(args)
	self:Message(347149, "purple", CL.incoming:format(args.spellName))
	self:CDBar(347149, 15.0)
	if self:Tank() then
		self:PlaySound(347149, "info")
	end
end

function mod:InfiniteBreath(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
end

function mod:AnchorShot(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:CDBar(args.spellId, 20.0)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end

function mod:HookSwipe(args) -- XXX remove in 11.2
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:HookdApplied(args) -- XXX remove in 11.2
	if self:Healer() or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

do
	local prev = 0
	function mod:Grapeshot(args) -- XXX no longer logs in 11.2
		if args.time - prev > 5 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:BurningTarDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

do
	local playerList = {}

	function mod:TimeBombs(args)
		playerList = {}
		timeBombsCount = timeBombsCount + 1
		if timeBombsCount == 2 then -- 2
			self:CDBar(args.spellId, 28.1)
		elseif timeBombsCount == 3 then -- 3
			self:CDBar(args.spellId, 22.0)
		elseif timeBombsCount % 3 == 1 then -- 4, 7, 10...
			self:CDBar(args.spellId, 25.0)
		elseif timeBombsCount % 3 == 2 then -- 5, 8, 11...
			self:CDBar(args.spellId, 15.0)
		else -- 6, 9, 12...
			self:CDBar(args.spellId, 20.0)
		end
	end

	function mod:TimeBombApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("magic", nil, 1240102) then
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(1240102, "orange", playerList, 2, args.spellName)
			if self:Dispeller("magic", nil, 1240102) then
				self:PlaySound(1240102, "info", nil, playerList)
			elseif self:Me(args.destGUID) then
				self:PlaySound(1240102, "info")
			end
		end
	end
end

function mod:DoubleTime(args) -- XXX remove in 11.2
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 55)
end
