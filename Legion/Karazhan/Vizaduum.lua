
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Viz'aduum the Watcher", 1115, 1838)
if not mod then return end
mod:RegisterEnableMob(114790)
mod.engageId = 2017

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		229151, -- Disintegrate
		{229248, "SAY"}, -- Fel Beam
		{229159, "SAY"}, -- Chaotic Shadows
		229610, -- Demonic Portal
		230084, -- Stabilize Rift
		229083, -- Burning Blast
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Disintegrate", 229151)
	self:Log("SPELL_AURA_APPLIED", "AcquiringTarget", 229241) -- Fel Beam
	self:Log("SPELL_AURA_APPLIED", "ChaoticShadows", 229159)
	self:Log("SPELL_CAST_SUCCESS", "DemonicPortal", 229610)
	self:Log("SPELL_AURA_APPLIED", "StabilizeRift", 230084)
	self:Log("SPELL_CAST_START", "BurningBlast", 229083)
	self:Log("SPELL_AURA_APPLIED", "BurningBlastApplied", 229083)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Disintegrate(args)
	self:Message(args.spellId, "Attention", "Alert")
end

function mod:AcquiringTarget(args)
	self:TargetMessage(229248, args.destName, "Urgent", "Alarm")
	if self:Me(args.destGUID) then
		self:Say(229248)
	end
end

do
	local list = mod:NewTargetList()
	function mod:ChaoticShadows(args)
		list[#list+1] = args.destName
		if #list == 1 then
			self:ScheduleTimer("TargetMessage", 0.5, args.spellId, list, "Important", "Warning", nil, nil, self:Dispeller("magic"))
		end
		if self:Me(args.destGUID) then
			self:Say(args.spellId)
		end
	end
end

function mod:DemonicPortal(args)
	self:Message(args.spellId, "Neutral", "Long")
end

function mod:StabilizeRift(args)
	self:Message(args.spellId, "Urgent", "Alarm")
end

function mod:BurningBlast(args)
	self:Message(args.spellId, "Attention", self:Interrupter() and "Alarm", CL.casting:format(args.spellName))
end

function mod:BurningBlastApplied(args)
	if self:Dispeller("magic") then
		self:TargetMessage(args.spellId, args.destName, "Important", "Info")
	end
end
