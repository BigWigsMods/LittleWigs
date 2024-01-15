
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Warlord Parjesh", 1456, 1480)
if not mod then return end
mod:RegisterEnableMob(91784)
mod.engageId = 1810

--------------------------------------------------------------------------------
-- Locals
--

local addCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{192094, "ICON", "SAY", "FLASH"}, -- Impaling Spear
		192131, -- Throw Spear
		197064, -- Enrage
		197502, -- Restoration
		191900, -- Crashing Wave
		192053, -- Quicksand
		192072, -- Call Reinforcements
		196563, -- Call Reinforcements
	}, {
		[192094] = "general",
		[192072] = "normal",
		[196563] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ImpalingSpear", 192094)
	self:Log("SPELL_AURA_REMOVED", "ImpalingSpearOver", 192094)
	self:Log("SPELL_AURA_APPLIED", "ThrowSpear", 192131)
	self:Log("SPELL_CAST_SUCCESS", "CallReinforcementsNormal", 192072, 192073)
	self:Log("SPELL_CAST_SUCCESS", "CallReinforcements", 196563)
	self:Log("SPELL_AURA_APPLIED", "Enrage", 197064)
	self:Log("SPELL_CAST_START", "Restoration", 197502)
	self:Log("SPELL_CAST_START", "CrashingWave", 191900)

	self:Log("SPELL_AURA_APPLIED", "QuicksandDamage", 192053)
	self:Log("SPELL_PERIODIC_DAMAGE", "QuicksandDamage", 192053)
	self:Log("SPELL_PERIODIC_MISSED", "QuicksandDamage", 192053)
end

function mod:OnEngage()
	addCount = 1
	self:CDBar(192094, self:Normal() and 35 or 29) -- Impaling Spear
	self:CDBar(self:Normal() and 192072 or 196563, 5) -- Call Reinforcements
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ImpalingSpear(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "warning")
	self:CDBar(args.spellId, 27) -- pull:35.0, 31.6 / hc pull:29.2, 29.2, 26.8 / m pull:29.1, 28.0, 28.3, 27.5
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Impaling Spear")
		self:Flash(args.spellId)
	end
end

function mod:ImpalingSpearOver(args)
	self:PrimaryIcon(args.spellId)
end

function mod:ThrowSpear(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessageOld(args.spellId, args.destName, "red", "alarm", nil, nil, true)
	end
end

do
	function mod:CallReinforcementsNormal(args) -- Normal only
		--["192073-Call Reinforcements"] = "pull:26.0, 52.3",
		--["192072-Call Reinforcements"] = "pull:5.4, 52.3, 52.2",
		self:MessageOld(192072, "yellow", "info", args.spellName, args.spellId)
		self:CDBar(192072, addCount % 2 == 0 and 31 or 20, args.spellName, args.spellId == 192072 and 192073 or 192072) -- Use correct icon for upcoming add
		addCount = addCount + 1
	end
	function mod:CallReinforcements(args) -- Heroic +
		self:MessageOld(args.spellId, "yellow", "info")
		self:CDBar(args.spellId, 28) -- hc pull:5.4, 31.6, 31.6, 27.9, 29.2 / m pull:5.7, 31.5, 28.0, 27.9, 27.9
	end
end

function mod:Enrage(args)
	self:MessageOld(args.spellId, "orange", "alert", CL.percent:format(30, args.spellName))
end

function mod:Restoration(args)
	self:MessageOld(args.spellId, "green", self:Interrupter() and "warning" or "long", CL.casting:format(args.spellName))
end

function mod:CrashingWave(args)
	self:MessageOld(args.spellId, "yellow", "alert", CL.casting:format(args.spellName))
end

do
	local prev = 0
	function mod:QuicksandDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end
