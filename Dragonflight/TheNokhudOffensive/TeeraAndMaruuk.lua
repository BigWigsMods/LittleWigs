--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Teera and Maruuk", 2516, 2478)
if not mod then return end
mod:RegisterEnableMob(
	186339, -- Teera
	186338  -- Maruuk
)
mod:SetEncounterID(2581)
mod:SetRespawnTime(40.5) -- 30s respawn + 10.5s RP run

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "achievement_dungeon_centaurplains"
end

--------------------------------------------------------------------------------
-- Locals
--

local galeArrowCount = 1
local spiritLeapCount = 1
local frightfulRoarCount = 1
local brutalizeCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"warmup",
		-- Teera
		382670, -- Gale Arrow
		386547, -- Repel
		384808, -- Guardian Wind
		385434, -- Spirit Leap
		-- Maruuk
		385339, -- Earthsplitter
		386063, -- Frightful Roar
		{382836, "TANK_HEALER"}, -- Brutalize
		-- Mythic
		392198, -- Ancestral Bond
		395669, -- Aftershock
	}, {
		["warmup"] = CL.general,
		[382670] = -25552, -- Teera
		[385339] = -25546, -- Maruuk
		[392198] = "mythic",
	}
end

function mod:OnBossEnable()
	-- Teera
	self:Log("SPELL_CAST_START", "GaleArrow", 382670)
	self:Log("SPELL_AURA_APPLIED", "GaleArrowApplied", 392151)
	self:Log("SPELL_CAST_START", "Repel", 386547)
	self:Log("SPELL_AURA_APPLIED", "GuardianWind", 384808)
	self:Log("SPELL_CAST_START", "SpiritLeap", 385434)

	-- Maruuk
	self:Log("SPELL_CAST_START", "Earthsplitter", 385339)
	self:Log("SPELL_CAST_START", "FrightfulRoar", 386063)
	self:Log("SPELL_CAST_START", "Brutalize", 382836)

	-- Mythic
	self:Log("SPELL_AURA_APPLIED_DOSE", "AncestralBondApplied", 392198)
	self:Log("SPELL_AURA_REMOVED", "AncestralBondRemoved", 392198)
	self:Log("SPELL_AURA_APPLIED", "AftershockDamage", 395669)
	self:Log("SPELL_PERIODIC_DAMAGE", "AftershockDamage", 395669)
	self:Log("SPELL_PERIODIC_MISSED", "AftershockDamage", 395669)
end

function mod:OnEngage()
	galeArrowCount = 1
	spiritLeapCount = 1
	frightfulRoarCount = 1
	brutalizeCount = 1
	self:StopBar(CL.active)
	self:CDBar(386063, 5.5) -- Frightful Roar
	self:CDBar(385434, 6.0) -- Spirit Leap
	self:CDBar(382836, 13.5) -- Brutalize
	self:CDBar(382670, 21.5, CL.count:format(self:SpellName(382670), galeArrowCount)) -- Gale Arrow
	self:CDBar(386547, 50.0) -- Repel
	self:CDBar(385339, 52.0) -- Earthsplitter
end

function mod:VerifyEnable(unit)
	-- bosses become unattackable at 1 HP remaining
	return UnitCanAttack("player", unit) or self:GetHealth(unit) > 1
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- General

function mod:Warmup() -- called from trash module
	self:Bar("warmup", 26.2, CL.active, L.warmup_icon)
end

-- Teera

do
	local playerList = {}

	function mod:GaleArrow(args)
		playerList = {}
		self:StopBar(CL.count:format(args.spellName, galeArrowCount))
		galeArrowCount = galeArrowCount + 1
		self:CDBar(args.spellId, 57.5, CL.count:format(args.spellName, galeArrowCount))
	end

	function mod:GaleArrowApplied(args)
		playerList[#playerList + 1] = args.destName
		local targetCount = self:Normal() and 1 or 4
		self:TargetsMessage(382670, "red", playerList, targetCount, CL.count:format(args.spellName, galeArrowCount - 1))
		self:PlaySound(382670, "alarm", nil, playerList)
	end
end

function mod:Repel(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 57.5)
end

function mod:GuardianWind(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:CDBar(args.spellId, 57.5) basically part 2 of repel, no point in a timer
end

function mod:SpiritLeap(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	-- pull:6.0, 24.0, 13.5, 20, 24.0, 13.5, 20
	spiritLeapCount = spiritLeapCount + 1
	if spiritLeapCount % 3 == 2 then
		self:CDBar(args.spellId, 24)
	elseif spiritLeapCount % 3 == 0 then
		self:CDBar(args.spellId, 13.5)
	else
		self:CDBar(args.spellId, 20)
	end
end

-- Maruuk

function mod:Earthsplitter(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 57.5)
end

function mod:FrightfulRoar(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	-- pull:9.5, 38.5, 19.0, 38.5, 19.0
	frightfulRoarCount = frightfulRoarCount + 1
	if frightfulRoarCount % 2 == 0 then
		self:CDBar(args.spellId, 38.5)
	else
		self:CDBar(args.spellId, 19)
	end
end

function mod:Brutalize(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	-- pull:13.5, 7.5, 16.0, 34.0, 7.5, 16.0, 34.0
	brutalizeCount = brutalizeCount + 1
	if brutalizeCount % 3 == 2 then
		self:CDBar(args.spellId, 7.5)
	elseif brutalizeCount % 3 == 0 then
		self:CDBar(args.spellId, 16)
	else
		self:CDBar(args.spellId, 34)
	end
end

-- Mythic

do
	local stacks = 0

	function mod:AncestralBondApplied(args)
		-- bosses get stacking enrage if more than 20 yards apart
		if args.amount % 4 == 0 and self:MobId(args.destGUID) == 186338 then -- alert every 4th stack on Maruuk
			stacks = args.amount
			self:Message(args.spellId, "red", CL.onboss:format(args.spellName))
			if self:Tank() then
				self:PlaySound(args.spellId, "warning")
			else
				self:PlaySound(args.spellId, "alert")
			end
		end
	end

	function mod:AncestralBondRemoved(args)
		-- only alert removal if we sent an alert for applied
		if stacks > 0 and self:MobId(args.destGUID) == 186338 then -- Maruuk
			stacks = 0
			self:Message(args.spellId, "green", CL.removed:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

do
	local prev = 0
	function mod:AftershockDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PlaySound(args.spellId, "underyou")
				self:PersonalMessage(args.spellId, "underyou")
			end
		end
	end
end
