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

	L.mechanics = -5999 -- Steamrigger Mechanics
	L.mechanics_icon = "inv_misc_wrench_01"
end

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		31485, -- Super Shrink Ray
		"mechanics", -- Steamrigger Mechanics
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "SuperShrinkRay", 31485)

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL") -- no locale-independent events
	if self:Classic() then
		self:RegisterEvent("UNIT_HEALTH")
	else
		self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	end
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
		self:Message("mechanics", "yellow", CL.incoming:format(self:SpellName(-5999)), L.mechanics_icon) -- Steamrigger Mechanics
	end
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) == 17796 then
		local hp = self:GetHealth(unit)
		if hp < nextAddWarning then
			nextAddWarning = nextAddWarning - 25
			self:Message("mechanics", "red", CL.soon:format(self:SpellName(-5999)), false) -- Steamrigger Mechanics
			while nextAddWarning >= 25 and hp < nextAddWarning do
				-- account for high-level characters hitting multiple thresholds
				nextAddWarning = nextAddWarning - 25
			end
			if nextAddWarning < 25 then
				if self:Classic() then
					self:UnregisterEvent(event)
				else
					self:UnregisterUnitEvent(event, unit)
				end
			end
		end
	end
end
