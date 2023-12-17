--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Smashspite", 1501, 1664)
if not mod then return end
mod:RegisterEnableMob(98949) -- Smashspite the Hateful
mod:SetEncounterID(1834)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local earthshakingStompCount = 1
local hatefulGazeCount = 1
local playersWithHatefulCharge = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		198073, -- Earthshaking Stomp
		{198079, "SAY", "EMPHASIZE"}, -- Hateful Gaze
		224188, -- Hateful Charge
		{198245, "TANK_HEALER"}, -- Brutal Haymaker
		{198446, "SAY", "ME_ONLY"}, -- Fel Vomit
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "EarthshakingStomp", 198073)
	self:Log("SPELL_CAST_SUCCESS", "HatefulGaze", 198079)
	self:Log("SPELL_AURA_APPLIED", "HatefulChargeApplied", 224188)
	self:Log("SPELL_AURA_APPLIED_DOSE", "HatefulChargeApplied", 224188)
	self:Log("SPELL_AURA_REMOVED", "HatefulChargeRemoved", 224188)
	self:Log("SPELL_CAST_START", "BrutalHaymaker", 198245)
	self:Log("SPELL_AURA_APPLIED", "FelVomit", 198446)
end

function mod:OnEngage()
	earthshakingStompCount = 1
	if not self:Normal() then -- Heroic+
		hatefulGazeCount = 1
		playersWithHatefulCharge = {}
		self:CDBar(198079, 5.1, CL.count:format(self:SpellName(198079), hatefulGazeCount)) -- Hateful Gaze
	end
	self:CDBar(198073, 12.1, CL.count:format(self:SpellName(198073), earthshakingStompCount)) -- Earthshaking Stomp
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EarthshakingStomp(args)
	self:StopBar(CL.count:format(args.spellName, earthshakingStompCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, earthshakingStompCount))
	self:PlaySound(args.spellId, "alert")
	earthshakingStompCount = earthshakingStompCount + 1
	self:CDBar(args.spellId, 25.5, CL.count:format(args.spellName, earthshakingStompCount))
end

function mod:HatefulGaze(args)
	self:StopBar(CL.count:format(args.spellName, hatefulGazeCount))
	local hatefulChargeStacks = playersWithHatefulCharge[args.destName] or 0
	-- include stack count of the targeted player in message:
	-- 0 stacks: 1x Hateful Gaze: destName (no emphasis, alarm sound)
	-- 1 stacks: 2x Hateful Gaze: destName (emphasize, warning sound)
	-- 2 stacks: 3x Hateful Gaze: destName (emphasize, warning sound)
	-- etc
	self:StackMessage(args.spellId, "orange", args.destName, hatefulChargeStacks + 1, 2)
	-- play warning sound if the targeted player already has the debuff
	if hatefulChargeStacks > 0 then
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	else
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Hateful Gaze")
	end
	hatefulGazeCount = hatefulGazeCount + 1
	self:CDBar(args.spellId, 25.5, CL.count:format(args.spellName, hatefulGazeCount))
end

function mod:HatefulChargeApplied(args)
	playersWithHatefulCharge[args.destName] = args.amount or 1
	if self:Me(args.destGUID) then
		self:TargetBar(args.spellId, 60, args.destName)
	end
end

function mod:HatefulChargeRemoved(args)
	playersWithHatefulCharge[args.destName] = nil
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info", nil, args.destName)
		self:StopBar(args.spellId, args.destName)
	end
end

function mod:BrutalHaymaker(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	-- cast at 100 energy, energy is gained based on damage done
end

function mod:FelVomit(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
		self:Say(args.spellId, nil, nil, "Fel Vomit")
	else
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end
