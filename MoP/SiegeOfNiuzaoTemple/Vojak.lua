--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Commander Vo'jak", 1011, 738)
if not mod then return end
mod:RegisterEnableMob(61634, 61620, 62795) -- Commander Vo'jak, Yang Ironclaw, Sik'thik Warden
mod:SetEncounterID(1502) -- ENCOUNTER_START fires when you actually pull the boss himself, not on the waves
mod:SetRespawnTime(10)

--------------------------------------------------------------------------------
-- Locals
--

local lastWin = 0

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(true, "boss")
function mod:GetOptions()
	return {
		autotalk,
		120778, -- Caustic Tar
		{120789, "SAY"}, -- Dashing Strike
		{-6287, "CASTBAR"}, -- Thousand Blades
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "CausticTar", 120778)
	self:Log("SPELL_AURA_APPLIED_DOSE", "CausticTar", 120778)

	self:Log("SPELL_CAST_SUCCESS", "DashingStrike", 120789)

	self:Log("SPELL_AURA_APPLIED", "ThousandBlades", 120759)
	self:Log("SPELL_DAMAGE", "ThousandBladesDamage", 120760)
	self:Log("SPELL_MISSED", "ThousandBladesDamage", 120760)

	self:RegisterEvent("GOSSIP_SHOW")
end

function mod:OnEngage()
	self:CDBar(120789, 8.6) -- Dashing Strike
end

function mod:OnWin()
	lastWin = GetTime()
end

function mod:VerifyEnable(_, mobId)
	if mobId ~= 61620 then return true end -- Yang Ironclaw is a friendly NPC that starts the encounter and then opens the gate downstairs
	return GetTime() - lastWin > 150
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CausticTar(args)
	local amount = args.amount or 1
	if self:Me(args.destGUID) and amount % 3 == 1 then -- 1, 4, 7
		self:StackMessage(args.spellId, "blue", args.destName, amount, 4)
		if amount >= 4 then
			self:PlaySound(args.spellId, "warning")
		end
	end
end

do
	local bossGUID
	local function printTarget(self, player, guid)
		local bossToken = self:UnitTokenFromGUID(bossGUID)
		local targetToken = self:UnitTokenFromGUID(guid)
		if bossToken and targetToken and not self:Tanking(bossToken, targetToken) then
			self:TargetMessage(120789, "yellow", player)
			self:PlaySound(120789, "alarm", nil, player)
			if self:Me(guid) then
				self:Say(120789, nil, nil, "Dashing Strike")
			end
		else -- either incorrect (cast time depends on distance between the boss and the target) or only one player is alive
			self:Message(120789, "yellow")
		end
	end

	function mod:DashingStrike(args)
		bossGUID = args.sourceGUID
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 14.6)
	end
end

function mod:ThousandBlades(args)
	self:Message(-6287, "red", CL.casting:format(args.spellName))
	self:PlaySound(-6287, "long")
	self:CastBar(-6287, 5)
end

do
	local prev = 0
	function mod:ThousandBladesDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(-6287, "near")
				self:PlaySound(-6287, "alert")
			end
		end
	end
end

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) and self:GetGossipID(34873) then
		-- 34873: We're ready to defend!
		self:SelectGossipID(34873)
	end
end
