if not IsTestBuild() then return end -- XXX dont load on live
--------------------------------------------------------------------------------
-- TODO List:
-- - Mythic Abilities

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mephistroth", 1146, 1878)
if not mod then return end
mod:RegisterEnableMob(116944)
mod.engageId = 2039

--------------------------------------------------------------------------------
-- Locals
--

local phase = 1
local timeLost = 0
local upheavalWarned = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		233155, -- Carrion Swarm
		233196, -- Demonic Upheaval
		{234817, "PROXIMITY"}, -- Dark Solitude
		233206, -- Shadow Fade
	},{
		[233155] = -14949,
		[233206] = -14950,
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3", "boss4", "boss5")
	self:Log("SPELL_CAST_START", "CarrionSwarm", 233155)
	self:Log("SPELL_CAST_START", "DemonicUpheaval", 233196)
	self:RegisterEvent("UNIT_AURA") -- Demonic Upheaval debuff tracking
	self:Log("SPELL_CAST_START", "DarkSolitude", 234817)
	self:Log("SPELL_AURA_APPLIED", "ShadowFade", 233206)
	self:Log("SPELL_AURA_REMOVED", "ShadowFadeRemoved", 233206)
end

function mod:OnEngage()
	phase = 1
	timeLost = 0
	wipe(upheavalWarned)
	self:OpenProximity(234817, 8) -- Dark Solitude

	self:Bar(234817, 8.2) -- Dark Solitude
	self:Bar(233155, 15.6) -- Carrion Swarm
	self:Bar(233196, 29.9) -- Demonic Upheaval
	self:Bar(233206, 39.9) -- Shadow Fade
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 234283 then -- Expel Shadows
		if phase == 2 then
			self:Message(233206, "Attention", "Warning", 234283)
			local timeLeft = self:BarTimeLeft(233206) -- Shadow Fade
			stopBar(233206) -- Shadow Fade
			local newTime = timeLeft + 7.5
			timeLost = timeLost + 7.5
			self:Bar(233206, newTime <= 30 and newTime or 30, ""..self:SpellName(233206).."(+"..timeLost..")") -- Takes 30s to go from 0-300 UNIT_POWER, max 30s bar.
		end
	end
end

function mod:CarrionSwarm(args)
	self:Message(args.spellId, "Attention", "Alarm")
	if self:BarTimeLeft(233206) > 18.2 then -- Shadow Fade
		self:Bar(args.spellId, 18.2)
	end
end

function mod:DemonicUpheaval(args)
	self:Message(args.spellId, "Attention", "Alert", CL.incoming:format(args.spellName))
	if self:BarTimeLeft(233206) > 31.9 then -- Shadow Fade
		self:Bar(args.spellId, 31.9)
	end
end

do
	local list, guid = mod:NewTargetList(), nil
	function mod:UNIT_AURA(event, unit)
		local name = UnitDebuff(unit, self:SpellName(233963)) -- Demonic Upheaval Debuff Id
		local n = self:UnitName(unit)
		if upheavalWarned[n] and not name then
			upheavalWarned[n] = nil
		elseif name and not upheavalWarned[n] then
			guid = UnitGUID(n)
			list[#list+1] = n
			if #list == 1 then
				self:ScheduleTimer("TargetMessage", 0.1, 233196, list, "Important", "Warning", 233963, nil, true)
			end
			if self:Me(guid) then
				self:Say(233196)
				self:Flash(233196)
			end
			upheavalWarned[n] = true
		end
	end
end

function mod:DarkSolitude(args)
	self:Message(args.spellId, "Attention", "Alarm")
	if self:BarTimeLeft(233206) > 9 then -- Shadow Fade
		self:CDBar(args.spellId, 9)
	end
end

function mod:ShadowFade(args)
	phase = 2
	timeLost = 0
	self:CloseProximity(234817) -- Dark Solitude
	self:Message(args.spellId, "Positive", "Long")
	self:Bar(args.spellId, 34)
end

function mod:ShadowFadeRemoved(args)
	phase = 1
	self:OpenProximity(234817, 8) -- Dark Solitude
	self:Message(args.spellId, "Positive", "Long", CL.removed:format(args.spellName))
	self:Bar(args.spellId, 79.3)
	self:Bar(234817, 7.8) -- Dark Solitude
	self:Bar(233155, 15) -- Carrion Swarm
	self:Bar(233196, 31) -- Demonic Upheaval
end
