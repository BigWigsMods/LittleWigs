-------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Captain Skarloc", 560, 539)
if not mod then return end
mod:RegisterEnableMob(
	17862, -- Captain Skarloc
	17860, -- Durnholde Veteran
	17833 -- Durnholde Warden
)
mod.engageId = 1907
-- mod.respawnTime = 0 -- you have to free Thrall again if you wipe

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	-- Thrall! You didn't really think you would escape, did you?  You and your allies shall answer to Blackmoore... after I've had my fun.
	L.warmup_trigger = "answer to Blackmoore"
end


-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"warmup",
		38385, -- Consecration
		13005, -- Hammer of Justice
		{29427, "CASTBAR"}, -- Holy Light
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")

	self:Log("SPELL_DAMAGE", "Consecration", 38385)
	self:Log("SPELL_MISSED", "Consecration", 38385)
	self:Log("SPELL_AURA_APPLIED", "HammerOfJustice", 13005)
	self:Log("SPELL_AURA_REMOVED", "HammerOfJusticeRemoved", 13005)
	self:Log("SPELL_CAST_START", "HolyLight", 29427)
	self:Log("SPELL_INTERRUPT", "Interrupt", "*")
end

function mod:VerifyEnable(_, mobId)
	if mobId == 17862 then return true end

	-- Durnholde Veteran and Durnholde Warden are trash mobs
	if not self:Classic() then
		local _, _, completedFirst = C_Scenario.GetCriteriaInfo(1)
		local _, _, completedSecond = C_Scenario.GetCriteriaInfo(2)
		return completedFirst and not completedSecond
	end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:CHAT_MSG_MONSTER_SAY(event, msg)
	if msg:find(L.warmup_trigger, nil, true) then
		self:UnregisterEvent(event)
		self:Bar("warmup", 7.9, CL.active, "inv_sword_01")
	end
end

do
	local prev = 0
	function mod:Consecration(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:MessageOld(args.spellId, "blue", "alarm", CL.underyou:format(args.spellName))
		end
	end
end

function mod:HammerOfJustice(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessageOld(args.spellId, args.destName, "red", "warning")
		self:TargetBar(args.spellId, 5, args.destName)
	end
end

function mod:HammerOfJusticeRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:HolyLight(args)
	self:MessageOld(args.spellId, "orange", "alert", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 2.5)
end

function mod:Interrupt(args)
	if args.extraSpellId == 29427 then -- Holy Light
		self:StopBar(CL.cast:format(args.extraSpellName))
	end
end
