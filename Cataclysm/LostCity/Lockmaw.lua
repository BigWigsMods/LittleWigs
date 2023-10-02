--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Lockmaw", 755, 118)
if not mod then return end
mod:RegisterEnableMob(43614, 49045) -- Lockmaw, Augh
--mod.engageId = 1054 -- ENCOUNTER_END fires after Lockmaw's death, Augh doesn't fire either
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Lockmaw
		81630, -- Viscous Poison
		{81690, "ICON", "FLASH"}, -- Scent of Blood
		-- Augh
		"stages",
		84784, -- Whirlwind
	},{
		[81630] = -2442,
		["stages"] = -2449,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ViscousPoison", 81630)
	self:Log("SPELL_AURA_REMOVED", "ViscousPoisonRemoved", 81630)
	self:Log("SPELL_AURA_APPLIED", "ScentOfBlood", 81690)
	self:Log("SPELL_AURA_APPLIED", "Whirlwind", 84784, 91408)

	self:Death("Deaths", 43614, 49045) -- Lockmaw, Augh
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Deaths(args)
	if not self:Normal() then
		-- in Heroic and Timewalking difficulty you have to fight Augh after Lockmaw
		if args.mobId == 49045 then -- Augh
			self:Win()
		else -- Lockmaw
			self:Bar("stages", 17, -2442, "spell_nature_sleep")
		end
	elseif args.mobId == 43614 then -- Lockmaw
		self:Win()
	end
end

function mod:ViscousPoison(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow")
	self:Bar(args.spellId, 12, args.destName)
end

function mod:ViscousPoisonRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:ScentOfBlood(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "alert")
	self:Bar(args.spellId, 30, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
end

function mod:Whirlwind(args)
	self:MessageOld(84784, "orange")
	if args.spellId == 91408 then
		self:CDBar(84784, 26)
	end
end
