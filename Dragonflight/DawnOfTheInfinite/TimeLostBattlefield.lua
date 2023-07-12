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
		410234, -- Bladestorm
		{418059, "TANK_HEALER"}, -- Mortal Strikes
		418054, -- Shockwave
		418047, -- FOR THE ALLIANCE!
		418062, -- Battle Cry
	}, nil, {
		[418059] = self:SpellName(410254), -- Mortal Strikes / Decapitate
		[418054] = self:SpellName(408227), -- Shockwave / Shockwave
		[418047] = self:SpellName(418046), -- FOR THE ALLIANCE! / FOR THE HORDE!
		[418062] = self:SpellName(410496), -- Battle Cry / War Cry
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Bladestorm", 410234)
	self:Log("SPELL_CAST_START", "MortalStrikes", 418059, 410254) -- Anduin, Grommash
	self:Log("SPELL_CAST_SUCCESS", "Shockwave", 418054, 408227) -- Anduin, Grommash
	self:Log("SPELL_CAST_START", "ForTheAlliance", 418047, 418046) -- Anduin, Grommash
	-- TODO this no longer logs?
	self:Log("SPELL_CAST_SUCCESS", "BattleCry", 418062, 410496) -- Anduin, Grommash
	-- TODO for Grommash he (supposedly) gains Thirst for Battle stacking buff if an "enemy" dies
	-- TODO for Lothar he (supposedly) gains Battle Senses stacking buff if an "enemy" dies
end

function mod:OnEngage()
	-- timers started in IEEU
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	self:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- TODO is there a better way?
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	local mobId = self:MobId(self:UnitGUID("boss1"))
	if mobId == 203679 then -- Anduin Lothar
		self:UnregisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
		self:CDBar(418059, 2.4) -- Mortal Strikes
		self:CDBar(418054, 9.7) -- Shockwave
		self:CDBar(418047, 19.3) -- FOR THE ALLIANCE!
		self:CDBar(410234, 21.8) -- Bladestorm
		self:CDBar(418062, 30.4) -- Battle Cry
	elseif mobId == 203678 then -- Grommash Hellscream
		self:UnregisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
		self:CDBar(418059, 2.4, 410254, 410254) -- Decapitate
		self:CDBar(418054, 9.7, 408227, 408227) -- Shockwave
		self:CDBar(418047, 19.3, 418046, 418046) -- FOR THE HORDE!
		self:CDBar(410234, 21.8) -- Bladestorm
		self:CDBar(418062, 30.4, 410496, 410496) -- War Cry
	end
end

function mod:Bladestorm(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 35.2)
end

function mod:MortalStrikes(args) -- or Decapitate
	self:Message(418059, "purple", args.spellId, args.spellId)
	self:PlaySound(418059, "alert")
	self:CDBar(418059, 20.1, args.spellId, args.spellId)
end

function mod:Shockwave(args) -- or Shockwave
	self:Message(418054, "orange", args.spellId, args.spellId)
	self:PlaySound(418054, "alarm")
	self:CDBar(418054, 35.2, args.spellId, args.spellId)
end

function mod:ForTheAlliance(args) -- or ForTheHorde
	self:Message(418047, "cyan", args.spellId, args.spellId)
	self:PlaySound(418047, "info")
	self:CDBar(418047, 21.3, args.spellId, args.spellId)
end

function mod:BattleCry(args) -- or WarCry
	self:Message(418062, "yellow", args.spellId, args.spellId)
	self:PlaySound(418062, "alert")
	self:CDBar(418062, 28.0, args.spellId, args.spellId)
end
