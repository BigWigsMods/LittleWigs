--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Time-Lost Battlefield", 2579, UnitFactionGroup("player") == "Horde" and 2534 or 2533)
if not mod then return end
mod:RegisterEnableMob(
	203679, -- Anduin Lothar
	203678  -- Grommash Hellscream
)
mod:SetEncounterID(2672)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{410235, "SAY"}, -- Bladestorm
		-- Anduin Lothar
		{418059, "TANK_HEALER"}, -- Mortal Strikes
		418054, -- Shockwave (Anduin's)
		418047, -- FOR THE ALLIANCE!
		418062, -- Battle Cry
		-- Grommash Hellscream
		{410254, "TANK_HEALER"}, -- Decapitate
		408227, -- Shockwave (Grommash's)
		418046, -- FOR THE HORDE!
		410496, -- War Cry
	}, {
		[418059] = -27260, -- Anduin Lothar
		[410254] = -26525, -- Grommash Hellscream
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Bladestorm", 410235)
	self:Log("SPELL_CAST_START", "MortalStrikes", 418059, 410254) -- Mortal Strikes / Decapitate
	self:Log("SPELL_CAST_SUCCESS", "Shockwave", 418054, 408227) -- Anduin, Grommash
	self:Log("SPELL_CAST_START", "ForTheAlliance", 418047, 418046) -- For the Alliance / For the Horde
	-- TODO this SPELL_CAST_SUCCESS no longer logs?
	self:Log("SPELL_CAST_SUCCESS", "BattleCry", 418062, 410496) -- Battle Cry / War Cry
	self:Log("SPELL_DAMAGE", "BattleCry", 418062, 410496) -- Battle Cry / War Cry
	-- TODO for Lothar he gains Battle Senses stacking buff if an "enemy" dies
	-- TODO for Grommash he gains Thirst for Battle stacking buff if an "enemy" dies
end

function mod:OnEngage()
	self:CDBar(410235, 21.8) -- Bladestorm
	if self:GetBossId(203679) then -- Anduin Lothar
		self:CDBar(418059, 2.4) -- Mortal Strikes
		self:CDBar(418054, 9.7) -- Shockwave (Anduin's)
		self:CDBar(418047, 19.3) -- FOR THE ALLIANCE!
		self:CDBar(418062, 30.4) -- Battle Cry
	elseif self:GetBossId(203678) then -- Grommash Hellscream
		self:CDBar(410254, 2.4) -- Decapitate
		self:CDBar(408227, 9.7) -- Shockwave (Grommash's)
		self:CDBar(418046, 19.3) -- FOR THE HORDE!
		self:CDBar(410496, 30.4) -- War Cry
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Bladestorm(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	self:CDBar(args.spellId, 35.2)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

function mod:MortalStrikes(args) -- or Decapitate
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 19.5)
end

function mod:Shockwave(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 35.2)
end

function mod:ForTheAlliance(args) -- or ForTheHorde
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 21.3)
end

do
	local prev = 0
	function mod:BattleCry(args) -- or WarCry
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
			self:CDBar(args.spellId, 28.0)
		end
	end
end
