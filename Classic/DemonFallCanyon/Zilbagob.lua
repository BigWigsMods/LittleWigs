--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zilbagob", 2784)
if not mod then return end
mod:RegisterEnableMob(226922) -- Zilbagob
mod:SetEncounterID(3029)
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local bossGUID = nil
local loopCount = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.zilbagob = "Zilbagob"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.zilbagob
end

function mod:GetOptions()
	return {
		460403, -- Kerosene Kick
		{460408, "SAY"}, -- Chaos Chopper
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "KeroseneKick", 460403)
	self:Log("SPELL_CAST_START", "ChaosChopperStart", 460408)
	self:Log("SPELL_CAST_SUCCESS", "ChaosChopper", 460408)
end

function mod:OnEngage()
	bossGUID = nil
	loopCount = 0
	self:CDBar(460403, 11.3) -- Kerosene Kick
	self:CDBar(460408, 27.5) -- Chaos Chopper
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:KeroseneKick(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 30.4)
	self:PlaySound(args.spellId, "alarm")
end

function mod:ChaosChopperStart(args)
	self:Message(args.spellId, "red", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 23.9)
	self:PlaySound(args.spellId, "alert")
end

do
	local function LoopThreat()
		loopCount = loopCount + 1
		if not mod:IsEngaged() or loopCount > 14 then return end
		mod:SimpleTimer(LoopThreat, 1)

		local bossUnit = bossGUID and mod:GetUnitIdByGUID(bossGUID)
		if bossUnit then
			for unit in mod:IterateGroup() do
				-- Unit is a threat target of something that isn't the boss
				if mod:ThreatTarget(unit) and not mod:ThreatTarget(unit, bossUnit) then
					loopCount = 100
					local unitName = mod:UnitName(unit)
					mod:TargetMessage(460408, "red", mod:UnitName(unitName))
					if mod:Me(mod:UnitGUID(unit)) then
						mod:Say(460408, nil, nil, "Chaos Chopper")
						mod:PlaySound(460408, "warning", nil, unitName)
					end
				end
			end
		end
	end
	function mod:ChaosChopper(args)
		loopCount = 0
		bossGUID = args.sourceGUID
		self:SimpleTimer(LoopThreat, 1)
	end
end
