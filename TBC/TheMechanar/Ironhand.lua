--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gatewatcher Iron-Hand", 554)
if not mod then return end
mod:RegisterEnableMob(19710)
-- mod.engageId = 1934 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.bossName = "Gatewatcher Iron-Hand"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		39193, -- Shadow Power
		35311, -- Stream of Machine Fluid
		{39194, "CASTBAR"}, -- Jackhammer
	}
end

function mod:OnRegister()
	self.displayName = L.bossName -- no journal entry
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:Log("SPELL_CAST_START", "ShadowPower", 39193, 35322) -- normal, heroic
	self:Log("SPELL_AURA_APPLIED", "ShadowPowerApplied", 39193, 35322)
	self:Log("SPELL_AURA_REMOVED", "ShadowPowerRemoved", 39193, 35322)

	self:Log("SPELL_AURA_APPLIED", "StreamOfMachineFluid", 35311)
	self:Log("SPELL_AURA_REMOVED", "StreamOfMachineFluidRemoved", 35311)

	self:Log("SPELL_DAMAGE", "JackhammersDamage", 39195)
	self:Log("SPELL_MISSED", "JackhammersDamage", 39195)

	self:Death("Win", 19710)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, _, source)
	if source == self.displayName then
		self:MessageOld(39194, "yellow", "long", CL.casting:format(self:SpellName(39194)))
		self:CastBar(39194, 10) -- 3s cast + ~7s channel
	end
end

function mod:ShadowPower(args)
	self:MessageOld(39193, "red", nil, CL.casting:format(args.spellName))
end

function mod:ShadowPowerApplied()
	self:Bar(39193, 15)
end

function mod:ShadowPowerRemoved()
	self:StopBar(39193)
end

do
	local playerList, playersAffected = mod:NewTargetList(), 0

	function mod:StreamOfMachineFluid(args)
		playersAffected = playersAffected + 1
		playerList[#playerList + 1] = args.destName
		if #playerList == 1 then
			self:Bar(args.spellId, 10)
			self:ScheduleTimer("TargetMessageOld", 0.3, args.spellId, playerList, "orange", "alarm", nil, nil, self:Dispeller("poison"))
		end
	end

	function mod:StreamOfMachineFluidRemoved(args)
		playersAffected = playersAffected - 1
		if playersAffected == 0 then
			self:StopBar(args.spellName)
		end
	end
end

do
	local prev = 0
	function mod:JackhammersDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > (self:Melee() and 6 or 1.5) then
				prev = t
				self:MessageOld(39194, "blue", "alert", CL.you:format(self:SpellName(39194))) -- args.spellName is "Jackhammer Effect"
			end
		end
	end
end
