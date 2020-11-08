
--------------------------------------------------------------------------------
-- TODO:
-- -- Ravaging Darkness Target?
-- -- Dread Screech warnings for interupters only?

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Saprish", 1753, 1980)
if not mod then return end
mod:RegisterEnableMob(122316, 122319, 125340) -- Saprish, Darkfang, Duskwing
mod.engageId = 2066

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Saprish ]]--
		245873, -- Void Trap
		247206, -- Overload Trap
		{247245, "SAY"}, -- Umbral Flanking

		--[[ Darkfang ]]--
		245802, -- Ravaging Darkness

		--[[ Duskwing (Mythic) ]]--
		248831, -- Dread Screech
	},{
		[248831] = "mythic",
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3")

	--[[ Saprish ]]--
	self:Log("SPELL_CAST_SUCCESS", "VoidTrap", 247175)
	self:Log("SPELL_CAST_SUCCESS", "UmbralFlanking", 247245)
	self:Log("SPELL_AURA_APPLIED", "UmbralFlankingApplied", 247245)

	--[[ Darkfang ]]--
	self:Log("SPELL_CAST_START", "RavagingDarkness", 245802)
	self:Log("SPELL_DAMAGE", "RavagingDarknessDamage", 245803)
	self:Log("SPELL_MISSED", "RavagingDarknessDamage", 245803)

	--[[ Duskwing (Mythic) ]]--
	self:Log("SPELL_CAST_START", "DreadScreech", 248831)
end

function mod:OnEngage()
	self:Bar(245802, 3) -- Ravaging Darkness
	if self:Mythic() then
		self:Bar(248831, 5.5) -- Dread Screech
	end
	self:Bar(245873, 8) -- Void Trap
	self:Bar(247206, 12) -- Overload Trap
	self:Bar(247245, 20.5) -- Umbral Flanking
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 247206 then -- Overload Trap
		self:MessageOld(spellId, "yellow", "alarm")
		self:Bar(spellId, 20.7)
	end
end

function mod:VoidTrap()
	self:MessageOld(245873, "cyan", "info")
	self:Bar(245873, 15.8)
end

function mod:UmbralFlanking(args)
	self:Bar(args.spellId, 35.2)
end

do
	local list = mod:NewTargetList()
	function mod:UmbralFlankingApplied(args)
		list[#list+1] = args.destName
		if #list == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.3, args.spellId, list, "orange", "alert")
		end
		if self:Me(args.destGUID)then
			self:Say(args.spellId)
		end
	end
end

function mod:RavagingDarkness(args)
	self:MessageOld(args.spellId, "yellow", "long")
	self:Bar(args.spellId, 9.7)
end

do
	local prev = 0
	function mod:RavagingDarknessDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:MessageOld(245802, "blue", "alert", CL.underyou:format(args.spellName))
			end
		end
	end
end

function mod:DreadScreech(args)
	self:MessageOld(args.spellId, "red", "warning")
	self:CDBar(args.spellId, 15)
end
