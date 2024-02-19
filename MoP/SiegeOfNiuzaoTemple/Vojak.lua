
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Commander Vo'jak", 1011, 738)
if not mod then return end
mod:RegisterEnableMob(61634, 61620, 62795) -- Commander Vo'jak, Yang Ironclaw, Sik'thik Warden
mod.engageId = 1502 -- ENCOUNTER_START fires when you actually pull the boss himself, not on the waves
mod.respawnTime = 10

--------------------------------------------------------------------------------
-- Locals
--

local lastWin = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects the gossip option to start the fight."
	L.custom_on_autotalk_icon = "ui_chat"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_autotalk",
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
		self:StackMessageOld(args.spellId, args.destName, amount, "blue", amount > 1 and "warning")
	end
end

do
	local function printTarget(self, player, guid)
		if not self:Tanking("boss1", player) then
			self:TargetMessageOld(120789, player, "yellow", "alarm")
			if self:Me(guid) then
				self:Say(120789, nil, nil, "Dashing Strike")
			end
		else -- either incorrect (cast time depends on distance between the boss and the target) or only one player is alive
			self:MessageOld(120789, "yellow")
		end
	end
	function mod:DashingStrike(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 14.6)
	end
end

function mod:ThousandBlades(args)
	self:MessageOld(-6287, "red", "long", CL.casting:format(args.spellName))
	self:CastBar(-6287, 5)
end

do
	local prev = 0
	function mod:ThousandBladesDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:MessageOld(-6287, "blue", "alert", CL.you:format(args.spellName))
			end
		end
	end
end

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") and self:MobId(self:UnitGUID("npc")) == 61620 then
		if self:GetGossipOptions() then
			self:SelectGossipOption(1)
		end
	end
end
