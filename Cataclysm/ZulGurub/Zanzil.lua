-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Zanzil", 793)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(52053)
mod.toggleOptions = {
	96914, -- Zanzili Fire
	96316, -- Zanzil's Resurrection Elixir
	96338, -- Zanzil's Graveyard Gas
	96342, -- Pursuit
	"bosskill",
}

--------------------------------------------------------------------------------
--  Locals

local gaze = GetSpellInfo(96342)

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Elixir", 96316)
	self:Log("SPELL_AURA_APPLIED", "Pursuit", 96506)
	self:Log("SPELL_AURA_REMOVED", "PursuitRemoved", 96506)
	self:Log("SPELL_CAST_START", "Fire", 96914)
	self:Log("SPELL_CAST_START", "Gas", 96338)
	self:Log("SPELL_CAST_START", "Gaze", 96342)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 52053)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Gas(_, spellId, _, _, spellName)
	self:Message(96338, LW_CL["casting"]:format(spellName), "Attention", spellId, "Alert")
	self:Bar(96338, spellName, 7, spellId)
end

function mod:Elixir(_, spellId, _, _, spellName)
	self:Message(96316, spellName, "Attention", spellId, "Alert")
end

function mod:Fire(source, spellId, _, _, spellName)
	if UnitIsPlayer(source) then return end
	self:Message(96914, spellName, "Attention", spellId, "Info")
end

do
	local function checkTarget(sGUID)
		local mobId = mod:GetUnitIdByGUID(sGUID)
		if mobId then
			local player = UnitName(mobId.."target")
			if not player then -- debug
				print("Zanzili Berserker: No target found! Please report this to the Little Wigs authors.")
				return
			end
			if UnitIsUnit("player", player) then
				mod:FlashShake(96342)
			end
			mod:TargetMessage(96342, gaze, player, "Important", 96342, "Alert")
			mod:PrimaryIcon(96342, player)
		end
	end
	function mod:Gaze(...)
		local sGUID = select(11, ...)
		self:ScheduleTimer(checkTarget, 0.3, sGUID)
	end
end

function mod:Pursuit(player, spellId, _, _, player)
	self:TargetMessage(96342, gaze, player, "Important", 96342, "Alert")
	self:PrimaryIcon(96342, player)
end

function mod:PursuitRemoved()
	self:PrimaryIcon(96342)
end

