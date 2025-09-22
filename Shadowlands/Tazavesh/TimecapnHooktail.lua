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

local infiniteBreathCount = 1
local timeBombsCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		347149, -- Infinite Breath
		{352345, "ME_ONLY"}, -- Anchor Shot
		358947, -- Burning Tar
		{1240102, "DISPEL"}, -- Time Bombs
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "InfiniteBreathApplied", 350134)
	self:Log("SPELL_CAST_START", "InfiniteBreath", 347149)
	self:Log("SPELL_CAST_SUCCESS", "AnchorShot", 352345)
	self:Log("SPELL_PERIODIC_DAMAGE", "BurningTarDamage", 358947)
	self:Log("SPELL_PERIODIC_MISSED", "BurningTarDamage", 358947)
	self:Log("SPELL_CAST_SUCCESS", "TimeBombs", 1240102)
	self:Log("SPELL_AURA_APPLIED", "TimeBombApplied", 1240097)
end

function mod:OnEngage()
	infiniteBreathCount = 1
	timeBombsCount = 1
	self:CDBar(347149, 12.0, CL.count:format(self:SpellName(347149), infiniteBreathCount)) -- Infinite Breath
	self:CDBar(352345, 15.0) -- Anchor Shot
	self:CDBar(1240102, 22.0, CL.count:format(self:SpellName(1240102), timeBombsCount)) -- Time Bombs
end

function mod:OnWin()
	local trashMod = BigWigs:GetBossModule("Tazavesh Trash", true)
	if trashMod then
		trashMod:Enable()
		trashMod:TimecapnHooktailDefeated()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InfiniteBreathApplied(args)
	self:StopBar(CL.count:format(args.spellName, infiniteBreathCount))
	self:Message(347149, "purple", CL.count:format(CL.incoming:format(args.spellName), infiniteBreathCount))
	infiniteBreathCount = infiniteBreathCount + 1
	self:CDBar(347149, 15.0, CL.count:format(args.spellName, infiniteBreathCount))
	if self:Tank() then
		self:PlaySound(347149, "info")
	end
end

function mod:InfiniteBreath(args)
	self:Message(args.spellId, "purple", CL.count:format(args.spellName, infiniteBreathCount - 1))
	self:PlaySound(args.spellId, "alarm")
end

function mod:AnchorShot(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:CDBar(args.spellId, 20.0)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning", nil, args.destName)
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
		self:StopBar(CL.count:format(args.spellName, timeBombsCount))
		playerList = {}
		timeBombsCount = timeBombsCount + 1
		if timeBombsCount == 2 then -- 2
			self:CDBar(args.spellId, 28.1, CL.count:format(args.spellName, timeBombsCount))
		elseif timeBombsCount == 3 then -- 3
			self:CDBar(args.spellId, 22.0, CL.count:format(args.spellName, timeBombsCount))
		elseif timeBombsCount % 3 == 1 then -- 4, 7, 10...
			self:CDBar(args.spellId, 25.0, CL.count:format(args.spellName, timeBombsCount))
		elseif timeBombsCount % 3 == 2 then -- 5, 8, 11...
			self:CDBar(args.spellId, 15.0, CL.count:format(args.spellName, timeBombsCount))
		else -- 6, 9, 12...
			self:CDBar(args.spellId, 20.0, CL.count:format(args.spellName, timeBombsCount))
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
