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
		{460403, "EMPHASIZE", "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Kerosene Kick
		{460408, "SAY"}, -- Chaos Chopper
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "KeroseneKick", 460403)
	self:Log("SPELL_CAST_START", "ChaosChopper", 460408)
	self:Log("SPELL_CAST_SUCCESS", "PoolOfFire", 462273)
end

function mod:OnEngage()
	bossGUID = nil
	self:CDBar(460403, 11.3) -- Kerosene Kick
	self:CDBar(460408, 20.8) -- Chaos Chopper
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:KeroseneKick(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 30.4)
	self:CastBar(args.spellId, 3)
	self:PlaySound(args.spellId, "warning")
end

function mod:ChaosChopper(args)
	bossGUID = args.sourceGUID
	self:Message(args.spellId, "red", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 23.9)
	self:PlaySound(args.spellId, "alert")
end

function mod:PoolOfFire() -- Cast every second
	local bossUnit = bossGUID and self:GetUnitIdByGUID(bossGUID)
	if bossUnit then
		for unit in self:IterateGroup() do
			-- Unit is a threat target of something that isn't the boss
			if self:ThreatTarget(unit) and not self:ThreatTarget(unit, bossUnit) then
				bossGUID = nil
				local unitName = self:UnitName(unit)
				self:TargetMessage(460408, "yellow", unitName)
				if self:Me(self:UnitGUID(unit)) then
					self:Say(460408, nil, nil, "Chaos Chopper")
					self:PlaySound(460408, "alarm", nil, unitName)
				end
				return
			end
		end
	end
end
