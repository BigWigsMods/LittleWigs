-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mekgineer Steamrigger", 545, 574)
if not mod then return end
mod:RegisterEnableMob(17796)
mod.engageId = 1943
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Locals
--

local nextAddWarning = 80

-------------------------------------------------------------------------------
--  Localization
--

local L = mod:GetLocale()
if L then
	L.mech_trigger = "Tune 'em up good, boys!"
end

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		31485, -- Super Shrink Ray
		-5999, -- Steamrigger Mechanics
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "SuperShrinkRay", 31485)

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL") -- no locale-independent events
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
end

function mod:OnEngage()
	nextAddWarning = 80 -- 75%, 50% and 25%
end

-------------------------------------------------------------------------------
--  Event Handlers


do
	local playerList = mod:NewTargetList()
	function mod:SuperShrinkRay(args)
		playerList[#playerList+1] = args.destName
		if #playerList == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.3, args.spellId, playerList, "orange", "alert")
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg == L.mech_trigger or msg:find(L.mech_trigger, nil, true) then
		self:MessageOld(-5999, "yellow", nil, CL.incoming:format(self:SpellName(-5999))) -- Steamrigger Mechanics
	end
end

do
	function mod:UNIT_HEALTH(event, unit)
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < nextAddWarning then
			nextAddWarning = nextAddWarning - 25
			self:MessageOld(-5999, "red", nil, CL.soon:format(self:SpellName(-5999))) -- Steamrigger Mechanics

			while nextAddWarning >= 25 and hp < nextAddWarning do
				-- account for high-level characters hitting multiple thresholds
				nextAddWarning = nextAddWarning - 25
			end

			if nextAddWarning < 25 then
				self:UnregisterUnitEvent(event, unit)
			end
		end
	end
end
