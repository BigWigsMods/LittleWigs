
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Master Snowdrift", 959, 657)
if not mod then return end
mod:RegisterEnableMob(56541)
mod.engageId = 1304
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local stage = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	-- When I was but a cub I could scarcely throw a punch, but after years of training I can do so much more!
	L.stage3_yell = "was but a cub"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		106434, -- Tornado Kick
		118961, -- Chase Down
		106747, -- Shado-pan Mirror Image
		"stages"
	}
end

function mod:VerifyEnable(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp > 15 then
		return true
	end
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "TornadoKick", 106434)
	self:Log("SPELL_AURA_APPLIED", "ChaseDown", 118961)
	self:Log("SPELL_AURA_REMOVED", "ChaseDownRemoved", 118961)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Stage3")
end

function mod:OnEngage()
	stage = 1
	self:RegisterUnitEvent("UNIT_HEALTH", "StageWarn", "boss1")
	self:CDBar(106434, 15) -- Tornado Kick
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TornadoKick(args)
	self:MessageOld(args.spellId, "orange", "alert")
	self:CastBar(args.spellId, 6.5) -- 5s channel + 1.5s cast
end

function mod:ChaseDown(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "alarm")
	self:TargetBar(args.spellId, 11, args.destName)
end

function mod:ChaseDownRemoved(args)
	self:StopBar(args.spellName, args.destName)
end


function mod:Stage3(_, msg)
	if msg:find(L.stage3_yell, nil, true) then
		self:MessageOld("stages", "green", "info", CL.stage:format(3), 118961) -- 118961 = Chase Down
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 110324 then -- Shado-pan Vanish
		if stage == 1 then
			stage = 2
			local mirror = mod:SpellName(106747) -- Shado-pan Mirror Image
			self:MessageOld("stages", "green", "info", (CL.stage:format(2))..": "..mirror, 106747)
			self:RegisterUnitEvent("UNIT_HEALTH", "StageWarn", "boss1")
		else
			self:MessageOld(106747, "green")
		end
	end
end

function mod:StageWarn(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 65 and stage == 1 then
		self:UnregisterUnitEvent(event, unit)
		self:MessageOld("stages", "green", nil, CL.soon:format(CL.stage:format(2)), false)
	elseif hp < 35 and stage == 2 then
		self:UnregisterUnitEvent(event, unit)
		self:MessageOld("stages", "green", nil, CL.soon:format(CL.stage:format(3)), false)
	end
end
